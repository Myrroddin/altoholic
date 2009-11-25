local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local INFO_REALM_LINE = 0
local INFO_CHARACTER_LINE = 1
local INFO_TOTAL_LINE = 2

local WHITE		= "|cFFFFFFFF"
local TEAL		= "|cFF00FF9A"
local RED		= "|cFFFF0000"
local ORANGE	= "|cFFFF7F00"
local YELLOW	= "|cFFFFFF00"
local GREEN		= "|cFF00FF00"

local RECIPE_GREY		= "|cFF808080"
local RECIPE_GREEN	= "|cFF40C040"
local RECIPE_ORANGE	= "|cFFFF8040"

local ICON_FACTION_HORDE = "Interface\\Icons\\INV_BannerPVP_01"
local ICON_FACTION_ALLIANCE = "Interface\\Icons\\INV_BannerPVP_02"

function Altoholic.TradeSkills:Update()
	local VisibleLines = 14
	local frame = "AltoholicFrameSkills"
	local entry = frame.."Entry"
	
	local self = Altoholic.TradeSkills
	local Characters = Altoholic.Characters
	local DS = DataStore
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawRealm
	local CurrentAccount, CurrentRealm
	local i=1
	
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
			if lineType== INFO_REALM_LINE then
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
				_G[entry..i.."Skill1NormalText"]:SetText("")
				_G[entry..i.."Skill2NormalText"]:SetText("")
				_G[entry..i.."CookingNormalText"]:SetText("")
				_G[entry..i.."FirstAidNormalText"]:SetText("")
				_G[entry..i.."FishingNormalText"]:SetText("")
				_G[entry..i.."RidingNormalText"]:SetText("")
				
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
					
					if s.spellID1 then
						icon = Altoholic:TextureToFontstring(Altoholic:GetSpellIcon(s.spellID1), 18, 18) .. " "
					else
						icon = ""
					end
					_G[entry..i.."Skill1NormalText"]:SetText(icon .. self:GetColor(s.skillRank1) .. s.skillRank1)
					
					if s.spellID2 then
						icon = Altoholic:TextureToFontstring(Altoholic:GetSpellIcon(s.spellID2), 18, 18) .. " "
					else
						icon = ""
					end
					_G[entry..i.."Skill2NormalText"]:SetText(icon .. self:GetColor(s.skillRank2) .. s.skillRank2)
						
					icon = Altoholic:TextureToFontstring(Altoholic:GetSpellIcon(2550), 18, 18) .. " "
					_G[entry..i.."CookingNormalText"]:SetText(icon .. self:GetColor(s.cooking) .. s.cooking)
					icon = Altoholic:TextureToFontstring(Altoholic:GetSpellIcon(3273), 18, 18) .. " "
					_G[entry..i.."FirstAidNormalText"]:SetText(icon .. self:GetColor(s.firstaid) .. s.firstaid)
					icon = Altoholic:TextureToFontstring(Altoholic:GetSpellIcon(7733), 18, 18) .. " "
					_G[entry..i.."FishingNormalText"]:SetText(icon .. self:GetColor(s.fishing) .. s.fishing)
					
					local character = DS:GetCharacter(s.name, CurrentRealm, CurrentAccount)
					
					if DS:IsSpellKnown(character, 54197) then
						icon = Altoholic:TextureToFontstring(Altoholic:GetSpellIcon(54197), 18, 18) .. " "
					elseif s.riding >= 225 then
						icon = Altoholic:TextureToFontstring("Interface\\Icons\\Ability_Mount_Gryphon_01", 18, 18) .. " "
					else
						icon = Altoholic:TextureToFontstring("Interface\\Icons\\Ability_Mount_RidingHorse", 18, 18) .. " "
					end
					_G[entry..i.."RidingNormalText"]:SetText(icon .. self:GetColor(s.riding, 300) .. s.riding)
				elseif (lineType == INFO_TOTAL_LINE) then
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(200)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(200)
					_G[entry..i.."NameNormalText"]:SetText(L["Totals"])
					_G[entry..i.."Level"]:SetText(s.level)
					_G[entry..i.."Skill1NormalText"]:SetText("")
					_G[entry..i.."Skill2NormalText"]:SetText("")
					_G[entry..i.."CookingNormalText"]:SetText("")
					_G[entry..i.."FirstAidNormalText"]:SetText("")
					_G[entry..i.."FishingNormalText"]:SetText("")
					_G[entry..i.."RidingNormalText"]:SetText("")
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

function Altoholic.TradeSkills:OnEnter(self)
	local line = self:GetParent():GetID()
	local s = Altoholic.Characters:Get(line)
	
	if mod(s.linetype, 3) ~= INFO_CHARACTER_LINE then		
		return
	end
	local id = self:GetID()
	local skillName, rank, suggestion
	
	if id == 1 then
		skillName = s.skillName1
	elseif id == 2 then
		skillName = s.skillName2
	elseif id == 3 then
		skillName = GetSpellInfo(2550)		-- cooking
	elseif id == 4 then
		skillName = GetSpellInfo(3273)		-- First Aid
	elseif id == 5 then
		skillName = GetSpellInfo(24303)	-- Fishing
	elseif id == 6 then
		skillName = L["Riding"]
	end

	local ts = Altoholic.TradeSkills
	local DS = DataStore
	local character = DS:GetCharacter(Altoholic.Characters:GetInfo(line))
	local curRank, maxRank = DS:GetSkillInfo(character, skillName)
	local profession = DS:GetProfession(character, skillName)
	
	if (id >= 1) and (id <= 6) then
		if id == 6 then	-- riding
			rank = ts:GetColor(curRank, 300) .. curRank .. "/" .. maxRank
		else
			rank = ts:GetColor(curRank) .. curRank .. "/" .. maxRank
		end
		suggestion = Altoholic:GetSuggestion(skillName, curRank)
	elseif id == 7 then	-- class
		local _, class = DS:GetCharacterClass(character)
		if class ~= "ROGUE" then
			return
		end
		skillName = L["Rogue Proficiencies"]
		
		local curLock, maxLock = DS:GetSkillInfo(character, L["Lockpicking"])
		rank = TEAL .. L["Lockpicking"] .. " " .. curLock .. "/" .. maxLock
		suggestion = Altoholic:GetSuggestion(L["Lockpicking"], curLock)
	end
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT");
	AltoTooltip:AddLine(skillName,1,1,1);
	AltoTooltip:AddLine(GREEN..rank,1,1,1);
	
	if id <= 4 then	-- all skills except fishing & riding
		AltoTooltip:AddLine(" ");
		
		if not profession then
			AltoTooltip:AddLine(L["No data"]);
			AltoTooltip:Show();
			return
		end
		
		if DS:GetNumCraftLines(profession) == 0 then
			AltoTooltip:AddLine(L["No data"].. ": 0 " .. TRADESKILL_SERVICE_LEARN,1,1,1);
		else
			local orange, yellow, green, grey = DS:GetNumRecipesByColor(profession)
			
			AltoTooltip:AddLine(orange+yellow+green+grey .. " " .. TRADESKILL_SERVICE_LEARN,1,1,1);
			AltoTooltip:AddLine(format(WHITE .. "%d " .. RECIPE_GREEN .. "Green|r /" 
				..	WHITE .. " %d " .. YELLOW .. "Yellow|r /" 
				..	WHITE .. " %d " .. RECIPE_ORANGE .. "Orange", 
				green, yellow, orange))
		end
	end
	
	local skillCap = 450
	if id == 6 then
		skillCap = 300
	end
	
	AltoTooltip:AddLine(" ");
	AltoTooltip:AddLine(RECIPE_GREY .. L["Grey"] .. "|r " .. L["up to"] .. " " .. (floor(skillCap*0.25)-1),1,1,1);
	AltoTooltip:AddLine(RED .. RED_GEM .. "|r " .. L["up to"] .. " " .. (floor(skillCap*0.50)-1),1,1,1);
	AltoTooltip:AddLine(ORANGE .. BI["Orange"] .. "|r " .. L["up to"] .. " " .. (floor(skillCap*0.75)-1),1,1,1);
	AltoTooltip:AddLine(YELLOW .. YELLOW_GEM .. "|r " .. L["up to"] .. " " .. (skillCap-1),1,1,1);
	AltoTooltip:AddLine(GREEN .. BI["Green"] .. "|r " .. L["at"] .. " "..skillCap.." " .. L["and above"],1,1,1);

	if suggestion then
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddLine(L["Suggestion"] .. ": ",1,1,1);
		AltoTooltip:AddLine(TEAL .. suggestion,1,1,1);
	end
	
	-- parse profession cooldowns
	if id ~= 7 and profession then
		DS:ClearExpiredCooldowns(profession)
		local numCooldows = DS:GetNumActiveCooldowns(profession)
		
		if numCooldows == 0 then
			AltoTooltip:AddLine(" ",1,1,1);
			AltoTooltip:AddLine(L["All cooldowns are up"],1,1,1);
		else
			AltoTooltip:AddLine(" ",1,1,1);
			for i = 1, numCooldows do
				local craftName, expiresIn = DS:GetCraftCooldownInfo(profession, i)
				AltoTooltip:AddDoubleLine(craftName, Altoholic:GetTimeString(expiresIn));
			end
		end
	end
	
	AltoTooltip:Show();
end

local VIEW_MOUNTS = 8

function Altoholic.TradeSkills:OnClick(self, button)
	local line = self:GetParent():GetID()
	local s = Altoholic.Characters:Get(line)
	
	if mod(s.linetype, 3) ~= INFO_CHARACTER_LINE then		
		return
	end
	local id = self:GetID()
	
	if id == 5 then return end		-- fishing ? do nothing
	
	Altoholic:SetCurrentCharacter( Altoholic.Characters:GetInfo(line) )
	
	local skillName
	if id == 1 then
		skillName = s.skillName1
	elseif id == 2 then
		skillName = s.skillName2
	elseif id == 3 then
		skillName = GetSpellInfo(2550)		-- cooking
	elseif id == 4 then
		skillName = GetSpellInfo(3273)		-- First Aid
	end

	local DS = DataStore
	local character = DS:GetCharacter(Altoholic.Characters:GetInfo(line))
	local profession = DS:GetProfession(character, skillName)
	
	if skillName then
		if DS:GetNumCraftLines(profession) == 0 then		-- if profession hasn't been scanned (or scan failed), exit
			return
		end
	end
	
	local charName, realm, account = Altoholic:GetCurrentCharacter()
	
	if ChatFrameEditBox:IsShown() and IsShiftKeyDown() and realm == GetRealmName() and id ~= 6 then
		-- if shift-click, then display the profession link and exit
		local link = profession.FullLink	
		if link and link:match("trade:") then
			ChatFrameEditBox:Insert(link);
		end
		return
	end

	Altoholic.Tabs.Characters:SetCurrent(charName, realm, account)
	Altoholic.Tabs:OnClick(2)

	if id == 6 then
		Altoholic.Tabs.Characters:ViewCharInfo(VIEW_MOUNTS)
	else
		Altoholic.Tabs.Characters:ViewRecipes(skillName)
	end
end

local skillColors = { RECIPE_GREY, RED, ORANGE, YELLOW, GREEN }

function Altoholic.TradeSkills:GetColor(rank, skillCap)
	skillCap = skillCap or 450
	return skillColors[ floor(rank / (skillCap/4)) + 1 ]
end
