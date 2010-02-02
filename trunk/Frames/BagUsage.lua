local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local INFO_REALM_LINE = 0
local INFO_CHARACTER_LINE = 1
local INFO_TOTAL_LINE = 2

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"
local GOLD		= "|cFFFFD700"
local CYAN		= "|cFF1CFAFE"

local ICON_FACTION_HORDE = "Interface\\Icons\\INV_BannerPVP_01"
local ICON_FACTION_ALLIANCE = "Interface\\Icons\\INV_BannerPVP_02"

addon.BagUsage = {}

local ns = addon.BagUsage		-- ns = namespace

function ns:Update()
	local VisibleLines = 14
	local frame = "AltoholicFrameBagUsage"
	local entry = frame.."Entry"
	
	local DS = DataStore
	local Characters = addon.Characters
	
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
					local last = addon:GetLastAccountSharingInfo(CurrentRealm, CurrentAccount)
					_G[entry..i.."NameNormalText"]:SetText(format("%s (%s".. L["Account"]..": %s%s %s%s|r)", s.realm, WHITE, GREEN, s.account, YELLOW, last or ""))
				end
				_G[entry..i.."Level"]:SetText("")
				_G[entry..i.."FreeBags"]:SetText("")
				_G[entry..i.."FreeBank"]:SetText("")
				_G[entry..i.."BagSlotsNormalText"]:SetText("")
				_G[entry..i.."BankSlotsNormalText"]:SetText("")
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
						icon = addon:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18) .. " "
					else
						icon = addon:TextureToFontstring(ICON_FACTION_HORDE, 18, 18) .. " "
					end
					
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(170)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 10, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(170)
					_G[entry..i.."NameNormalText"]:SetText(icon .. format("%s (%s)", DS:GetColoredCharacterName(character), DS:GetCharacterClass(character)))
					_G[entry..i.."Level"]:SetText(GREEN .. DS:GetCharacterLevel(character))
				
					_G[entry..i.."FreeBags"]:SetText(GREEN .. DS:GetNumFreeBagSlots(character))
					_G[entry..i.."FreeBank"]:SetText(GREEN .. DS:GetNumFreeBankSlots(character))

					_G[entry..i.."BagSlotsNormalText"]:SetJustifyH("LEFT")
					_G[entry..i.."BankSlotsNormalText"]:SetJustifyH("LEFT")
					
					-- Normal bags
					_G[entry..i.."BagSlotsNormalText"]:SetText(format("%s/%s|r/%s|r/%s|r/%s |r(%s|r)",
						DS:GetContainerSize(character, 0),
						WHITE .. DS:GetContainerSize(character, 1),
						WHITE .. DS:GetContainerSize(character, 2),
						WHITE .. DS:GetContainerSize(character, 3),
						WHITE .. DS:GetContainerSize(character, 4),
						CYAN .. DS:GetNumBagSlots(character)))
					
					-- Bank bags
					if DS:GetNumBankSlots(character) < 28 then
						_G[entry..i.."BankSlotsNormalText"]:SetText(L["Bank not visited yet"])
					else
						_G[entry..i.."BankSlotsNormalText"]:SetText(format("%s/%s|r/%s|r/%s|r/%s|r/%s|r/%s|r/%s |r(%s|r)",
							DS:GetContainerSize(character, 100),
							WHITE .. DS:GetContainerSize(character, 5),
							WHITE .. DS:GetContainerSize(character, 6),
							WHITE .. DS:GetContainerSize(character, 7),
							WHITE .. DS:GetContainerSize(character, 8),
							WHITE .. DS:GetContainerSize(character, 9),
							WHITE .. DS:GetContainerSize(character, 10),
							WHITE .. DS:GetContainerSize(character, 11),
							CYAN .. DS:GetNumBankSlots(character)))
					end
				elseif (lineType == INFO_TOTAL_LINE) then
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(200)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(200)
					_G[entry..i.."NameNormalText"]:SetText(L["Totals"])
					_G[entry..i.."Level"]:SetText(s.level)
					_G[entry..i.."FreeBags"]:SetText(WHITE .. s.freeBagSlots)
					_G[entry..i.."FreeBank"]:SetText(WHITE .. s.freeBankSlots)
					_G[entry..i.."BagSlotsNormalText"]:SetText(WHITE .. s.bagSlots .. " |r" .. L["slots"])
					_G[entry..i.."BagSlotsNormalText"]:SetJustifyH("CENTER")
					_G[entry..i.."BankSlotsNormalText"]:SetText(WHITE .. s.bankSlots .. " |r" .. L["slots"])
					_G[entry..i.."BankSlotsNormalText"]:SetJustifyH("CENTER")
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

local function WriteLine(size, free, link, bagtype)
	AltoTooltip:AddLine(	format("%s |r%s (%s|r %s) %s %s",
		GOLD..size, L["slots"], 
		GREEN..free, L["free"],
		link or "",
		(bagtype and strlen(bagtype) > 0) and (YELLOW .. "(" .. bagtype .. ")") or "") ,1,1,1);
end

function ns:OnEnter(self)
	local line = self:GetParent():GetID()
	local s = addon.Characters:Get(line)
	
	if mod(s.linetype, 3) ~= INFO_CHARACTER_LINE then		
		return
	end
	
	local c = addon:GetCharacterTableByLine(line)
	local DS = DataStore
	local character = DS:GetCharacter(addon.Characters:GetInfo(line))
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT");
	AltoTooltip:AddDoubleLine(DS:GetColoredCharacterName(character), DS:GetColoredCharacterFaction(character))
	AltoTooltip:AddLine(format("%s %s |r%s %s", L["Level"], 
		GREEN..DS:GetCharacterLevel(character), DS:GetCharacterRace(character),	DS:GetCharacterClass(character)),1,1,1)
	AltoTooltip:AddLine(" ",1,1,1);

	local id = self:GetID()
	local numSlots
	local numFree = 0
	
	local link, size, free, bagtype
	
	if id == 1 then		-- 1 for player bags, 2 for bank bags
		_, link, size, free, bagtype = DS:GetContainerInfo(character, 0)
		WriteLine(size, free, "[" .. BACKPACK_TOOLTIP .. "]")

		for i = 1, 4 do
			_, link, size, free, bagtype = DS:GetContainerInfo(character, i)
			WriteLine(size, free, link, bagtype)
		end
		numSlots = DS:GetNumBagSlots(character)
		numFree = DS:GetNumFreeBagSlots(character)
	elseif DS:GetNumBankSlots(character) < 28 then
		AltoTooltip:AddLine(L["Bank not visited yet"],1,1,1);
		AltoTooltip:Show();	
		return
	else
		_, link, size, free, bagtype = DS:GetContainerInfo(character, 100)
		WriteLine(size, free, "[" .. L["Bank"] .. "]")
		
		for i = 5, 11 do
			_, link, size, free, bagtype = DS:GetContainerInfo(character, i)
			WriteLine(size, free, link, bagtype)
		end
		numSlots = DS:GetNumBankSlots(character)
		numFree = DS:GetNumFreeBankSlots(character)
	end
	
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(CYAN .. numSlots .. " |r" .. L["slots"] .. " ("  .. GREEN .. numFree .. "|r " ..L["free"] .. ") ",1,1,1);
	AltoTooltip:Show();	
end
