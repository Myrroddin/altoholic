local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"

addon.GuildBank = {}

local ns = addon.GuildBank		-- ns = namespace

function ns:DrawTab(tabID)
	local selectedGuild = UIDropDownMenu_GetSelectedValue(AltoholicTabGuildBank_SelectGuild)
	if not selectedGuild then return end		-- not defined yet ? exit.

	if not AltoGuildBank:IsVisible() then
		AltoGuildBank:Show()
	end
	
	local DS = DataStore
	local account, realm, guildName = strsplit("|", selectedGuild)
	local guild	= DS:GetGuild(guildName, realm, account)
	
	if not tabID then		
		-- will be nil when clicking on the guild bank tab for the first time, so find the first available one
		-- called in OnShow (tabguildbank.xml)
		for i=1, 6 do
			if DS:GetGuildBankTabName(guild, i) then
				tabID = i
				
				for i=1, 6 do 
					_G[ "AltoholicTabGuildBankMenuItem"..i ]:UnlockHighlight();
				end
				_G[ "AltoholicTabGuildBankMenuItem"..tabID ]:LockHighlight();
				break
			end
		end
	end
	
	if not tabID then return end	-- no tab found ? exit
	
	local tab = DS:GetGuildBankTab(guild, tabID)
	if not tab.name then return end	-- tab not yet scanned ? exit
	
	local entry = "AltoGuildBankEntry"
	
	AltoholicTabGuildBankInfo1:SetText(format(L["Last visit: %s by %s"], GREEN..tab.ClientDate..WHITE, GREEN..tab.visitedBy))
	local localTime, realmTime
	localTime = format("%s%02d%s:%s%02d", GREEN, tab.ClientHour, WHITE, GREEN, tab.ClientMinute )
	realmTime = format("%s%02d%s:%s%02d", GREEN, tab.ServerHour, WHITE, GREEN, tab.ServerMinute )
	AltoholicTabGuildBankInfo2:SetText(format(L["Local Time: %s   %sRealm Time: %s"], localTime, WHITE, realmTime))
	
	for i=1, 7 do
	
		local from = mod(i, 7)
		if from == 0 then from = 7 end
	
		for j=14, 1, -1 do
			local itemName = entry..i .. "Item" .. j;
			local itemButton = _G[itemName];
			
			local itemIndex = from + ((j - 1) * 7)
			
			local itemID, itemLink, itemCount = DS:GetSlotInfo(tab, itemIndex)
			
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
		_G[ entry..i ]:Show()
	end
end
