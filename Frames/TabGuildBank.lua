local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local WHITE		= "|cFFFFFFFF"
local TEAL		= "|cFF00FF9A"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"

local THIS_ACCOUNT = "Default"

Altoholic.Tabs.GuildBank = {}

-- note: most references to the guild bank in this file are related to the data saved in Altoholic, and not in DataStore_Containers
function Altoholic.Tabs.GuildBank:DropDownGuild_Initialize()
	if not Altoholic.db then return end
	
	local self = Altoholic.Tabs.GuildBank
	local info = UIDropDownMenu_CreateInfo(); 

	for k, _ in pairs(Altoholic.db.global.Guilds) do
		-- to do: work on improving the order, might be a bit messy if there are many guilds
		local guildAccount, guildRealm, guildName = strsplit(".", k)

		info.text = GREEN .. guildName .. WHITE .. " (" .. guildRealm 
						.." / ".. YELLOW .. guildAccount ..  WHITE.. ")"
		info.value = guildAccount .."|" .. guildRealm .."|".. guildName
		info.checked = nil; 
		info.func = self.ChangeGuild
		info.arg1 = guildAccount
		info.arg2 = guildRealm
		UIDropDownMenu_AddButton(info, 1); 
	end
	
	-- local DS = DataStore
	
	-- for account in pairs(DS:GetAccounts()) do
		-- for realm in pairs(DS:GetRealms(account)) do
			-- for guildName, guild in pairs(DS:GetGuilds(realm, account)) do
				-- local info = UIDropDownMenu_CreateInfo(); 
				
				-- info.text = format("%s %s(%s / %s%s)", GREEN..guildName, WHITE, realm, YELLOW..account, WHITE)
				-- info.value = format("%s|%s|%s", account, realm, guildName)
				-- info.checked = nil; 
				-- info.func = ChangeGuild
				-- info.arg1 = account
				-- info.arg2 = realm
				-- UIDropDownMenu_AddButton(info, 1); 
			-- end
		-- end
	-- end
end

function Altoholic.Tabs.GuildBank:OnShow()
	if self.initRequired then
		local realm = GetRealmName()
		local currentGuild = GetGuildInfo("player")
		
		-- if the player is not in a guild, set the drop down to the first available guild on this realm, if any.
		if not currentGuild then
			for k, _ in pairs(Altoholic.db.global.Guilds) do
				local guildAccount, guildRealm, guildName = strsplit(".", k)
				if guildAccount == THIS_ACCOUNT and guildRealm == realm then
					currentGuild = guildName
					break	-- if there's at least one guild, let's set the right value and break immediately
				end
			end
		end
		
		-- if the current guild or at least a guild on this realm was found..set the right values
		if currentGuild then
			UIDropDownMenu_SetSelectedValue(AltoholicTabGuildBank_SelectGuild, 
					THIS_ACCOUNT .. "|" .. realm .."|".. currentGuild )
			UIDropDownMenu_SetText(AltoholicTabGuildBank_SelectGuild, 
					GREEN .. currentGuild .. WHITE .. " (" .. realm .. ")"	)

			self:LoadGuild(THIS_ACCOUNT, realm, currentGuild)
		end	
		
		self.initRequired = nil
	end

	Altoholic.GuildBank:DrawTab()
end


function Altoholic.Tabs.GuildBank:ChangeGuild(account, realm, checked)
	local _, _, guildname = strsplit("|", self.value)

	UIDropDownMenu_ClearAll(AltoholicTabGuildBank_SelectGuild);
	UIDropDownMenu_SetSelectedValue(AltoholicTabGuildBank_SelectGuild, account .."|" .. realm .."|".. guildname)
	UIDropDownMenu_SetText(AltoholicTabGuildBank_SelectGuild, GREEN .. guildname .. WHITE .. " (" .. realm .. ")")

	Altoholic.Tabs.GuildBank:LoadGuild(account, realm, guildname)
end

function Altoholic.Tabs.GuildBank:LoadGuild(account, realm, name)
	local guild = Altoholic:GetGuild(name, realm, account)
	
	local DS = DataStore
	local DSGuild	= DS:GetGuild(name, realm, account)
	
	AltoGuildBank:Hide()
	for i = 1, 6 do
		_G[ "AltoholicTabGuildBankMenuItem"..i ]:UnlockHighlight();
		
		local name = DS:GetGuildBankTabName(DSGuild, i)
		_G[ "AltoholicTabGuildBankMenuItem" .. i ]:SetText(name and (WHITE..name) or (YELLOW..L["N/A"]))
		_G[ "AltoholicTabGuildBankMenuItem" .. i ]:Show()
	end
	
	AltoholicTabGuildBank_HideInTooltip:SetChecked(guild.hideInTooltip)
	AltoholicTabGuildBankMoney:SetText(MONEY .. ": " .. Altoholic:GetMoneyString(guild.bankmoney, WHITE))
end

function Altoholic.Tabs.GuildBank:HideGuild(self)

	local value = UIDropDownMenu_GetSelectedValue(AltoholicTabGuildBank_SelectGuild)
	if not value then return end
	
	local account, realm, name = strsplit("|", value)
	local guild = Altoholic:GetGuild(name, realm, account)
	
	if self:GetChecked() then 
		guild.hideInTooltip = true
	else
		guild.hideInTooltip = nil
	end
end

function Altoholic.Tabs.GuildBank:DeleteGuild()
	AltoMsgBox.ButtonHandler = Altoholic.Tabs.GuildBank.ButtonHandler
	local value = UIDropDownMenu_GetSelectedValue(AltoholicTabGuildBank_SelectGuild)
	if not value then return end
	
	local _, realm, guildname = strsplit("|", value)
	
	AltoMsgBox_Text:SetText(L["Delete Guild Bank?"] .. "\n" .. GREEN .. guildname .. WHITE .. " (" .. realm .. ")")
	AltoMsgBox:Show()
end

function Altoholic.Tabs.GuildBank:ButtonHandler(button)
	AltoMsgBox.ButtonHandler = nil		-- prevent any other call to msgbox from coming back here
	if not button then return end
	
	local value = UIDropDownMenu_GetSelectedValue(AltoholicTabGuildBank_SelectGuild)
	local account, realm, guildname = strsplit("|", value)
	local guild = Altoholic:GetGuild(guildname, realm, account)

	for i=1, 6 do
		_G[ "AltoholicTabGuildBankMenuItem"..i ]:Hide()
	end
	
	AltoholicTabGuildBankInfo1:SetText("")
	AltoholicTabGuildBankInfo2:SetText("")
	AltoholicTabGuildBankMoney:SetText("")
	
	AltoGuildBank:Hide()
	
	local DS = DataStore
	DS:DeleteGuild(guildname, realm, account)
	
	UIDropDownMenu_ClearAll(AltoholicTabGuildBank_SelectGuild);
	
	Altoholic:Print(format( L["Guild %s successfully deleted"], guildname))
end
