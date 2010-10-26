local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"
local THIS_ACCOUNT = "Default"

local ICON_GUILD = "Interface\\Icons\\Achievement_GuildPerk_Everyones a Hero_rank2"
local ICON_GUILDBANK = "Interface\\Icons\\Achievement_GuildPerk_MobileBanking"
local ICON_REMOTE_UPDATE = "Interface\\Icons\\Achievement_GuildPerk_Bartering"

local NUM_GUILDBANK_ROWS = 7
local MAX_BANK_TABS = 8

local parent = "AltoholicFrameGuildBank"
local rcMenuName = parent .. "RightClickMenu"	-- name of right click menu frames (add a number at the end to get it)

local currentGuildKey
local currentGuildBankTab = 0

-- *** Utility functions ***
local function DDM_AddTitle(text)
	-- tiny wrapper
	local info = UIDropDownMenu_CreateInfo(); 

	info.isTitle	= 1
	info.text		= text
	info.checked	= nil
	info.notCheckable = 1
	info.icon		= nil
	UIDropDownMenu_AddButton(info, 1)
end

local function DDM_Add(text, value, func, icon, isChecked)
	-- tiny wrapper
	local info = UIDropDownMenu_CreateInfo(); 
	
	info.text		= text
	info.value		= value
	info.func		= func
	info.checked	= isChecked
	info.icon		= icon
	UIDropDownMenu_AddButton(info, 1); 
end

local function DDM_AddCloseMenu()
	local info = UIDropDownMenu_CreateInfo(); 
	
	-- Close menu item
	info.text = CLOSE
	info.func = function() CloseDropDownMenus() end
	info.checked = nil
	info.notCheckable = 1
	info.icon		= nil
	UIDropDownMenu_AddButton(info, 1)
end

addon.Guild.Bank = {}

local ns = addon.Guild.Bank		-- ns = namespace

local function DeleteGuild_MsgBox_Handler(self, button, guildKey)
	if not button then return end
	
	local account, realm, guildName = strsplit(".", guildKey)
	local guild = addon:GetGuild(guildName, realm, account)
	wipe(guild)
	
	DataStore:DeleteGuild(guildName, realm, account)
	
	addon:Print(format( L["Guild %s successfully deleted"], guildName))
	
	if guildKey == currentGuildKey then
		currentGuildKey = nil
		currentGuildBankTab = nil
		ns:Update()
	end
end

local function OnGuildChange(self)
	currentGuildKey = self.value
	currentGuildBankTab = nil
	
	local _, _, guildName = strsplit(".", currentGuildKey)
	AltoholicTabGuildStatus:SetText(format("%s %s/", GREEN..guildName, WHITE))

	local currentGuild = GetGuildInfo("player")
	if guildName == currentGuild then
		_G[parent .. "_UpdateIcon"]:Enable()
		_G[parent .. "_UpdateIconIconTexture"]:SetDesaturated(0)
	else
		_G[parent .. "_UpdateIcon"]:Disable()
		_G[parent .. "_UpdateIconIconTexture"]:SetDesaturated(1)
	end
	
	_G[parent .. "Info1"]:SetText("")
	_G[parent .. "Info2"]:SetText("")
	_G[parent .. "Info3"]:SetText("")
	
	ns:Update()
end

local function OnHideInTooltip(self)
	local account, realm, name = strsplit(".", self.value)
	local guild = addon:GetGuild(name, realm, account)
	if guild	then
		guild.hideInTooltip = not guild.hideInTooltip
	end
	
	CloseDropDownMenus()
end

local function OnGuildDelete(self)
	local guildKey = self.value

	addon:SetMsgBoxHandler(DeleteGuild_MsgBox_Handler, guildKey)
	
	local _, realm, guildName = strsplit(".", guildKey)

	AltoMsgBox_Text:SetText(format("%s\n%s%s %s(%s)", L["Delete Guild Bank?"], GREEN, guildName, WHITE, realm ))
	AltoMsgBox:Show()
	
	CloseDropDownMenus()
end

local function OnGuildBankTabChange(self)
	currentGuildBankTab = self.value
	ns:Update()
end

local function OnBankTabRemoteUpdate(self)
	local tabName = DataStore:GetGuildBankTabName(currentGuildKey, currentGuildBankTab)
	local member = self.value
	
	addon:Print(format(L["Requesting %s information from %s"], tabName, member ))
	DataStore:RequestGuildMemberBankTab(member, tabName)
end

function ns:Update()
	local entry = parent .. "Entry"
	if not currentGuildKey or not currentGuildBankTab then		-- no tab found ? exit
		for rowIndex = 1, NUM_GUILDBANK_ROWS do
			_G[ entry..rowIndex ]:Hide()
		end
		return 
	end
	
	local tab = DataStore:GetGuildBankTab(currentGuildKey, currentGuildBankTab)
	if not tab.name then return end		-- tab not yet scanned ? exit
	
	local _, _, guildName = strsplit(".", currentGuildKey)
	AltoholicTabGuildStatus:SetText(format("%s %s/ %s", GREEN..guildName, WHITE, tab.name))

	_G[parent .. "Info1"]:SetText(format(L["Last visit: %s by %s"], GREEN..tab.ClientDate..WHITE, GREEN..tab.visitedBy))
	local localTime, realmTime
	localTime = format("%s%02d%s:%s%02d", GREEN, tab.ClientHour, WHITE, GREEN, tab.ClientMinute )
	realmTime = format("%s%02d%s:%s%02d", GREEN, tab.ServerHour, WHITE, GREEN, tab.ServerMinute )
	_G[parent .. "Info2"]:SetText(format(L["Local Time: %s   %sRealm Time: %s"], localTime, WHITE, realmTime))
	
	local money = DataStore:GetGuildBankMoney(currentGuildKey)
	_G[parent .. "Info3"]:SetText(MONEY .. ": " .. addon:GetMoneyString(money or 0, WHITE))
	
	for rowIndex = 1, NUM_GUILDBANK_ROWS do
	
		local from = mod(rowIndex, NUM_GUILDBANK_ROWS)
		if from == 0 then from = NUM_GUILDBANK_ROWS end
	
		for columnIndex = 14, 1, -1 do
			local itemName = entry..rowIndex .. "Item" .. columnIndex;
			local itemButton = _G[itemName];
			
			local itemIndex = from + ((columnIndex - 1) * NUM_GUILDBANK_ROWS)
			
			local itemID, itemLink, itemCount = DataStore:GetSlotInfo(tab, itemIndex)
			
			if itemID then
				addon:SetItemButtonTexture(itemName, GetItemIcon(itemID));
			else
				addon:SetItemButtonTexture(itemName, "Interface\\PaperDoll\\UI-Backpack-EmptySlot");
			end
			
			itemButton.id = itemID
			itemButton.link = itemLink
				itemButton:SetScript("OnEnter", function(self) 
						addon:Item_OnEnter(self)
					end)
			
			local countWidget = _G[itemName .. "Count"]
			if not itemCount or (itemCount < 2) then
				countWidget:Hide();
			else
				countWidget:SetText(itemCount);
				countWidget:Show();
			end
		
			_G[ itemName ]:Show()
		end
		_G[ entry..rowIndex ]:Show()
	end
end


-- ** Menu Icons **
function ns:Icon_OnEnter(frame)
	local currentMenuID = frame:GetID()
	
	-- hide all
	for i = 1, 3 do
		if i ~= currentMenuID and _G[ rcMenuName .. i ].visible then
			ToggleDropDownMenu(1, nil, _G[ rcMenuName .. i ], frame:GetName(), 0, -5);	
			_G[ rcMenuName .. i ].visible = false
		end
	end

	-- show current
	ToggleDropDownMenu(1, nil, _G[ rcMenuName .. currentMenuID ], frame:GetName(), 0, -5);	
	_G[ rcMenuName .. currentMenuID ].visible = true
end

local function GuildIcon_Initialize(self, level)
	local info = UIDropDownMenu_CreateInfo()
	if level == 1 then
		for account in pairs(DataStore:GetAccounts()) do
			for realm in pairs(DataStore:GetRealms(account)) do
				for guildName, guild in pairs(DataStore:GetGuilds(realm, account)) do
					local money = DataStore:GetGuildBankMoney(guild)
					if money then
						local text = format("%s / %s", WHITE..realm, GREEN..guildName)

						if account ~= "Default" then
							text = format("%s %s(%s)", text, YELLOW, account)
						end
					
						info.text = text
						info.hasArrow = 1
						info.checked = (guild == currentGuildKey) and true or nil
						info.value = guild		-- guild key
						info.func = OnGuildChange
						UIDropDownMenu_AddButton(info, level)
					end
				end
			end
		end
		
	elseif level == 2 then
		local account, realm, name = strsplit(".", UIDROPDOWNMENU_MENU_VALUE)
		local guild = addon:GetGuild(name, realm, account)
	
		info.text = WHITE ..  L["Hide this guild in the tooltip"]
		info.value = UIDROPDOWNMENU_MENU_VALUE
		info.checked = guild.hideInTooltip
		info.func = OnHideInTooltip
		UIDropDownMenu_AddButton(info, level)
		
		info.text = WHITE .. DELETE
		info.value = UIDROPDOWNMENU_MENU_VALUE
		info.checked = nil
		info.func = OnGuildDelete
		UIDropDownMenu_AddButton(info, level)
	end
end

local function TabsIcon_Initialize(self, level)
	DDM_AddTitle(L["Guild Bank Tabs"])
	
	for i = 1, MAX_BANK_TABS do 
		local tabName = DataStore:GetGuildBankTabName(currentGuildKey, i)
		if tabName then
			DDM_Add(tabName, i, OnGuildBankTabChange, DataStore:GetGuildBankTabIcon(currentGuildKey, i), (currentGuildBankTab == i))
		end
	end
	DDM_AddCloseMenu()
end

local function UpdateIcon_Initialize(self, level)
	if not currentGuildKey or not currentGuildBankTab or currentGuildBankTab == 0 then return end
	
	local tabName = DataStore:GetGuildBankTabName(currentGuildKey, currentGuildBankTab)
	if not tabName then return end
	
	local player = UnitName("player")
	local myClientTime = DataStore:GetGuildMemberBankTabInfo(player, tabName)
	
	local older = {}
	local newer = {}
	
	DDM_AddTitle(L["Update current tab from"])
	for member in pairs(DataStore:GetGuildBankTabSuppliers()) do
		if member ~= player then	-- skip current player
			local clientTime = DataStore:GetGuildMemberBankTabInfo(member, tabName)
				
			if clientTime then	-- if there's data, we can add this member in the view for the current bank tab
				if clientTime > myClientTime then
					table.insert(newer, { name = member, timeStamp = clientTime } )
				else
					table.insert(older, { name = member, timeStamp = clientTime } )
				end
			end
		end
	end
	
	if #newer > 0 then
		DDM_AddTitle(" ")
		DDM_AddTitle(YELLOW..L["Newer data"])
		
		table.sort(newer, function(a,b) return a.timeStamp > b.timeStamp end)
		
		for _, member in ipairs(newer) do
			local clientTime, serverHour, serverMinute = DataStore:GetGuildMemberBankTabInfo(member.name, tabName)
		
			DDM_Add(format("%s %s", WHITE..member.name, GREEN..date("%m/%d/%Y %H:%M", clientTime)), member.name, OnBankTabRemoteUpdate)
		end
	end

	if #older > 0 then
		DDM_AddTitle(" ")
		DDM_AddTitle(YELLOW..L["Older data"])
		
		table.sort(older, function(a,b) return a.timeStamp > b.timeStamp end)
		
		for _, member in ipairs(older) do
			local clientTime, serverHour, serverMinute = DataStore:GetGuildMemberBankTabInfo(member.name, tabName)
		
			DDM_Add(format("%s %s", WHITE..member.name, GREEN..date("%m/%d/%Y %H:%M", clientTime)), member.name, OnBankTabRemoteUpdate)
		end
	end

	DDM_AddCloseMenu()
end

function ns:OnLoad()
	addon:SetItemButtonTexture(parent .. "_GuildIcon", ICON_GUILD, 30, 30)
	addon:SetItemButtonTexture(parent .. "_TabsIcon", ICON_GUILDBANK, 30, 30)
	addon:SetItemButtonTexture(parent .. "_UpdateIcon", ICON_REMOTE_UPDATE, 30, 30)
	
	-- load the drop down with a guild
	local currentRealm = GetRealmName()
	local currentGuild = GetGuildInfo("player")
	
	-- if the player is not in a guild, set the drop down to the first available guild on this realm, if any.
	if not currentGuild then
		-- if the guild that will be displayed is not the one the current player is in, then disable the button
		_G[parent .. "_UpdateIcon"]:Disable()
		_G[parent .. "_UpdateIconIconTexture"]:SetDesaturated(1)
	
		for guildName, guild in pairs(DataStore:GetGuilds(currentRealm, THIS_ACCOUNT)) do
			local money = DataStore:GetGuildBankMoney(guild)
			if money then		-- if money is not nil, the guild bank has been populated
				currentGuild = guildName
				break	-- if there's at least one guild, let's set the right value and break immediately
			end
		end
	end
	
	-- if the current guild or at least a guild on this realm was found..set the right values
	if currentGuild then
		currentGuildKey = format("%s.%s.%s", THIS_ACCOUNT, currentRealm, currentGuild)

		-- pick the first available tab
		for i = 1, MAX_BANK_TABS do 
			local tabName = DataStore:GetGuildBankTabName(currentGuildKey, i)
			if tabName then
				currentGuildBankTab = i
				break
			end
		end
	end
	
	UIDropDownMenu_Initialize(_G[rcMenuName.."1"], GuildIcon_Initialize, "MENU")
	UIDropDownMenu_Initialize(_G[rcMenuName.."2"], TabsIcon_Initialize, "MENU")
	UIDropDownMenu_Initialize(_G[rcMenuName.."3"], UpdateIcon_Initialize, "MENU")

end