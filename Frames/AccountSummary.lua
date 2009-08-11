local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local INFO_REALM_LINE = 0
local INFO_CHARACTER_LINE = 1
local INFO_TOTAL_LINE = 2
local THIS_ACCOUNT = "Default"

local TEAL		= "|cFF00FF9A"
local WHITE		= "|cFFFFFFFF"
local GOLD		= "|cFFFFD700"
local YELLOW	= "|cFFFFFF00"
local GREEN		= "|cFF00FF00"

local VIEW_BAGS = 1
local VIEW_MAILS = 3
local VIEW_QUESTS = 4
local VIEW_AUCTIONS = 5
local VIEW_BIDS = 6
local VIEW_COMPANIONS = 7
local VIEW_MOUNTS = 8

local ICON_FACTION_HORDE = "Interface\\Icons\\INV_BannerPVP_01"
local ICON_FACTION_ALLIANCE = "Interface\\Icons\\INV_BannerPVP_02"

local function GetFactionTotals(f, line)
	local _, realm, account = Altoholic.Characters:GetInfo(line)
	
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

Altoholic.Summary = {}

function Altoholic.Summary:Update()
	local VisibleLines = 14
	local frame = "AltoholicFrameSummary"
	local entry = frame.."Entry"
	
	local Characters = Altoholic.Characters
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawRealm
	local CurrentAccount, CurrentRealm
	local i=1
	
	local DS = DataStore
	
	for _, line in pairs(Characters:GetView()) do
		local s = Characters:Get(line)
		local lineType = mod(s.linetype, 3)
		
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if lineType == INFO_REALM_LINE then								-- then keep track of counters
				CurrentAccount = s.account
				CurrentRealm = s.realm
				if s.isCollapsed == false then
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
				CurrentAccount = s.account
				CurrentRealm = s.realm
				if s.isCollapsed == false then
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
				if s.account == "Default" then	-- saved as default, display as localized.
					_G[entry..i.."NameNormalText"]:SetText(format("%s (%s".. L["Account"]..": %s%s|r)", s.realm, WHITE, GREEN, L["Default"]))
				else
					local last = Altoholic:GetLastAccountSharingInfo(CurrentRealm, CurrentAccount)
					_G[entry..i.."NameNormalText"]:SetText(format("%s (%s".. L["Account"]..": %s%s %s%s|r)", s.realm, WHITE, GREEN, s.account, YELLOW, last or ""))
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
					local character = DS:GetCharacter(s.name, CurrentRealm, CurrentAccount)
					
					local icon
					if DS:GetCharacterFaction(character) == "Alliance" then
						icon = Altoholic:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18) .. " "
					else
						icon = Altoholic:TextureToFontstring(ICON_FACTION_HORDE, 18, 18) .. " "
					end
					
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(170)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 10, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(170)
					_G[entry..i.."NameNormalText"]:SetText(icon .. format("%s (%s)", DS:GetColoredCharacterName(character), DS:GetCharacterClass(character)))
					_G[entry..i.."Level"]:SetText(GREEN .. DS:GetCharacterLevel(character))

					_G[entry..i.."Money"]:SetText(Altoholic:GetMoneyString(DS:GetMoney(character)))
					_G[entry..i.."Played"]:SetText(Altoholic:GetTimeString(DS:GetPlayTime(character)))
					_G[entry..i.."XP"]:SetText(GREEN .. DS:GetXPRate(character) .. "%")

					if DS:GetCharacterLevel(character) == MAX_PLAYER_LEVEL then
						_G[entry..i.."Rested"]:SetText(WHITE .. "0%")
					else
						_G[entry..i.."Rested"]:SetText( Altoholic:GetRestedXP(character) )
					end
					
					_G[entry..i.."AvgILevelNormalText"]:SetText(YELLOW..format("%.1f", DS:GetAverageItemLevel(character)))
					
				elseif (lineType == INFO_TOTAL_LINE) then
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(200)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(200)
					_G[entry..i.."NameNormalText"]:SetText(L["Totals"])
					_G[entry..i.."Level"]:SetText(s.level)
					_G[entry..i.."Money"]:SetText(s.money)
					_G[entry..i.."Money"]:SetTextColor(1.0, 1.0, 1.0)
					_G[entry..i.."Played"]:SetText(s.played)
					_G[entry..i.."XP"]:SetText("")
					_G[entry..i.."Rested"]:SetText("")
					_G[entry..i.."AvgILevelNormalText"]:SetText("")
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
	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleCount, VisibleLines, 18);
end

function Altoholic.Summary:Level_OnEnter(self)
	local line = self:GetParent():GetID()
	local s = Altoholic.Characters:Get(line)
	
	if mod(s.linetype, 3) == INFO_REALM_LINE then		
		return
	elseif mod(s.linetype, 3) == INFO_TOTAL_LINE then		
		AltoTooltip:ClearLines();
		AltoTooltip:SetOwner(self, "ANCHOR_TOP");
		AltoTooltip:AddLine(L["Totals"]);
		
		local aLevels, aMoney, aPlayed = GetFactionTotals("Alliance", line)
		local hLevels, hMoney, hPlayed = GetFactionTotals("Horde", line)
		
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddDoubleLine(WHITE..L["Levels"] , format("%s|r (%s %s|r, %s %s|r)", 
			s.level,
			Altoholic:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18), WHITE..aLevels,
			Altoholic:TextureToFontstring(ICON_FACTION_HORDE, 18, 18), WHITE..hLevels))
		
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddDoubleLine(WHITE..MONEY, format("%s|r (%s %s|r, %s %s|r)", 
			s.money,
			Altoholic:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18), 
			Altoholic:GetMoneyString(aMoney, WHITE),
			Altoholic:TextureToFontstring(ICON_FACTION_HORDE, 18, 18), 
			Altoholic:GetMoneyString(hMoney, WHITE)))
		
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddDoubleLine(WHITE..PLAYED , format("%s|r (%s %s|r, %s %s|r)",
			s.played,
			Altoholic:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18),
			Altoholic:GetTimeString(aPlayed),
			Altoholic:TextureToFontstring(ICON_FACTION_HORDE, 18, 18), 
			Altoholic:GetTimeString(hPlayed)))
		
		AltoTooltip:Show();
		return
	end
	
	local DS = DataStore
	local character = DS:GetCharacter(Altoholic.Characters:GetInfo(line))
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT");
	
	AltoTooltip:AddDoubleLine(DS:GetColoredCharacterName(character), DS:GetColoredCharacterFaction(character))
	AltoTooltip:AddLine(format("%s %s |r%s %s", L["Level"], 
		GREEN..DS:GetCharacterLevel(character), DS:GetCharacterRace(character),	DS:GetCharacterClass(character)),1,1,1)

	local zone, subZone = DS:GetLocation(character)
	AltoTooltip:AddLine(format("%s: %s |r(%s|r)", L["Zone"], GOLD..zone, GOLD..subZone),1,1,1)
	
	local guildName = DS:GetGuildInfo(character)
	if guildName then
		AltoTooltip:AddLine(format("%s: %s", GUILD, GREEN..guildName),1,1,1)
	end
	
	AltoTooltip:AddLine(EXPERIENCE_COLON .. " " 
				.. GREEN .. DS:GetXP(character) .. WHITE .. "/" 
				.. GREEN .. DS:GetXPMax(character) .. WHITE .. " (" 
				.. GREEN .. DS:GetXPRate(character) .. "%"
				.. WHITE .. ")",1,1,1);	
	
	local restXP = DS:GetRestXP(character)
	if restXP and restXP > 0 then
		AltoTooltip:AddLine(format("%s: %s", L["Rest XP"], GREEN..restXP),1,1,1)
	end
	
	local suggestion = Altoholic:GetSuggestion("Leveling", DS:GetCharacterLevel(character))
	if suggestion then
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddLine(L["Suggested leveling zone: "],1,1,1);
		AltoTooltip:AddLine(TEAL .. suggestion,1,1,1);
	end

	-- parse saved instances
	local c = Altoholic:GetCharacterTableByLine(line)
	
	local bLineBreak = true
	for Instance, InstanceInfo in pairs (c.SavedInstance) do
		local InstanceName, InstanceID = strsplit("|", Instance)
			
		local reset, lastcheck = strsplit("|", InstanceInfo)
		reset = tonumber(reset)
		lastcheck = tonumber(lastcheck)
		local expiresIn = reset - (time() - lastcheck)
		
		if expiresIn > 0 then
			if bLineBreak then
				AltoTooltip:AddLine(" ",1,1,1);		-- add a line break only once
				bLineBreak = nil
			end
			AltoTooltip:AddDoubleLine(GOLD .. InstanceName .. 
				" (".. WHITE.."ID: " .. GREEN .. InstanceID .. "|r)", Altoholic:GetTimeString(expiresIn))
		else
			c.SavedInstance[Instance] = nil
		end
	end
	
	-- add PVP info if any

	local hk, dk, arena, honor = DS:GetStats(character, "PVP")
	
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddDoubleLine(WHITE.. L["Arena points: "] .. GREEN .. arena, "HK: " .. GREEN .. hk )
	AltoTooltip:AddDoubleLine(WHITE.. L["Honor points: "] .. GREEN .. honor, "DK: " .. GREEN .. dk )
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(GREEN .. L["Right-Click for options"]);
	AltoTooltip:Show();
end

function Altoholic.Summary:Level_OnClick(frame, button)
	local self = Altoholic.Summary
	local line = frame:GetParent():GetID()
	if line == 0 then return end

	local s = Altoholic.Characters:Get(line)

	local linetype = mod(s.linetype, 3)
	
	if linetype == INFO_TOTAL_LINE then		
		return
	end
	
	if button == "RightButton" then
		self.CharInfoLine = line	-- line containing info about the alt on which action should be taken (delete, ..)
		ToggleDropDownMenu(1, nil, AltoholicFrameSummaryRightClickMenu, frame:GetName(), 0, -5);
		return
	elseif button == "LeftButton" and linetype == INFO_CHARACTER_LINE then
	
		local tc = Altoholic.Tabs.Characters
		local charName, realm, account = Altoholic.Characters:GetInfo(line)
		Altoholic:SetCurrentCharacter(charName, realm, account)
		Altoholic.Tabs.Characters:SetCurrent(charName, realm, account)
		
		Altoholic.Reputations:BuildView()
		Altoholic.Tabs:OnClick(2)
		Altoholic.Containers:UpdateCache()
		AltoholicFrameAchievements:Hide()
		tc:ViewCharInfo(VIEW_BAGS)
	end
end

function Altoholic.Summary:AIL_OnEnter(self)
	local line = self:GetParent():GetID()
	local s = Altoholic.Characters:Get(line)
	
	if mod(s.linetype, 3) ~= INFO_CHARACTER_LINE then		
		return
	end
		
	local DS = DataStore
	local character = DS:GetCharacter(Altoholic.Characters:GetInfo(line))
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT");
	AltoTooltip:AddLine(DS:GetColoredCharacterName(character),1,1,1);
	AltoTooltip:AddLine(WHITE .. L["Average Item Level"] ..": " .. GREEN.. format("%.1f", DS:GetAverageItemLevel(character)),1,1,1);

	Altoholic:AiLTooltip()
	AltoTooltip:Show();
end

function Altoholic:AiLTooltip()
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(TEAL .. L["Level"] .. " 60",1,1,1);
	AltoTooltip:AddDoubleLine(YELLOW .. "58-63", WHITE .. "Tier 0")
	AltoTooltip:AddDoubleLine(YELLOW .. "66", WHITE .. "Tier 1")
	AltoTooltip:AddDoubleLine(YELLOW .. "76", WHITE .. "Tier 2")
	AltoTooltip:AddDoubleLine(YELLOW .. "86-92", WHITE .. "Tier 3")
	AltoTooltip:AddLine(" ",1,1,1);
	
	AltoTooltip:AddLine(TEAL .. L["Level"] .. " 70",1,1,1);
	AltoTooltip:AddDoubleLine(YELLOW .. "115", WHITE .. BZ["Karazhan"])
	AltoTooltip:AddDoubleLine(YELLOW .. "120", WHITE .. "Tier 4")
	AltoTooltip:AddDoubleLine(YELLOW .. "128", WHITE .. BZ["Zul'Aman"])
	AltoTooltip:AddDoubleLine(YELLOW .. "133", WHITE .. "Tier 5")
	AltoTooltip:AddDoubleLine(YELLOW .. "146-154", WHITE .. "Tier 6")
	AltoTooltip:AddLine(" ",1,1,1);

	AltoTooltip:AddLine(TEAL .. L["Level"] .. " 80",1,1,1);
	AltoTooltip:AddDoubleLine(YELLOW .. "200", WHITE .. BZ["Naxxramas"] .. " (10)")
	AltoTooltip:AddDoubleLine(YELLOW .. "213", WHITE .. BZ["Naxxramas"] .. " (25)")
	AltoTooltip:AddDoubleLine(YELLOW .. "200-219", WHITE .. BZ["Trial of the Champion"])
	AltoTooltip:AddDoubleLine(YELLOW .. "219", WHITE .. BZ["Ulduar"] .. " (10)")
	AltoTooltip:AddDoubleLine(YELLOW .. "226-239", WHITE .. BZ["Ulduar"] .. " (25)")
	AltoTooltip:AddDoubleLine(YELLOW .. "232-258", WHITE .. BZ["Trial of the Crusader"] .. " (10)")
	AltoTooltip:AddDoubleLine(YELLOW .. "245-272", WHITE .. BZ["Trial of the Crusader"] .. " (25)")
end

function Altoholic.Summary:RightClickMenu_OnLoad()
	local self = Altoholic.Summary
	if not self.CharInfoLine then return end
	
	local s = Altoholic.Characters:Get(self.CharInfoLine)
	if not s then return end
	
	local info = UIDropDownMenu_CreateInfo(); 

	if mod(s.linetype, 3) == INFO_REALM_LINE then
		local _, updatedWith = Altoholic:GetLastAccountSharingInfo(s.realm, s.account)
		
		if updatedWith then
			info.text		= format("Update from %s", GREEN..updatedWith)
			info.func		= self.UpdateRealm
			UIDropDownMenu_AddButton(info, 1);
		end
		
		info.text		= L["Delete this Realm"]
		info.func		= self.DeleteRealm;
		UIDropDownMenu_AddButton(info, 1);
		return
	end

	info.text		= L["View bags"]
	info.value		= VIEW_BAGS
	info.func		= self.ViewAltInfo
	UIDropDownMenu_AddButton(info, 1); 

	info.text		= L["View mailbox"]
	info.value		= VIEW_MAILS
	info.func		= self.ViewAltInfo
	UIDropDownMenu_AddButton(info, 1); 
	
	info.text		= L["View quest log"]
	info.value		= VIEW_QUESTS
	info.func		= self.ViewAltInfo
	UIDropDownMenu_AddButton(info, 1); 
	
	info.text		= L["View auctions"]
	info.value		= VIEW_AUCTIONS
	info.func		= self.ViewAltInfo
	UIDropDownMenu_AddButton(info, 1); 

	info.text		= L["View bids"]
	info.value		= VIEW_BIDS
	info.func		= self.ViewAltInfo
	UIDropDownMenu_AddButton(info, 1);
	
	info.text		= COMPANIONS
	info.value		= VIEW_COMPANIONS
	info.func		= self.ViewAltInfo
	UIDropDownMenu_AddButton(info, 1); 
	
	info.text		= MOUNTS
	info.value		= VIEW_MOUNTS
	info.func		= self.ViewAltInfo
	UIDropDownMenu_AddButton(info, 1); 
	
	info.text		= L["Delete this Alt"]
	info.func		= self.DeleteAlt;
	UIDropDownMenu_AddButton(info, 1); 
	
	-- Close menu item
	info.text = CLOSE
	info.func = function() CloseDropDownMenus() end
	info.checked = nil
	info.icon = nil
	info.notCheckable = 1
	UIDropDownMenu_AddButton(info, 1)
end

function Altoholic.Summary:ViewAltInfo()
	local self = Altoholic.Summary
	local line = self.CharInfoLine
	self.CharInfoLine = nil

	local charName, realm, account = Altoholic.Characters:GetInfo(line)
	Altoholic:SetCurrentCharacter(charName, realm, account)
	Altoholic.Tabs.Characters:SetCurrent(charName, realm, account)
	
	Altoholic.Tabs:OnClick(2)
	Altoholic.Tabs.Characters:ViewCharInfo(this.value)
end

function Altoholic.Summary:DeleteAlt()
	local self = Altoholic.Summary
	local s = Altoholic.Characters:Get(self.CharInfoLine) -- no validity check, this comes from the dropdownmenu, it's been secured earlier
	local _, realm, account = Altoholic.Characters:GetInfo(self.CharInfoLine)
	
	if (account == "Default") and	(realm == GetRealmName()) and (s.name == UnitName("player")) then
		self.CharInfoLine = nil
		Altoholic:Print(L["Cannot delete current character"])
		return
	end

	AltoMsgBox.ButtonHandler = self.DeleteAltButtonHandler
	AltoMsgBox_Text:SetText(L["Delete this Alt"] .. "?\n" .. s.name)
	AltoMsgBox:Show()
end

function Altoholic.Summary:DeleteAltButtonHandler(button)
	local self = Altoholic.Summary
	AltoMsgBox.ButtonHandler = nil		-- prevent any other call to msgbox from coming back here
	local line = self.CharInfoLine
	self.CharInfoLine = nil
	if not button then return end
	
	local name, realm, account = Altoholic.Characters:GetInfo(line)
	
	DataStore:DeleteCharacter(name, realm, account)
	
	-- rebuild the main character table, and all the menus
	Altoholic.Characters:BuildList()
	Altoholic.Characters:BuildView()
	Altoholic.Reputations:BuildView()
	AltoholicFrameAchievements:Hide()
	Altoholic.Summary:Update()
		
	Altoholic:Print(format( L["Character %s successfully deleted"], name))
end

function Altoholic.Summary:UpdateRealm()
	local self = Altoholic.Summary
	local s = Altoholic.Characters:Get(self.CharInfoLine) -- no validity check, this comes from the dropdownmenu, it's been secured earlier
	
	AltoAccountSharing_AccNameEditBox:SetText(s.account)
	AltoAccountSharing_UseTarget:SetChecked(nil)
	AltoAccountSharing_UseName:SetChecked(1)
	
	local _, updatedWith = Altoholic:GetLastAccountSharingInfo(s.realm, s.account)
	AltoAccountSharing_AccTargetEditBox:SetText(updatedWith)
	
	Altoholic.Tabs.Summary:AccountSharingButton_OnClick()
end

function Altoholic.Summary:DeleteRealm()
	local self = Altoholic.Summary
	local s = Altoholic.Characters:Get(self.CharInfoLine) -- no validity check, this comes from the dropdownmenu, it's been secured earlier
		
	if (s.account == "Default") and	(s.realm == GetRealmName()) then
		self.CharInfoLine = nil
		Altoholic:Print(L["Cannot delete current realm"])
		return
	end

	AltoMsgBox.ButtonHandler = self.DeleteRealmButtonHandler
	AltoMsgBox_Text:SetText(L["Delete this Realm"] .. "?\n" .. s.realm)
	AltoMsgBox:Show()
end

function Altoholic.Summary:DeleteRealmButtonHandler(button)
	local self = Altoholic.Summary
	AltoMsgBox.ButtonHandler = nil		-- prevent any other call to msgbox from coming back here
	local line = self.CharInfoLine
	self.CharInfoLine = nil
	if not button then return end

	local s = Altoholic.Characters:Get(line) -- no validity check, this comes from the dropdownmenu, it's been secured earlier
	local realmName = s.realm
	
	-- wipe(Altoholic.db.global.data[s.account][s.realm])
	-- Altoholic.db.global.data[s.account][s.realm] = nil

	-- if the realm being deleted was the current ..
	if Altoholic:GetCurrentRealm() == s.realm and Altoholic:GetCurrentAccount() == s.account then
		
		-- reset to this player
		local tc = Altoholic.Tabs.Characters
		local player = UnitName("player")
		local realm = GetRealmName()
		Altoholic:SetCurrentCharacter(player, realm, THIS_ACCOUNT)
		Altoholic.Tabs.Characters:SetCurrent(player, realm, THIS_ACCOUNT)
		Altoholic.Containers:UpdateCache()
		tc:ViewCharInfo(VIEW_BAGS)
	end
	
	-- rebuild the main character table, and all the menus
	Altoholic.Characters:BuildList()
	Altoholic.Characters:BuildView()
	Altoholic.Reputations:BuildView()
	AltoholicFrameAchievements:Hide()
	Altoholic.Summary:Update()
		
	Altoholic:Print(format( L["Realm %s successfully deleted"], realmName))
end
