local BF = LibStub("LibBabble-Faction-3.0"):GetLookupTable()
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local TEAL		= "|cFF00FF9A"
local YELLOW	= "|cFFFFFF00"
local ORANGE	= "|cFFFF7F00"

Altoholic.Reputations = {}

Altoholic.Reputations.RefTable = {
	-- Factions reference table, based on http://www.wowwiki.com/Factions
	-- a view with a similar structure (but only with required lines) will be build to make the reputations frame
	
	{ FACTION_ALLIANCE },
	BZ["Darnassus"],
	BF["Exodar"],
	BF["Gnomeregan Exiles"],
	BZ["Ironforge"],
	BF["Stormwind"],
	{ FACTION_HORDE },
	BF["Darkspear Trolls"],
	BZ["Orgrimmar"],
	BZ["Thunder Bluff"],
	BZ["Undercity"],
	BZ["Silvermoon City"],
	{ L["Alliance Forces"] },
	BF["The League of Arathor"],
	BF["Silverwing Sentinels"],
	BF["Stormpike Guard"],
	{ L["Horde Forces"] },
	BF["The Defilers"],
	BF["Warsong Outriders"],
	BF["Frostwolf Clan"],
	{ L["Steamwheedle Cartel"] },
	BZ["Booty Bay"],
	BZ["Everlook"],
	BZ["Gadgetzan"],
	BZ["Ratchet"],
	{ BZ["Outland"] },
	BF["Ashtongue Deathsworn"],
	BF["Cenarion Expedition"],
	BF["The Consortium"],
	BF["Honor Hold"],
	BF["Kurenai"],
	BF["The Mag'har"],
	BF["Netherwing"],
	BF["Ogri'la"],
	BF["Sporeggar"],
	BF["Thrallmar"],
	{ BZ["Shattrath City"] },
	BF["Lower City"],
	BF["Sha'tari Skyguard"],
	BF["Shattered Sun Offensive"],
	BF["The Aldor"],
	BF["The Scryers"],
	BF["The Sha'tar"],

	-- *** Wotlk ***
	-- TO DO: once more data are available, make sure that all translations are in libfactions, categorize properly.
	{ "Wrath of the Lick King" },
	BF["Argent Crusade"],
	BF["Kirin Tor"],
	BF["The Kalu'ak"],
	BF["The Wyrmrest Accord"],
	BF["The Sunreavers"],
	BF["Knights of the Ebon Blade"],
	BF["The Sons of Hodir"],
	{ BF["Alliance Vanguard"] },
	BF["Alliance Vanguard"],
	BF["Explorers' League"],
	BF["The Frostborn"],
	BF["The Silver Covenant"],
	BF["Valiance Expedition"],
	{ BF["Horde Expedition"] },
	BF["Horde Expedition"],
	BF["The Hand of Vengeance"],
	BF["The Taunka"],
	BF["Warsong Offensive"],
	{ BZ["Sholazar Basin"] },
	BF["Frenzyheart Tribe"],
	BF["The Oracles"],

	-- ** end wotlk **

	{ L["Other"] },
	BF["Argent Dawn"],
	BF["Bloodsail Buccaneers"],
	BF["Brood of Nozdormu"],
	BF["Cenarion Circle"],
	BF["Darkmoon Faire"],
	BF["Gelkis Clan Centaur"],
	BF["Hydraxian Waterlords"],
	BF["Keepers of Time"],
	BF["Magram Clan Centaur"],
	BF["Ravenholdt"],
	BF["The Scale of the Sands"],
	BF["Shen'dralar"],
	BF["Syndicate"],
	BF["Thorium Brotherhood"],
	BF["Timbermaw Hold"],
	BF["Tranquillien"],
	BF["Wintersaber Trainers"],
	BF["The Violet Eye"],
	BF["Zandalar Tribe"]
}

function Altoholic.Reputations:BuildView()
	self.view = self.view or {}
	wipe(self.view)
	
	local DS = DataStore
	local usedFactions = {}
		
	-- browse all alts, determine which factions are known by at least one alt
	for characterName, character in pairs(DS:GetCharacters(Altoholic:GetCurrentRealm())) do
		for repName, _ in pairs(DS:GetReputations(character)) do
			usedFactions[repName] = true		-- flag reputation as used by at least one alt
		end
	end

	-- prepare the view
	for index, faction in pairs(self.RefTable) do		-- browse the reference table
		if type(faction) == "table" then		-- table ? it's a header, add it without condition
			table.insert(self.view, {			 	-- save the header table
				name = self.RefTable[index][1],
				isHeader = true,
				isCollapsed = false
			} )
		else	-- it's a faction,
			if usedFactions[faction] then		-- is it used ?
				table.insert(self.view, faction)		-- .. yes, so save the current line (a string)
			end
		end
	end

	-- at this point, the view might contain headers of empty categories, so browse the table backwards and remove them
	for i = (#self.view - 1), 1, -1 do
		if type(self.view[i]) == "table" and type(self.view[i+1]) == "table" then
			-- if two consecutive entries are tables, then the lowest index is an empty category, delete it
			table.remove(self.view, i)
		end
	end
end

function Altoholic.Reputations:Update()
	local self = Altoholic.Reputations
	local VisibleLines = 14
	local frame = "AltoholicFrameReputations"
	local entry = frame.."Entry"
		
	AltoholicTabCharactersStatus:SetText("")
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawFactionGroup
	
	local realm, account = Altoholic:GetCurrentRealm()
	local character
	
	local DS = DataStore
	
	local i=1
	for line, faction in pairs(self.view) do
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if type(faction) == "table" then								-- then keep track of counters
				if faction.isCollapsed == false then
					DrawFactionGroup = true
				else
					DrawFactionGroup = false
				end
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			elseif DrawFactionGroup then
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			end
		else		-- line will be displayed
			if type(faction) == "table" then
				if faction.isCollapsed == false then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawFactionGroup = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawFactionGroup = false
				end
				_G[entry..i.."Collapse"]:Show()

				_G[entry..i.."Name"]:SetText(faction.name)
				_G[entry..i.."Name"]:SetJustifyH("LEFT")
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 25, 0)

				for j=1, 10 do		-- hide the 10 rep buttons
					itemButton = _G[entry.. i .. "Item" .. j];
					itemButton.CharName = nil
					itemButton:Hide()
				end
				
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			elseif DrawFactionGroup then
				_G[entry..i.."Collapse"]:Hide()
				_G[entry..i.."Name"]:SetText(WHITE .. faction)
				_G[entry..i.."Name"]:SetJustifyH("RIGHT")
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
				
				for j = 1, 10 do
					local itemName = entry.. i .. "Item" .. j;
					local itemButton = _G[itemName]
					
					local classButton = _G["AltoholicFrameClassesItem" .. j]
					
					local status, rate
					if classButton.CharName then
						character = DS:GetCharacter(classButton.CharName, realm, account)
						status, _, _, rate = DS:GetReputationInfo(character, faction)
					end
						
					if status and rate then 
						_G[itemName .. "Name"]:SetText(format("%2d", floor(rate)) .. "%")

						if status == FACTION_STANDING_LABEL1 then
							_G[itemName .. "Name"]:SetTextColor(0.8, 0.13, 0.13)
						elseif status == FACTION_STANDING_LABEL2 then
							_G[itemName .. "Name"]:SetTextColor(1.0, 0.0, 0.0)
						elseif status == FACTION_STANDING_LABEL3 then
							_G[itemName .. "Name"]:SetTextColor(0.93, 0.4, 0.13)
						elseif status == FACTION_STANDING_LABEL4 then
							_G[itemName .. "Name"]:SetTextColor(1.0, 1.0, 0.0)
						elseif status == FACTION_STANDING_LABEL5 then
							_G[itemName .. "Name"]:SetTextColor(0.0, 1.0, 0.0)
						elseif status == FACTION_STANDING_LABEL6 then
							_G[itemName .. "Name"]:SetTextColor(0.0, 1.0, 0.53)
						elseif status == FACTION_STANDING_LABEL7 then
							_G[itemName .. "Name"]:SetTextColor(0.0, 1.0, 0.8)
						elseif status == FACTION_STANDING_LABEL8 then
							_G[itemName .. "Name"]:SetTextColor(0.0, 1.0, 1.0)
						end
						
						itemButton.CharName = classButton.CharName
						itemButton:Show()
					else
						itemButton.CharName = nil
						itemButton:Hide()
					end
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

	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleCount, VisibleLines, 41);
end

function Altoholic.Reputations:OnEnter(self)
	local charName = self.CharName
	if not charName then return end
	
	local DS = DataStore
	local realm, account = Altoholic:GetCurrentRealm()
	local character = DS:GetCharacter(charName, realm, account)
	local faction = Altoholic.Reputations:GetName( self:GetParent():GetID() )
	
	local status, currentLevel, maxLevel, rate = DS:GetReputationInfo(character, faction)
	if not status then return end
	
	AltoTooltip:SetOwner(self, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();
	AltoTooltip:AddLine(DS:GetColoredCharacterName(character) .. WHITE .. " @ " ..	TEAL .. faction,1,1,1);

	rate = format("%d", floor(rate)) .. "%"
	AltoTooltip:AddLine(format("%s: %d/%d (%s)", status, currentLevel, maxLevel, rate),1,1,1 )
				
	local bottom = DS:GetRawReputationInfo(character, faction)
	local suggestion = Altoholic:GetSuggestion(faction, bottom)
	if suggestion then
		AltoTooltip:AddLine(" ",1,1,1);
		AltoTooltip:AddLine("Suggestion: ",1,1,1);
		AltoTooltip:AddLine(TEAL .. suggestion,1,1,1);
	end
	
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL1, 0.8, 0.13, 0.13);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL2, 1.0, 0.0, 0.0);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL3, 0.93, 0.4, 0.13);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL4, 1.0, 1.0, 0.0);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL5, 0.0, 1.0, 0.0);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL6, 0.0, 1.0, 0.53);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL7, 0.0, 1.0, 0.8);
	AltoTooltip:AddLine(FACTION_STANDING_LABEL8, 0.0, 1.0, 1.0);
	
	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(GREEN .. L["Shift-Click to link this info"],1,1,1);
	AltoTooltip:Show();
end

function Altoholic.Reputations:GetName(id)
	return self.view[id]
end

function Altoholic.Reputations:OnClick(self, button)
	local charName = self.CharName
	if not charName then return end
	
	local DS = DataStore
	local realm, account = Altoholic:GetCurrentRealm()
	local character = DS:GetCharacter(charName, realm, account)
	local faction = Altoholic.Reputations:GetName( self:GetParent():GetID() )
	local status, currentLevel, maxLevel, rate = DS:GetReputationInfo(character, faction)
	if not status then return end
	
	if ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
		if ( ChatFrameEditBox:IsShown() ) then
			ChatFrameEditBox:Insert(format(L["%s is %s with %s (%d/%d)"], charName, status, faction, currentLevel, maxLevel))
		end
	end	
end
