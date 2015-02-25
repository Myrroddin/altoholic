local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local INFO_REALM_LINE = 0
local INFO_CHARACTER_LINE = 1
local INFO_TOTAL_LINE = 2
local THIS_ACCOUNT = "Default"

local VIEW_BAGS = 1
local VIEW_QUESTS = 2
local VIEW_AUCTIONS = 5
local VIEW_BIDS = 6
local VIEW_MAILS = 7
local VIEW_MOUNTS = 8
local VIEW_COMPANIONS = 9

local ICON_FACTION_HORDE = "Interface\\Icons\\INV_BannerPVP_01"
local ICON_FACTION_ALLIANCE = "Interface\\Icons\\INV_BannerPVP_02"

local Characters = addon.Characters

local function GetFactionTotals(f, line)
	local _, realm, account = Characters:GetInfo(line)
	
	local level = 0
	local money = 0
	local played = 0
	
	local DS = DataStore
	for _, character in pairs(DS:GetCharacters(realm, account)) do
		if DS:GetCharacterFaction(character) == f then
			level = level + DS:GetCharacterLevel(character)
			money = money + DS:GetMoney(character)
			played = played + DS:GetPlayTime(character)
		end
	end
	
	return level, money, played
end

local DDM_Add = addon.Helpers.DDM_AddWithArgs
local DDM_AddCloseMenu = addon.Helpers.DDM_AddCloseMenu

addon.Summary = {}

local ns = addon.Summary		-- ns = namespace

local function ViewAltInfo(self, characterInfoLine)
	addon.Tabs:OnClick("Characters")
	addon.Tabs.Characters:SetAlt(Characters:GetInfo(characterInfoLine))
	addon.Tabs.Characters:ViewCharInfo(self.value)
end

local function DeleteAlt_MsgBox_Handler(self, button, characterInfoLine)
	if not button then return end
	
	local name, realm, account = Characters:GetInfo(characterInfoLine)
	
	DataStore:DeleteCharacter(name, realm, account)
	
	-- rebuild the main character table, and all the menus
	Characters:BuildList()
	Characters:BuildView()
	addon.Summary:Update()
		
	addon:Print(format( L["Character %s successfully deleted"], name))
end

local function DeleteAlt(self, characterInfoLine)
	local name, realm, account = Characters:GetInfo(characterInfoLine)
	
	if (account == THIS_ACCOUNT) and	(realm == GetRealmName()) and (name == UnitName("player")) then
		addon:Print(L["Cannot delete current character"])
		return
	end

	addon:SetMsgBoxHandler(DeleteAlt_MsgBox_Handler, characterInfoLine)
	
	AltoMsgBox_Text:SetText(L["Delete this Alt"] .. "?\n" .. name)
	AltoMsgBox:Show()
end

local function UpdateRealm(self, characterInfoLine)
	local _, realm, account = Characters:GetInfo(characterInfoLine)
	
	AltoAccountSharing_AccNameEditBox:SetText(account)
	AltoAccountSharing_UseTarget:SetChecked(nil)
	AltoAccountSharing_UseName:SetChecked(1)
	
	local _, updatedWith = addon:GetLastAccountSharingInfo(realm, account)
	AltoAccountSharing_AccTargetEditBox:SetText(updatedWith)
	
	addon.Tabs.Summary:AccountSharingButton_OnClick()
end

local function DeleteRealm_MsgBox_Handler(self, button, characterInfoLine)
	if not button then return end

	local _, realm, account = Characters:GetInfo(characterInfoLine)
	DataStore:DeleteRealm(realm, account)

	-- if the realm being deleted was the current ..
	local tc = addon.Tabs.Characters
	if tc:GetRealm() == realm and tc:GetAccount() == account then
		
		-- reset to this player
		local player = UnitName("player")
		local realmName = GetRealmName()
		addon.Tabs.Characters:SetAlt(player, realmName, THIS_ACCOUNT)
		addon.Containers:UpdateCache()
		tc:ViewCharInfo(VIEW_BAGS)
	end
	
	-- rebuild the main character table, and all the menus
	Characters:BuildList()
	Characters:BuildView()
	addon.Summary:Update()
		
	addon:Print(format( L["Realm %s successfully deleted"], realm))
end

local function DeleteRealm(self, characterInfoLine)
	local _, realm, account = Characters:GetInfo(characterInfoLine)
		
	if (account == THIS_ACCOUNT) and	(realm == GetRealmName()) then
		addon:Print(L["Cannot delete current realm"])
		return
	end

	addon:SetMsgBoxHandler(DeleteRealm_MsgBox_Handler, characterInfoLine)
	AltoMsgBox_Text:SetText(L["Delete this Realm"] .. "?\n" .. realm)
	AltoMsgBox:Show()
end

local function GetRestedXP(character)
	local rate = DataStore:GetRestXPRate(character)

	local coeff = 1
	if addon:GetOption("UI.Tabs.Summary.ShowRestXP150pc") then
		coeff = 1.5
	end
	rate = rate * coeff
	
	-- second return value = the actual percentage of rest xp, as a numeric value (1 to 100, not 150)
	local color = colors.green
	if rate >= (100 * coeff) then 
		rate = 100 * coeff
	else
		if rate < (30 * coeff) then
			color = colors.red
		elseif rate < (60 * coeff) then
			color = colors.yellow
		end
	end

	return format("%s%d", color, rate).."%", rate
end


function ns:Update()
	local VisibleLines = 14
	local frame = "AltoholicFrameSummary"
	local entry = frame.."Entry"
		
	local offset = addon.ScrollFrames:GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawRealm
	local i=1
	
	local DS = DataStore
	
	local view = Characters:GetView()
	if not view then return end
	
	for _, line in pairs(view) do
		local lineType = Characters:GetLineType(line)
		
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if lineType == INFO_REALM_LINE then								-- then keep track of counters
				if Characters:GetField(line, "isCollapsed") == false then
					DrawRealm = true
				else
					DrawRealm = false
				end
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			elseif DrawRealm then
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			end
		else		-- line will be displayed
			if lineType == INFO_REALM_LINE then
				local _, realm, account = Characters:GetInfo(line)
				
				if Characters:GetField(line, "isCollapsed") == false then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawRealm = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawRealm = false
				end
				_G[entry..i.."Collapse"]:Show()
				_G[entry..i.."Name"]:SetWidth(300)
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 25, 0)
				_G[entry..i.."NameNormalText"]:SetWidth(300)
				if account == THIS_ACCOUNT then	-- saved as default, display as localized.
					_G[entry..i.."NameNormalText"]:SetText(format("%s (%s".. L["Account"]..": %s%s|r)", realm, colors.white, colors.green, L["Default"]))
				else
					local last = addon:GetLastAccountSharingInfo(realm, account)
					_G[entry..i.."NameNormalText"]:SetText(format("%s (%s".. L["Account"]..": %s%s %s%s|r)", realm, colors.white, colors.green, account, colors.yellow, last or ""))
				end
				_G[entry..i.."Level"]:SetText("")

				_G[entry..i.."Money"]:SetText("")
				_G[entry..i.."Played"]:SetText("")
				_G[entry..i.."XP"]:SetText("")
				_G[entry..i.."Rested"]:SetText("")
				_G[entry..i.."AvgILevelNormalText"]:SetText("")
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			elseif DrawRealm then
				if (lineType == INFO_CHARACTER_LINE) then
					local character = DS:GetCharacter( Characters:GetInfo(line) )
					
					local icon
					if DS:GetCharacterFaction(character) == "Alliance" then
						icon = addon:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18) .. " "
					else
						icon = addon:TextureToFontstring(ICON_FACTION_HORDE, 18, 18) .. " "
					end
					
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(170)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 10, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(170)
					_G[entry..i.."NameNormalText"]:SetText(icon .. format("%s (%s)", DS:GetColoredCharacterName(character), DS:GetCharacterClass(character)))
					_G[entry..i.."Level"]:SetText(colors.green .. DS:GetCharacterLevel(character))

					_G[entry..i.."Money"]:SetText(addon:GetMoneyString(DS:GetMoney(character)))
					_G[entry..i.."Played"]:SetText(addon:GetTimeString(DS:GetPlayTime(character)))
					_G[entry..i.."XP"]:SetText(colors.green .. DS:GetXPRate(character) .. "%")

					if DS:GetCharacterLevel(character) == MAX_PLAYER_LEVEL then
						_G[entry..i.."Rested"]:SetText(colors.white .. "0%")
					else
						_G[entry..i.."Rested"]:SetText(GetRestedXP(character))
					end
					
					local AiL = DS:GetAverageItemLevel(character) or 0
					_G[entry..i.."AvgILevelNormalText"]:SetText(colors.yellow..format("%.1f", AiL))
					
				elseif (lineType == INFO_TOTAL_LINE) then
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(200)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(200)
					_G[entry..i.."NameNormalText"]:SetText(L["Totals"])
					_G[entry..i.."Level"]:SetText(Characters:GetField(line, "level"))
					_G[entry..i.."Money"]:SetText(addon:GetMoneyString(Characters:GetField(line, "money"), colors.white))
					_G[entry..i.."Money"]:SetTextColor(1.0, 1.0, 1.0)
					_G[entry..i.."Played"]:SetText(Characters:GetField(line, "played"))
					_G[entry..i.."XP"]:SetText("")
					_G[entry..i.."Rested"]:SetText("")
					_G[entry..i.."AvgILevelNormalText"]:SetText(colors.white..format("%.1f", Characters:GetField(line, "realmAiL")))
				end
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			end
		end
	end
	
	while i <= VisibleLines do
		_G[ entry..i ]:SetID(0)
		_G[ entry..i ]:Hide()
		i = i + 1
	end
	
	addon.ScrollFrames:Update( AltoholicFrameSummary.ScrollFrame, VisibleCount, VisibleLines, 18)
end

function ns:Level_OnEnter(frame)
	local line = frame:GetParent():GetID()
	local lineType = Characters:GetLineType(line)
	if not lineType then return end
	
	if lineType == INFO_REALM_LINE then		
		return
	elseif lineType == INFO_TOTAL_LINE then		
		AltoTooltip:ClearLines();
		AltoTooltip:SetOwner(frame, "ANCHOR_TOP");
		AltoTooltip:AddLine(L["Totals"]);
		
		local aLevels, aMoney, aPlayed = GetFactionTotals("Alliance", line)
		local hLevels, hMoney, hPlayed = GetFactionTotals("Horde", line)
		
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddDoubleLine(colors.white..L["Levels"] , format("%s|r (%s %s|r, %s %s|r)", 
			Characters:GetField(line, "level"),
			addon:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18), colors.white..aLevels,
			addon:TextureToFontstring(ICON_FACTION_HORDE, 18, 18), colors.white..hLevels))
		
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddDoubleLine(colors.white..MONEY, format("%s|r (%s %s|r, %s %s|r)", 
			addon:GetMoneyString(Characters:GetField(line, "money"), colors.white, true),
			addon:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18), 
			addon:GetMoneyString(aMoney, colors.white, true),
			addon:TextureToFontstring(ICON_FACTION_HORDE, 18, 18), 
			addon:GetMoneyString(hMoney, colors.white, true)))
		
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddDoubleLine(colors.white..PLAYED , format("%s|r (%s %s|r, %s %s|r)",
			Characters:GetField(line, "played"),
			addon:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18),
			addon:GetTimeString(aPlayed),
			addon:TextureToFontstring(ICON_FACTION_HORDE, 18, 18), 
			addon:GetTimeString(hPlayed)))
		
		AltoTooltip:Show();
		return
	end
	
	local DS = DataStore
	local character = DS:GetCharacter(Characters:GetInfo(line))
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(frame, "ANCHOR_RIGHT");
	
	AltoTooltip:AddDoubleLine(DS:GetColoredCharacterName(character), DS:GetColoredCharacterFaction(character))
	AltoTooltip:AddLine(format("%s %s |r%s %s", L["Level"], 
		colors.green..DS:GetCharacterLevel(character), DS:GetCharacterRace(character),	DS:GetCharacterClass(character)),1,1,1)

	local zone, subZone = DS:GetLocation(character)
	AltoTooltip:AddLine(format("%s: %s |r(%s|r)", L["Zone"], colors.gold..zone, colors.gold..subZone),1,1,1)
	
	local guildName = DS:GetGuildInfo(character)
	if guildName then
		AltoTooltip:AddLine(format("%s: %s", GUILD, colors.green..guildName),1,1,1)
	end
	
	AltoTooltip:AddLine(EXPERIENCE_COLON .. " " 
				.. colors.green .. DS:GetXP(character) .. colors.white .. "/" 
				.. colors.green .. DS:GetXPMax(character) .. colors.white .. " (" 
				.. colors.green .. DS:GetXPRate(character) .. "%"
				.. colors.white .. ")",1,1,1);	
	
	local restXP = DS:GetRestXP(character)
	if restXP and restXP > 0 then
		AltoTooltip:AddLine(format("%s: %s", L["Rest XP"], colors.green..restXP),1,1,1)
	end

	local suggestion = addon:GetSuggestion("Leveling", DS:GetCharacterLevel(character))
	if suggestion then
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddLine(L["Suggested leveling zone: "],1,1,1);
		AltoTooltip:AddLine(colors.teal .. suggestion,1,1,1);
	end

	-- parse saved instances
	local bLineBreak = true

	local dungeons = DataStore:GetSavedInstances(character)
	if dungeons then
		for key, _ in pairs(dungeons) do
			local hasExpired, expiresIn = DataStore:HasSavedInstanceExpired(character, key)
			
			if hasExpired then
				DataStore:DeleteSavedInstance(character, key)
			else
				if bLineBreak then
					AltoTooltip:AddLine(" ",1,1,1);		-- add a line break only once
					bLineBreak = nil
				end
				
				local instanceName, instanceID = strsplit("|", key)
				AltoTooltip:AddDoubleLine(format("%s (%sID: %s|r)", colors.gold..instanceName, colors.white, colors.green..instanceID), addon:GetTimeString(expiresIn))
			end
		end
	end
	
	-- add PVP info if any

	-- disabled until I see clearer in what happens to PVP stats (arena & honor points, which are supposed to be in the currencies tab anyway)
	-- local hk, dk, arena, honor = DS:GetStats(character, "PVP")
	
	-- AltoTooltip:AddLine(" ",1,1,1);
	-- AltoTooltip:AddDoubleLine(colors.white.. L["Arena points: "] .. colors.green .. arena, "HK: " .. colors.green .. hk )
	-- AltoTooltip:AddDoubleLine(colors.white.. L["Honor points: "] .. colors.green .. honor, "DK: " .. colors.green .. dk )
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(colors.green .. L["Right-Click for options"]);
	AltoTooltip:Show();
end

function ns:Level_OnClick(frame, button)
	local line = frame:GetParent():GetID()
	if line == 0 then return end

	local lineType = Characters:GetLineType(line)
	if lineType == INFO_TOTAL_LINE then		
		return
	end
	
	if button == "RightButton" then
		ns.CharInfoLine = line	-- line containing info about the alt on which action should be taken (delete, ..)
		ToggleDropDownMenu(1, nil, AltoholicFrameSummaryRightClickMenu, frame:GetName(), 0, -5);
		return
	elseif button == "LeftButton" and lineType == INFO_CHARACTER_LINE then
		addon.Tabs:OnClick("Characters")
		
		local tc = addon.Tabs.Characters
		tc:SetAlt(Characters:GetInfo(line))
		tc:MenuItem_OnClick(AltoholicTabCharacters.Characters, "LeftButton")
		addon.Containers:UpdateCache()
		tc:ViewCharInfo(VIEW_BAGS)
	end
end

function ns:AIL_OnEnter(frame)
	local line = frame:GetParent():GetID()
	local lineType = Characters:GetLineType(line)
	
	if lineType ~= INFO_CHARACTER_LINE then		
		return
	end
		
	local DS = DataStore
	local character = DS:GetCharacter(Characters:GetInfo(line))
	if not DataStore:GetModuleLastUpdateByKey("DataStore_Inventory", character) then
		return
	end
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(frame, "ANCHOR_RIGHT");
	AltoTooltip:AddLine(DS:GetColoredCharacterName(character),1,1,1);
	AltoTooltip:AddLine(colors.white .. L["Average Item Level"] ..": " .. colors.green.. format("%.1f", DS:GetAverageItemLevel(character)),1,1,1);

	addon:AiLTooltip()
	AltoTooltip:Show();
end

function addon:AiLTooltip()
	local tooltip = AltoTooltip
	
	tooltip:AddLine(" ",1,1,1);
	-- tooltip:AddLine(colors.teal .. L["Level"] .. " 60",1,1,1);
	-- tooltip:AddDoubleLine(colors.yellow .. "58-63", colors.white .. "Tier 0")
	-- tooltip:AddDoubleLine(colors.yellow .. "66", colors.white .. "Tier 1")
	-- tooltip:AddDoubleLine(colors.yellow .. "76", colors.white .. "Tier 2")
	-- tooltip:AddDoubleLine(colors.yellow .. "86-92", colors.white .. "Tier 3")
	-- tooltip:AddLine(" ",1,1,1);
	
	-- tooltip:AddLine(colors.teal .. L["Level"] .. " 70",1,1,1);
	-- tooltip:AddDoubleLine(colors.yellow .. "115", colors.white .. GetMapNameByID(799))	-- "Karazhan"
	-- tooltip:AddDoubleLine(colors.yellow .. "120", colors.white .. "Tier 4")
	-- tooltip:AddDoubleLine(colors.yellow .. "128", colors.white .. GetMapNameByID(781))	-- "Zul'Aman"
	-- tooltip:AddDoubleLine(colors.yellow .. "133", colors.white .. "Tier 5")
	-- tooltip:AddDoubleLine(colors.yellow .. "146-154", colors.white .. "Tier 6")
	-- tooltip:AddLine(" ",1,1,1);

	tooltip:AddLine(colors.teal .. L["Level"] .. " 80",1,1,1);
	tooltip:AddDoubleLine(colors.yellow .. "200", colors.white .. GetMapNameByID(535) .. " (10)")	-- "Naxxramas"
	tooltip:AddDoubleLine(colors.yellow .. "213", colors.white .. GetMapNameByID(535) .. " (25)")
	tooltip:AddDoubleLine(colors.yellow .. "200-219", colors.white .. GetMapNameByID(542))		-- "Trial of the Champion"
	tooltip:AddDoubleLine(colors.yellow .. "219", colors.white .. GetMapNameByID(529) .. " (10)")	-- "Ulduar"
	tooltip:AddDoubleLine(colors.yellow .. "226-239", colors.white .. GetMapNameByID(529) .. " (25)")
	tooltip:AddDoubleLine(colors.yellow .. "232-258", colors.white .. GetMapNameByID(543) .. " (10)")		-- "Trial of the Crusader"
	tooltip:AddDoubleLine(colors.yellow .. "245-272", colors.white .. GetMapNameByID(543) .. " (25)")
	tooltip:AddDoubleLine(colors.yellow .. "251-271", colors.white .. GetMapNameByID(604) .. " (10)")		-- "Icecrown Citadel"
	tooltip:AddDoubleLine(colors.yellow .. "264-284", colors.white .. GetMapNameByID(604) .. " (25)")
	tooltip:AddLine(" ",1,1,1);
	
	tooltip:AddLine(colors.teal .. L["Level"] .. " 85",1,1,1);
	tooltip:AddDoubleLine(colors.yellow .. "333", format("%s%s: %s", colors.white, CALENDAR_TYPE_DUNGEON, PLAYER_DIFFICULTY1))
	tooltip:AddDoubleLine(colors.yellow .. "346", format("%s%s: %s", colors.white, CALENDAR_TYPE_DUNGEON, PLAYER_DIFFICULTY2))
	tooltip:AddDoubleLine(colors.yellow .. "359", format("%s%s: %s", colors.white, CALENDAR_TYPE_RAID, PLAYER_DIFFICULTY1))
	tooltip:AddDoubleLine(colors.yellow .. "372", format("%s%s: %s", colors.white, CALENDAR_TYPE_RAID, PLAYER_DIFFICULTY2))
	
	tooltip:AddLine(colors.teal .. L["Level"] .. " 90",1,1,1);
	tooltip:AddDoubleLine(colors.yellow .. "358", format("%s%s: %s", colors.white, CALENDAR_TYPE_DUNGEON, PLAYER_DIFFICULTY1))
	tooltip:AddDoubleLine(colors.yellow .. "425", format("%s%s: %s", colors.white, GUILD_CHALLENGE_TYPE4, PLAYER_DIFFICULTY1))
	tooltip:AddDoubleLine(colors.yellow .. "435", format("%s%s: %s", colors.white, CALENDAR_TYPE_DUNGEON, PLAYER_DIFFICULTY2))
	tooltip:AddDoubleLine(colors.yellow .. "480", format("%s%s: %s", colors.white, GUILD_CHALLENGE_TYPE4, PLAYER_DIFFICULTY2))
	tooltip:AddLine(" ",1,1,1);
	tooltip:AddDoubleLine(colors.yellow .. "460", format("%s%s: %s", colors.white, GetMapNameByID(896), PLAYER_DIFFICULTY3))	-- "Mogu'shan Vaults"
	tooltip:AddDoubleLine(colors.yellow .. "470", format("%s%s: %s", colors.white, GetMapNameByID(897), PLAYER_DIFFICULTY3))	-- "Heart of Fear"
	tooltip:AddDoubleLine(colors.yellow .. "470", format("%s%s: %s", colors.white, GetMapNameByID(886), PLAYER_DIFFICULTY3))	-- "Terrace of Endless Spring"
	tooltip:AddDoubleLine(colors.yellow .. "480", format("%s%s: %s", colors.white, GetMapNameByID(930), PLAYER_DIFFICULTY3))	-- "Throne of Thunder"
	tooltip:AddDoubleLine(colors.yellow .. "496", format("%s%s: %s", colors.white, GetMapNameByID(953), PLAYER_DIFFICULTY3))	-- "Siege of Ogrimmar"
	tooltip:AddDoubleLine(colors.yellow .. "510", format("%s%s: %s", colors.white, GetMapNameByID(953), "10"))
	tooltip:AddDoubleLine(colors.yellow .. "520", format("%s%s: %s", colors.white, GetMapNameByID(953), PLAYER_DIFFICULTY4))
	tooltip:AddDoubleLine(colors.yellow .. "530", format("%s%s: %s", colors.white, GetMapNameByID(953), "25"))
end

function ns:RightClickMenu_OnLoad()
	local characterInfoLine = ns.CharInfoLine
	if not characterInfoLine then return end

	local lineType = Characters:GetLineType(characterInfoLine)
	if not lineType then return end

	if lineType == INFO_REALM_LINE then
		local _, realm, account = Characters:GetInfo(characterInfoLine)
		local _, updatedWith = addon:GetLastAccountSharingInfo(realm, account)
		
		if updatedWith then
			DDM_Add(format("Update from %s", colors.green..updatedWith), nil, UpdateRealm, characterInfoLine)
		end
		DDM_Add(L["Delete this Realm"], nil, DeleteRealm, characterInfoLine)
		return
	end

	DDM_Add(L["View bags"], VIEW_BAGS, ViewAltInfo, characterInfoLine)
	DDM_Add(L["View mailbox"], VIEW_MAILS, ViewAltInfo, characterInfoLine)
	DDM_Add(L["View quest log"], VIEW_QUESTS, ViewAltInfo, characterInfoLine)
	DDM_Add(L["View auctions"], VIEW_AUCTIONS, ViewAltInfo, characterInfoLine)
	DDM_Add(L["View bids"], VIEW_BIDS, ViewAltInfo, characterInfoLine)
	DDM_Add(COMPANIONS, VIEW_COMPANIONS, ViewAltInfo, characterInfoLine)
	DDM_Add(MOUNTS, VIEW_MOUNTS, ViewAltInfo, characterInfoLine)
	DDM_Add(L["Delete this Alt"], nil, DeleteAlt, characterInfoLine)
	DDM_AddCloseMenu()
end
