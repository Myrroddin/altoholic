local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local INFO_REALM_LINE = 0
local INFO_CHARACTER_LINE = 1
local INFO_TOTAL_LINE = 2

local ICON_FACTION_HORDE = "Interface\\Icons\\INV_BannerPVP_01"
local ICON_FACTION_ALLIANCE = "Interface\\Icons\\INV_BannerPVP_02"
local CURRENCY_ID_CONQUEST = 390
local CURRENCY_ID_HONOR = 392
local CURRENCY_ID_JUSTICE = 395
local CURRENCY_ID_VALOR = 396
local CURRENCY_ID_APEXIS = 823
local CURRENCY_ID_GARRISON = 824
local CURRENCY_ID_SOTF = 994		-- Seals of Tempered Fate (WoD)

addon.Currencies = {}

local ns = addon.Currencies		-- ns = namespace
local Characters = addon.Characters

function ns:Update()
	local VisibleLines = 14
	local frame = "AltoholicFrameCurrencies"
	local entry = frame.."Entry"
	
	local DS = DataStore
	
	local offset = addon.ScrollFrames:GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawRealm
	local i=1
	
	for _, line in pairs(Characters:GetView()) do
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
				if account == "Default" then	-- saved as default, display as localized.
					_G[entry..i.."NameNormalText"]:SetText(format("%s (%s".. L["Account"]..": %s%s|r)", realm, colors.white, colors.green, L["Default"]))
				else
					local last = addon:GetLastAccountSharingInfo(realm, account)
					_G[entry..i.."NameNormalText"]:SetText(format("%s (%s".. L["Account"]..": %s%s %s%s|r)", realm, colors.white, colors.green, account, colors.yellow, last or ""))
				end				
				_G[entry..i.."Level"]:SetText("")
				
				_G[entry..i.."Currency1NormalText"]:SetText("")
				_G[entry..i.."Currency2NormalText"]:SetText("")
				_G[entry..i.."Currency3NormalText"]:SetText("")
				_G[entry..i.."Currency4NormalText"]:SetText("")
				_G[entry..i.."Currency5NormalText"]:SetText("")
				
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
				
					-- Garrison resources
					local uncollected = DataStore:GetUncollectedResources(character) or 0
					
					local amount, earnedThisWeek, weeklyMax, totalMax = DataStore:GetCurrencyTotals(character, CURRENCY_ID_GARRISON)
					local color = (amount == 0) and colors.grey or colors.white
					
					_G[entry..i.."Currency1NormalText"]:SetText(format("%s%s/%s+%s", color, amount, colors.green, uncollected))
					
					-- Apexis crystals
					amount, earnedThisWeek, weeklyMax, totalMax = DataStore:GetCurrencyTotals(character, CURRENCY_ID_APEXIS)

					color = (amount == 0) and colors.grey or colors.white
					_G[entry..i.."Currency2NormalText"]:SetWidth(100)
					_G[entry..i.."Currency2NormalText"]:SetText(format("%s%s%s/%s%s", color, amount, colors.white, colors.yellow, totalMax))
					
					-- Seals of Tempered Fate
					amount, earnedThisWeek, weeklyMax, totalMax = DataStore:GetCurrencyTotals(character, CURRENCY_ID_SOTF)
					color = (amount == 0) and colors.grey or colors.white
					
					_G[entry..i.."Currency3NormalText"]:SetText(format("%s%s%s/%s%s", color, amount, colors.white, colors.yellow, totalMax))
					
					-- Honor points
					amount, earnedThisWeek, weeklyMax, totalMax = DataStore:GetCurrencyTotals(character, CURRENCY_ID_HONOR)
					color = (amount == 0) and colors.grey or colors.white
					
					_G[entry..i.."Currency4NormalText"]:SetText(format("%s%s%s/%s%s", color, amount, colors.white, colors.yellow, totalMax))
					
					-- Conquest points
					amount, earnedThisWeek, weeklyMax, totalMax = DataStore:GetCurrencyTotals(character, CURRENCY_ID_CONQUEST)
					color = (earnedThisWeek == 0) and colors.grey or colors.white
					
					_G[entry..i.."Currency5NormalText"]:SetText(format("%s%s%s/%s%s", color, earnedThisWeek, colors.white, colors.yellow, weeklyMax))

				elseif (lineType == INFO_TOTAL_LINE) then
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(200)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(200)
					_G[entry..i.."NameNormalText"]:SetText(L["Totals"])
					_G[entry..i.."Level"]:SetText(Characters:GetField(line, "level"))
					_G[entry..i.."Currency1NormalText"]:SetText("")
					_G[entry..i.."Currency2NormalText"]:SetText("")
					_G[entry..i.."Currency3NormalText"]:SetText("")
					_G[entry..i.."Currency4NormalText"]:SetText("")
					_G[entry..i.."Currency5NormalText"]:SetText("")
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

	addon.ScrollFrames:Update( AltoholicFrameCurrencies.ScrollFrame, VisibleCount, VisibleLines, 18)
end	

function ns:OnEnter(self)
	local line = self:GetParent():GetID()
	local lineType = Characters:GetLineType(line)
	if lineType ~= INFO_CHARACTER_LINE then		
		return
	end
	
	local DS = DataStore
	local character = DS:GetCharacter(Characters:GetInfo(line))
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT");
	
	AltoTooltip:AddDoubleLine(DS:GetColoredCharacterName(character), DS:GetColoredCharacterFaction(character))
	AltoTooltip:AddLine(format("%s %s |r%s %s", L["Level"], 
		colors.green..DS:GetCharacterLevel(character), DS:GetCharacterRace(character),	DS:GetCharacterClass(character)),1,1,1)

	local zone, subZone = DS:GetLocation(character)
	AltoTooltip:AddLine(format("%s: %s |r(%s|r)", L["Zone"], colors.gold..zone, colors.gold..subZone),1,1,1)
	
	AltoTooltip:AddLine(EXPERIENCE_COLON .. " " 
				.. colors.green .. DS:GetXP(character) .. colors.white .. "/" 
				.. colors.green .. DS:GetXPMax(character) .. colors.white .. " (" 
				.. colors.green .. DS:GetXPRate(character) .. "%"
				.. colors.white .. ")",1,1,1);	
	
	local restXP = DS:GetRestXP(character)
	if restXP and restXP > 0 then
		AltoTooltip:AddLine(format("%s: %s", L["Rest XP"], colors.green..restXP),1,1,1)
	end

	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(colors.gold..CURRENCY..":",1,1,1);
	
	local num = DS:GetNumCurrencies(character) or 0
	for i = 1, num do
		local isHeader, name, count = DS:GetCurrencyInfo(character, i)
		name = name or ""
		
		if isHeader then
			AltoTooltip:AddLine(colors.yellow..name)
		else
			AltoTooltip:AddLine(format("  %s: %s", name, colors.green..count),1,1,1);
		end
	end
	
	if num == 0 then
		AltoTooltip:AddLine(colors.white..NONE,1,1,1);
	end
	
	AltoTooltip:Show();
end
