local LibComp = LibStub:GetLibrary("LibCompress")
local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"

Altoholic.Comm = {}

-- Message types
local MSG_ACCOUNT_SHARING_REQUEST			= 1
local MSG_ACCOUNT_SHARING_REFUSED			= 2
local MSG_ACCOUNT_SHARING_REFUSEDINCOMBAT	= 3
local MSG_ACCOUNT_SHARING_REFUSEDDISABLED	= 4
local MSG_ACCOUNT_SHARING_ACCEPTED			= 5
local MSG_ACCOUNT_SHARING_SENDITEM			= 6
local MSG_ACCOUNT_SHARING_COMPLETED			= 7
local MSG_ACCOUNT_SHARING_ACK					= 8	-- a simple ACK message, confirms message has been received, but no data is sent back

local CMD_DATASTORE_XFER			= 100
local CMD_DATASTORE_CHAR_XFER		= 101		-- these 2 require a special treatment
local CMD_DATASTORE_STAT_XFER		= 102
local CMD_BANKTAB_XFER				= 103
local CMD_REFDATA_XFER				= 104


local TOC_SEP = "|"	-- separator used between items

-- TOC Item Types
local TOC_SETREALM				= "1"
local TOC_SETGUILD				= "2"
local TOC_BANKTAB					= "3"
local TOC_SETCHAR					= "4"
local TOC_DATASTORE				= "5"
local TOC_REFDATA					= "6"



--[[	*** Protocol ***

Client				Server

==> MSG_ACCOUNT_SHARING_REQUEST 
<== MSG_ACCOUNT_SHARING_REFUSED (stop)   
or 
<== MSG_ACCOUNT_SHARING_ACCEPTED (receives the TOC)

while toc not empty
==> MSG_ACCOUNT_SHARING_SENDNEXT (pass the type, based on the TOC)
<== CMD_??? (transfer & save data)
wend

==> MSG_ACCOUNT_SHARING_COMPLETED

--]]

Altoholic.Comm.Sharing = {}
Altoholic.Comm.Sharing.Callbacks = {
	[MSG_ACCOUNT_SHARING_REQUEST] = "OnSharingRequest",
	[MSG_ACCOUNT_SHARING_REFUSED] = "OnSharingRefused",
	[MSG_ACCOUNT_SHARING_REFUSEDINCOMBAT] = "OnPlayerInCombat",
	[MSG_ACCOUNT_SHARING_REFUSEDDISABLED] = "OnSharingDisabled",
	[MSG_ACCOUNT_SHARING_ACCEPTED] = "OnSharingAccepted",
	[MSG_ACCOUNT_SHARING_SENDITEM] = "OnSendItemReceived",
	[MSG_ACCOUNT_SHARING_COMPLETED] = "OnSharingCompleted",
	[MSG_ACCOUNT_SHARING_ACK] = "OnAckReceived",

	[CMD_DATASTORE_XFER] = "OnDataStoreReceived",
	[CMD_DATASTORE_CHAR_XFER] = "OnDataStoreCharReceived",
	[CMD_DATASTORE_STAT_XFER] = "OnDataStoreStatReceived",
	[CMD_BANKTAB_XFER] = "OnGuildBankTabReceived",
	[CMD_REFDATA_XFER] = "OnRefDataReceived",
}

local compressionMode = 1
local importedChars

local function Whisper(player, messageType, ...)
	local serializedData = Altoholic:Serialize(messageType, ...)
	--DEFAULT_CHAT_FRAME:AddMessage(strlen(serializedData))
	
	-- if compressionMode == 1 then				-- no comp
		Altoholic:SendCommMessage("AltoShare", serializedData, "WHISPER", player)
		
	-- elseif compressionMode == 2 then		-- comp huff
		-- local compData = LibComp:CompressHuffman(serializedData)
		
		-- local ser, comp
		-- ser = strlen(serializedData)
		-- comp = strlen(compData)
		-- DEFAULT_CHAT_FRAME:AddMessage(format("Compression (%d/%d) : %2.1f", ser, comp, (comp/ser)*100))
		
		-- Altoholic:SendCommMessage("AltoShare", compData, "WHISPER", player)

	-- elseif compressionMode == 3 then		-- comp lzw
		-- local compData = LibComp:CompressLZW(serializedData)
		
		-- local ser, comp
		-- ser = strlen(serializedData)
		-- comp = strlen(compData)
		-- DEFAULT_CHAT_FRAME:AddMessage(format("Compression (%d/%d) : %2.1f", ser, comp, (comp/ser)*100))
		
		-- Altoholic:SendCommMessage("AltoShare", compData, "WHISPER", player)
	-- end
end

local function GetRequestee()
	local player	-- name of the player to whom the account sharing request will be sent
	
	if AltoAccountSharing_UseTarget:GetChecked() then
		player = UnitName("target")
	elseif AltoAccountSharing_UseName:GetChecked() then
		player = AltoAccountSharing_AccTargetEditBox:GetText()
	end

	if player and strlen(player) > 0 then
		return player
	end
end

local function SetStatus(text)
	AltoAccountSharingTransferStatus:SetText(text)
end

function Altoholic:AccSharingHandler(prefix, message, distribution, sender)
	-- 	since Ace 3 communication handlers cannot be enabled/disabled on the fly, 
	--	let's use a function pointer to either an empty function, or the normal one
	local self = Altoholic.Comm.Sharing

	if self and self.msgHandler then
		self[self.msgHandler](self, prefix, message, distribution, sender)
	end
end

function Altoholic.Comm.Sharing:SetMessageHandler(handler)
	self.msgHandler = handler
end

function Altoholic.Comm.Sharing:EmptyHandler(prefix, message, distribution, sender)
	-- automatically reply that the option is disabled
	Whisper(sender, MSG_ACCOUNT_SHARING_REFUSEDDISABLED)
end

function Altoholic.Comm.Sharing:ActiveHandler(prefix, message, distribution, sender)
	local success, msgType, msgData
	
	if compressionMode == 1 then	
		success, msgType, msgData = Altoholic:Deserialize(message)
	else
		local decompData = LibComp:Decompress(message)
		success, msgType, msgData = Altoholic:Deserialize(decompData)
	end
	
	if not success then
		self.SharingEnabled = nil
		-- self:Print(msgType)
		-- self:Print(string.sub(decompData, 1, 15))
		return
	end
	
	if success and msgType then
		local comm = Altoholic.Comm.Sharing
		local cb = comm.Callbacks[msgType]
		
		if cb then
			comm[cb](self, sender, msgData)		-- process the message
		end
	end
end

function Altoholic.Comm.Sharing:Request()

	local account = AltoAccountSharing_AccNameEditBox:GetText()
	if not account or strlen(account) == 0 then 		-- account name cannot be empty
		Altoholic:Print("[" .. L["Account Name"] .. "] " .. L["This field |cFF00FF00cannot|r be left empty."])
		return 
	end
	
	self.account = account

	local player = GetRequestee()
	if player then
		self.SharingInProgress = true
		-- AltoAccountSharing:Hide()
		-- Altoholic:Print(format(L["Sending account sharing request to %s"], player))
		SetStatus(format("Getting table of content from %s", player))
		Whisper(player, MSG_ACCOUNT_SHARING_REQUEST)
	end
end

local function ImportCharacters()
	-- once data has been transfered, finalize the import by acknowledging that these alts can be seen by client addons
	-- will be changed when account sharing goes into datastore.
	for k, v in pairs(importedChars) do
		DataStore:ImportCharacter(k, v.faction, v.guild)
	end
	importedChars = nil
end

function Altoholic.Comm.Sharing:RequestNext(player)
	self.NetDestCurItem = self.NetDestCurItem + 1
	local index = self.NetDestCurItem

	-- find the next checked item
	local isChecked = Altoholic.Sharing.AvailableContent:IsItemChecked(index)
	while not isChecked and index <= #self.DestTOC do
		index = index + 1
		isChecked = Altoholic.Sharing.AvailableContent:IsItemChecked(index)
	end

	if isChecked and index <= #self.DestTOC then
		SetStatus(format("Transfering item %d/%d", index, #self.DestTOC ))
		local TocData = self.DestTOC[index]
		
		local TocType = strsplit(TOC_SEP, TocData)
			
		if TocType == TOC_SETREALM then
			_, self.ClientRealmName = strsplit(TOC_SEP, TocData)
		elseif TocType == TOC_SETGUILD then
			_, self.ClientGuildName = strsplit(TOC_SEP, TocData)
			
		elseif TocType == TOC_BANKTAB then
		elseif TocType == TOC_SETCHAR then
			_, self.ClientCharName = strsplit(TOC_SEP, TocData)
			
		elseif TocType == TOC_DATASTORE then
			
		elseif TocType == TOC_REFDATA then
		end
		
		Whisper(player, MSG_ACCOUNT_SHARING_SENDITEM, index)
		self.NetDestCurItem = index
		return
	end

	ImportCharacters()
	SetStatus(L["Transfer complete"])
	Whisper(player, MSG_ACCOUNT_SHARING_COMPLETED)

	wipe(self.DestTOC)
	self.DestTOC = nil
	
	self.SharingInProgress = nil
	self.SharingEnabled = nil
	self.NetDestCurItem = nil
	self.ClientRealmName = nil
	self.ClientGuildName = nil
	self.ClientCharName = nil
	
	Altoholic.Sharing.AvailableContent:Clear()
	self:SetMode(1)
	
	Altoholic:SetLastAccountSharingInfo(player, GetRealmName(), self.account)
	
	Altoholic.Characters:BuildList()
	Altoholic.Characters:BuildView()
	Altoholic.Tabs.Summary:Refresh()
end

function Altoholic.Comm.Sharing:MsgBoxHandler(button)

	local self = Altoholic.Comm.Sharing
	
	AltoMsgBox.ButtonHandler = nil		-- prevent any other call to msgbox from coming back here
	local sender = AltoMsgBox.Sender
	AltoMsgBox.Sender = nil
	
	if not button then 
		Whisper(sender, MSG_ACCOUNT_SHARING_REFUSED)
		return 
	end

	self:SendSourceTOC(sender)
end

local AUTH_AUTO	= 1
local AUTH_ASK		= 2
local AUTH_NEVER	= 3

function Altoholic.Comm.Sharing:OnSharingRequest(sender, data)
	self.SharingEnabled = nil
	
	if UnitAffectingCombat("player") ~= nil then
		-- automatically reject if requestee is in combat
		Whisper(sender, MSG_ACCOUNT_SHARING_REFUSEDINCOMBAT)
		return
	end
	
	local auth = Altoholic.Sharing.Clients:GetRights(sender)
	
	if not auth then		-- if the sender is not a known client, add him with defaults rights (=ask)
		Altoholic.Sharing.Clients:Add(sender)
		auth = AUTH_ASK
	end
	
	if auth == AUTH_AUTO then
		self:SendSourceTOC(sender)
	elseif auth == AUTH_ASK then
		Altoholic:Print(format(L["Account sharing request received from %s"], sender))
		AltoMsgBox:SetHeight(130)
		AltoMsgBox_Text:SetHeight(60)
		AltoMsgBox.ButtonHandler = Altoholic.Comm.Sharing.MsgBoxHandler
		AltoMsgBox.Sender = sender
		AltoMsgBox_Text:SetText(format(L["You have received an account sharing request\nfrom %s%s|r, accept it?"], WHITE, sender) .. "\n\n"
								.. format(L["%sWarning:|r if you accept, %sALL|r information known\nby Altoholic will be sent to %s%s|r (bags, money, etc..)"], WHITE, GREEN, WHITE,sender))
		AltoMsgBox:Show()
	elseif auth == AUTH_NEVER then
		Whisper(sender, MSG_ACCOUNT_SHARING_REFUSED)
	end
end

function Altoholic.Comm.Sharing:SendSourceTOC(sender)
	self.SharingEnabled = true
	self.SourceTOC = Altoholic.Sharing.Content:GetSourceTOC()
	-- self.NetSrcCurItem = 0					-- to display that item is 1 of x
	self.AuthorizedRecipient = sender
	Altoholic:Print(format(L["Sending table of content (%d items)"], #self.SourceTOC))
	Whisper(sender, MSG_ACCOUNT_SHARING_ACCEPTED, self.SourceTOC)
end

function Altoholic.Comm.Sharing:GetContent()
	local player = GetRequestee()
	if player then
		self:SetMode(3)
		self:RequestNext(player)
	end
end

function Altoholic.Comm.Sharing:GetAccount()
	return self.account
end

function Altoholic.Comm.Sharing:SetMode(mode)
	local button = AltoAccountSharing_SendButton
	if mode == 1 then			-- send request, expect toc in return
		button:SetText("Send Request")
		button:Enable()
		button.requestMode = nil	
	elseif mode == 2 then	-- request content, get data in return
		button:SetText("Request Content")
		button:Enable()
		button.requestMode = true	
	elseif mode == 3 then
		importedChars = importedChars or {}
		wipe(importedChars)
		button:Disable()
	end
end

function Altoholic.Comm.Sharing:OnSharingRefused(sender, data)
	SetStatus(format(L["Request rejected by %s"], sender))
	self.SharingInProgress = nil
end

function Altoholic.Comm.Sharing:OnPlayerInCombat(sender, data)
	SetStatus(format(L["%s is in combat, request cancelled"], sender))
	self.SharingInProgress = nil
end

function Altoholic.Comm.Sharing:OnSharingDisabled(sender, data)
	SetStatus(format(L["%s has disabled account sharing"], sender))
	self.SharingInProgress = nil
end

function Altoholic.Comm.Sharing:OnSharingAccepted(sender, data)
	self.DestTOC = data
	self.NetDestCurItem = 0
	SetStatus(format(L["Table of content received (%d items)"], #self.DestTOC))
	
	-- build & refresh the scroll frame
	Altoholic.Sharing.AvailableContent:BuildView()
	Altoholic.Sharing.AvailableContent:Update()
	
	-- change the text on the 'send' button 
	self:SetMode(2)
end

-- Send Content
function Altoholic.Comm.Sharing:OnSendItemReceived(sender, data)
	-- Server side, a request to send a given item is processed here
	if not self.SharingEnabled or not self.AuthorizedRecipient then
		return
	end
	
	local DS = DataStore
	local index = tonumber(data)		-- get the index of the item in the toc
		
	local TocData = self.SourceTOC[index]
	local TocType = strsplit(TOC_SEP, TocData)		-- get its type
		
	if TocType == TOC_SETREALM then
		_, self.ServerRealmName = strsplit(TOC_SEP, TocData)
		Whisper(self.AuthorizedRecipient, MSG_ACCOUNT_SHARING_ACK)
	elseif TocType == TOC_SETGUILD then
		_, self.ServerGuildName = strsplit(TOC_SEP, TocData)
		Whisper(self.AuthorizedRecipient, MSG_ACCOUNT_SHARING_ACK)
	elseif TocType == TOC_BANKTAB then
		local _, _, tabID = strsplit(TOC_SEP, TocData)
		tabID = tonumber(tabID)
		local guild = DS:GetGuild(self.ServerGuildName, self.ServerRealmName)
		Whisper(self.AuthorizedRecipient, CMD_BANKTAB_XFER, DS:GetGuildBankTab(guild, tabID))
	elseif TocType == TOC_SETCHAR then		-- character ? send mandatory modules (char definition = DS_Char + DS_Stats)
		_, self.ServerCharacterName = strsplit(TOC_SEP, TocData)
		Whisper(self.AuthorizedRecipient, CMD_DATASTORE_CHAR_XFER, DS:GetCharacterTable("DataStore_Characters", self.ServerCharacterName, self.ServerRealmName))
		Whisper(self.AuthorizedRecipient, CMD_DATASTORE_STAT_XFER, DS:GetCharacterTable("DataStore_Stats", self.ServerCharacterName, self.ServerRealmName))
	
	elseif TocType == TOC_DATASTORE then	-- DS ? Send the appropriate DS module
		local _, moduleID = strsplit(TOC_SEP, TocData)
		local moduleName = Altoholic.Sharing.Content:GetOptionalModuleName(tonumber(moduleID))
		Whisper(self.AuthorizedRecipient, CMD_DATASTORE_XFER, DS:GetCharacterTable(moduleName, self.ServerCharacterName, self.ServerRealmName))
		
	elseif TocType == TOC_REFDATA then
		local _, class = strsplit(TOC_SEP, TocData)
		Whisper(self.AuthorizedRecipient, CMD_REFDATA_XFER, DS:GetClassReference(class))
	end
end

function Altoholic.Comm.Sharing:OnSharingCompleted(sender, data)
	self.SharingEnabled = nil
	self.AuthorizedRecipient = nil
	self.ServerRealmName = nil
	self.ServerGuildName = nil
	self.ServerCharacterName = nil
	wipe(self.SourceTOC)
	
	self.SourceTOC = nil
	Altoholic:Print(L["Transfer complete"])
end

function Altoholic.Comm.Sharing:OnAckReceived(sender, data)
	self:RequestNext(sender)
end


-- Receive content
function Altoholic.Comm.Sharing:OnDataStoreReceived(sender, data)
	local TocData = self.DestTOC[self.NetDestCurItem]
	local _, moduleID = strsplit(TOC_SEP, TocData)
	local moduleName = Altoholic.Sharing.Content:GetOptionalModuleName(tonumber(moduleID))
	
	DataStore:ImportData(moduleName, data, self.ClientCharName, self.ClientRealmName, self.account)
	self:RequestNext(sender)
end

function Altoholic.Comm.Sharing:OnDataStoreCharReceived(sender, data)
	DataStore:ImportData("DataStore_Characters", data, self.ClientCharName, self.ClientRealmName, self.account)

	-- temporarily deal with this here, will be changed when account sharing goes to  DataStore.
	local key = format("%s.%s.%s", self.account, self.ClientRealmName, self.ClientCharName)
	
	importedChars[key] = {}
	importedChars[key].faction = data.faction
	importedChars[key].guild = data.guildName
	
	-- NO REQUEST NEXT HERE !!
end

function Altoholic.Comm.Sharing:OnDataStoreStatReceived(sender, data)
	DataStore:ImportData("DataStore_Stats", data, self.ClientCharName, self.ClientRealmName, self.account)
	-- Request next, to resume transfer after processing mandatory data
	self:RequestNext(sender)
end

function Altoholic.Comm.Sharing:OnGuildBankTabReceived(sender, data)
	local TocData = self.DestTOC[self.NetDestCurItem]
	local _, _, tabID = strsplit(TOC_SEP, TocData)
	tabID = tonumber(tabID)
	
	local DS = DataStore
	local guild	= DS:GetGuild(self.ClientGuildName, self.ClientRealmName)
	
	DS:ImportGuildBankTab(guild, tabID, data)
	self:RequestNext(sender)
end

function Altoholic.Comm.Sharing:OnRefDataReceived(sender, data)
	local TocData = self.DestTOC[self.NetDestCurItem]
	local _, class = strsplit(TOC_SEP, TocData)
	
	DataStore:ImportClassReference(class, data)
--	Altoholic:Print(format(L["Reference data received (%s) !"], class))
	self:RequestNext(sender)
end



-- Message types
local MSG_GUILD_ANNOUNCELOGIN				= 1

-- deprecated, this message is no longer sent, but is kept in the handler for backwards compatibility
local MSG_GUILD_ANNOUNCELOGOUT			= 2		-- announces the logout of ANOTHER player, not self

local MSG_GUILD_SENDPUBLICINFO			= 3		-- whisper your own data in answer to an ANNOUNCELOGIN
local MSG_GUILD_BANKUPDATEREQUEST		= 4		-- "can you please send info about bank tab "name" ?
local MSG_GUILD_BANKUPDATEREPLY			= 5		-- "sure! here it is !"
local MSG_GUILD_EQUIPMENTREQUEST			= 6		-- "can you please send info about your equipment ?
local MSG_GUILD_EQUIPMENTREPLY			= 7		-- "sure! here it is !"
local MSG_GUILD_COMMDISABLED				= 8		-- The player has disabled  guild comm
local MSG_GUILD_BANKUPDATEREFUSED		= 9		-- Negative answer to MSG_GUILD_BANKUPDATEREQUEST
local MSG_GUILD_SENDMAIL_INIT				= 10
local MSG_GUILD_SENDMAIL_END				= 11
local MSG_GUILD_SENDMAIL_ATTACHMENTS	= 12
local MSG_GUILD_SENDMAIL_BODY				= 13
local MSG_GUILD_BANKUPDATEINFO			= 14		-- after having  updated a guild bank tab, broadcast updated info
local MSG_GUILD_BANKUPDATEWAITING		= 15		-- if bank tab update is not configured to be automatic, tell the requester to wait

Altoholic.Comm.Guild = {}
Altoholic.Comm.Guild.Callbacks = {
	[MSG_GUILD_ANNOUNCELOGIN] = "OnAnnounceLogin",
	[MSG_GUILD_ANNOUNCELOGOUT] = "OnAnnounceLogout",
	[MSG_GUILD_SENDPUBLICINFO] = "OnPublicInfoReceived",
	[MSG_GUILD_COMMDISABLED] = "OnCommDisabled",
	
	[MSG_GUILD_BANKUPDATEREQUEST] = "OnBankUpdateRequest",
	[MSG_GUILD_BANKUPDATEREPLY] = "OnBankUpdateReply",
	[MSG_GUILD_BANKUPDATEINFO] = "OnBankUpdateInfo",
	[MSG_GUILD_BANKUPDATEREFUSED] = "OnBankUpdateRefused",
	[MSG_GUILD_BANKUPDATEWAITING] = "OnBankUpdateWaiting",
	
	[MSG_GUILD_EQUIPMENTREQUEST] = "OnEquipmentRequest",
	[MSG_GUILD_EQUIPMENTREPLY] = "OnEquipmentReply",
	
	[MSG_GUILD_SENDMAIL_INIT] = "OnSendMailInit",
	[MSG_GUILD_SENDMAIL_END] = "OnSendMailEnd",
	[MSG_GUILD_SENDMAIL_ATTACHMENTS] = "OnSendMailAttachments",
	[MSG_GUILD_SENDMAIL_BODY] = "OnSendMailBody",
}


function Altoholic:GuildCommHandler(prefix, message, distribution, sender)
	local self = Altoholic.Comm.Guild

	if self and self.msgHandler then
		self[self.msgHandler](self, prefix, message, distribution, sender)
	end
end

function Altoholic.Comm.Guild:SetMessageHandler(handler)
	self.msgHandler = handler
end

function Altoholic.Comm.Guild:EmptyHandler(prefix, message, distribution, sender)
	self:Whisper(sender, MSG_GUILD_COMMDISABLED)
end

function Altoholic.Comm.Guild:ActiveHandler(prefix, message, distribution, sender)
	local success, msgType, msgData = Altoholic:Deserialize(message)
	
	if success and msgType then
		local comm = Altoholic.Comm.Guild
		local cb = comm.Callbacks[msgType]
		
		if cb then
			comm[cb](self, sender, msgData)
		end
	end
end

-- *** Guild Comm Callbacks ***
--	GENERAL
function Altoholic.Comm.Guild:OnAnnounceLogin(sender, data)
	local m = Altoholic.Guild.Members
	
	-- complete data that will not be sent later on, this will minimize the amount of data broadcasted over the guild channel
	m:Clear(data.name)
	
	if sender ~= UnitName("player") then
		data.name = sender
	
		local level, class, englishClass = m:GetInfo(sender)
		data.level = level or 0
		data.class = class or ""
		data.englishClass = englishClass or ""

		for k, v in pairs(data.skills) do
			level, class, englishClass = m:GetInfo(v.name)
			v.level = level or 0
			v.class = class or ""
			v.englishClass = englishClass or ""
		end
	end
	
	m:Add(data)
	
	-- after receiving & saving info, send our own data
	if sender ~= UnitName("player") then		-- don't send back to self
		Altoholic.Guild.Members:Save(data)
		Altoholic:SendPublicInfo(MSG_GUILD_SENDPUBLICINFO, sender)
	else
		-- when saving self, make sure it can never be deleted
		m.List[#m.List].RemoveForbidden = true
	end
	
	if IsInGuild() then
		GuildRoster()
	end
	Altoholic.Tabs.Summary:Refresh()
end

function Altoholic.Comm.Guild:OnAnnounceLogout(sender, data)
	-- another altoholic user in the guild has detected that player "data" has disconnected and announced it to me

	local member = Altoholic.Guild.Members
	
	if sender ~= UnitName("player") then		-- don't process if it's coming from self
		for k, v in pairs(member.List) do
			if v.name == data and not v.RemoveForbidden then
				if not member:IsConnected(v.name) then		-- if the user is still in the table, remove it
					member:Delete(k)
					break
				end
			end
		end
	end
	Altoholic.Tabs.Summary:Refresh()
end

function Altoholic.Comm.Guild:OnPublicInfoReceived(sender, data)
	local m = Altoholic.Guild.Members
	
	-- complete data that will not be sent later on, this will minimize the amount of data broadcasted over the guild channel
	m:Clear(data.name)
	
	if sender ~= UnitName("player") then
		data.name = sender
		
		local level, class, englishClass = m:GetInfo(sender)
		data.level = level or 0
		data.class = class or ""
		data.englishClass = englishClass or ""

		for k, v in pairs(data.skills) do
			level, class, englishClass = m:GetInfo(v.name)
			v.level = level or 0
			v.class = class or ""
			v.englishClass = englishClass or ""
		end
	end
	
	m:Add(data)
	m:Save(data)
	Altoholic.Tabs.Summary:Refresh()
end

function Altoholic.Comm.Guild:OnCommDisabled(sender, data)
	Altoholic:Print(format(L["%s has disabled guild communication"], sender ))
end

--	BANK
function Altoholic.Comm.Guild:OnBankUpdateRequest(sender, data)
	if Altoholic.Options:Get("GuildBankAutoUpdate") == 1 then
		Altoholic:SendGuildTab(sender, data)
	else
		Altoholic.Comm.Guild:Whisper(sender, MSG_GUILD_BANKUPDATEWAITING)
		AltoMsgBox:SetHeight(130)
		AltoMsgBox_Text:SetHeight(60)
		AltoMsgBox.ButtonHandler = AltoholicBankTabUpdate_ButtonHandler
		AltoMsgBox.Sender = sender
		AltoMsgBox.BankTab = data
		AltoMsgBox_Text:SetText(format(L["%s%s|r has requested the bank tab %s%s|r\nSend this information ?"], WHITE, sender, WHITE, data) .. "\n\n"
								.. format(L["%sWarning:|r make sure this user may view this information before accepting"], WHITE))
		AltoMsgBox:Show()
	end
end

function Altoholic.Comm.Guild:OnBankUpdateReply(sender, data)
	local DS = DataStore
	local guildName = GetGuildInfo("player")
	local guild	= DS:GetGuild(guildName)
	
	for tabID = 1, 6 do
		if data.name == GetGuildBankTabInfo(tabID) then
			DS:ImportGuildBankTab(guild, tabID, data)
		
			Altoholic.Tabs.GuildBank:LoadGuild("Default", GetRealmName(), guildName)
			Altoholic:Print(format(L["Guild bank tab %s successfully updated !"], data.name ))
			
			-- since bank tab info has been updated, broadcast updated data to the guild
			local tab = DS:GetGuildBankTab(guild, tabID)
			
			local t = {
				name = tab.name,
				ClientDate = tab.ClientDate,
				ClientHour = tab.ClientHour,
				ClientMinute = tab.ClientMinute,
				ServerHour = tab.ServerHour,
				ServerMinute = tab.ServerMinute
			}
			
			self:Broadcast(MSG_GUILD_BANKUPDATEINFO, t)
			break
		end
	end
	Altoholic.Tabs.Summary:Refresh()
end

function Altoholic.Comm.Guild:OnBankUpdateInfo(sender, data)
	for k, v in pairs(Altoholic.Guild.Members.List) do
		if v.name == sender and v.guildbank then		-- find the player
			for tabID, tab in ipairs(v.guildbank) do
				if tab.name == data.name then		-- find the tab
					
					-- update the info
					tab.ClientDate = data.ClientDate
					tab.ClientHour = data.ClientHour
					tab.ClientMinute = data.ClientMinute
					tab.ServerHour = data.ServerHour
					tab.ServerMinute = data.ServerMinute
					
					Altoholic.Tabs.Summary:Refresh()
					break
				end
			end
		end
	end
end

function Altoholic.Comm.Guild:OnBankUpdateRefused(sender, data)
	Altoholic:Print(format(L["Request rejected by %s"], sender))
end

function Altoholic.Comm.Guild:OnBankUpdateWaiting(sender, data)
	Altoholic:Print(format(L["Waiting for %s to accept .."], sender))
end

--	EQUIPMENT
function Altoholic.Comm.Guild:OnEquipmentRequest(sender, data)
	local DS = DataStore
	local character = DS:GetCharacter(data)
	Altoholic.Comm.Guild:Whisper(sender, MSG_GUILD_EQUIPMENTREPLY, DS:GetInventory(character))
end

function Altoholic.Comm.Guild:OnEquipmentReply(sender, data)
	Altoholic.Guild.Members:UpdateEquipment(data)
end

--	MAIL
function Altoholic.Comm.Guild:OnSendMailInit(sender, data)
	self.recipient = data
end

function Altoholic.Comm.Guild:OnSendMailEnd(sender, data)
	if self.recipient and Altoholic.Options:Get("GuildMailWarning") == 1 then
		Altoholic:Print(format(L["%s|r has received a mail from %s"], GREEN..self.recipient, GREEN..sender))
	end
	self.recipient = nil
end

function Altoholic.Comm.Guild:OnSendMailAttachments(sender, data)
	if not self.recipient then return end
	
	local character = DataStore:GetCharacter(self.recipient)
	if not character then return end

	-- mails are saved into the mailCache instead of the normal mail table, to avoid getting deleted if the mailbox is checked BEFORE the mail actually arrives in the mailbox
	for _, v in pairs(data) do		--  .. save attachments into his mailbox
		DataStore:SaveMailAttachmentToCache(character, v.icon, v.link, v.count, sender)
	end
end

function Altoholic.Comm.Guild:OnSendMailBody(sender, data)
	if not self.recipient then return end
	
	local character = DataStore:GetCharacter(self.recipient)
	if not character then return end
	
	-- data sent as :  { moneySent, body, subject }
	DataStore:SaveMailToCache(character, data[1], data[2], data[3], sender)
end

-- rename these to : guildbroadcast, guildwhisper
function Altoholic.Comm.Guild:Broadcast(messageType, ...)
	local serializedData = Altoholic:Serialize(messageType, ...)
	Altoholic:SendCommMessage("AltoGuild", serializedData, "GUILD")
end

function Altoholic.Comm.Guild:Whisper(player, messageType, ...)
	local serializedData = Altoholic:Serialize(messageType, ...)
	Altoholic:SendCommMessage("AltoGuild", serializedData, "WHISPER", player)
end


function AltoholicBankTabUpdate_ButtonHandler(self, button)
	AltoMsgBox.ButtonHandler = nil		-- prevent any other call to msgbox from coming back here
	local sender = AltoMsgBox.Sender
	local tabName = AltoMsgBox.BankTab
	AltoMsgBox.Sender = nil
	AltoMsgBox.BankTab = nil
	
	if not button then 
		Altoholic.Comm.Guild:Whisper(sender, MSG_GUILD_BANKUPDATEREFUSED)
		return 
	end
	
	Altoholic:SendGuildTab(sender, tabName)
end

function Altoholic:SendGuildTab(player, tabName)
	local DS = DataStore
	local guildName = GetGuildInfo("player")
	local guild	= DS:GetGuild(guildName)	
	
	for i=1, 6 do
		local tab = DS:GetGuildBankTab(guild, i)

		if tab.name == tabName then
			Altoholic.Comm.Guild:Whisper(player, MSG_GUILD_BANKUPDATEREPLY, tab)
			break
		end
	end
end
