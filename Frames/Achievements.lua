local BF = LibStub("LibBabble-Faction-3.0"):GetLookupTable()
local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local TEAL		= "|cFF00FF9A"
local YELLOW	= "|cFFFFFF00"
local ORANGE	= "|cFFFF7F00"
local GRAY		= "|cFF909090"

local GENERAL_CATEGORY_ID				= 92
local QUESTS_CATEGORY_ID				= 96
local QUESTS_WOW_CATEGORY_ID			= 14861
local QUESTS_BC_CATEGORY_ID			= 14862
local QUESTS_WOTLK_CATEGORY_ID		= 14863
local PVP_CATEGORY_ID					= 95
local PVPARENA_CATEGORY_ID				= 165
local PVPWINTERGRASP_CATEGORY_ID		= 14901
local PROFESSIONS_CATEGORY_ID			= 169
local COOKING_CATEGORY_ID				= 170
local FISHING_CATEGORY_ID				= 171
local FIRSTAID_CATEGORY_ID				= 172
local REPUTATIONS_CATEGORY_ID			= 201
local LUNARFESTIVAL_CATEGORY_ID		= 160
local FEATS_CATEGORY_ID					= 81

local Categories = {
-- Reference Table for some achievement categories. Since progressive achievements are not listed as part of an alt's known achievements, and since
-- not all alts are at the same level (think of character level for instance), it's necessary to keep track of all achievements in a specific category.
-- Categories that contain no progressive achievements do not need to be here (ex: exploration)

-- Retrieved from http://wotlk.wowhead.com/?achievements
	[GENERAL_CATEGORY_ID] = {										-- updated Apr 22, 2009
		6, 7, 8, 9, 10, 11, 12, 13, 15, 16, 545, 546, 556, 557, 558, 559, 621, 705, 889,
		890, 891, 892, 964, 1017, 1020, 1021, 1165, 1176, 1177, 1178, 1180, 1181, 1187,
		1206, 1244, 1248, 1250, 1254, 1832, 1833, 1956, 2076, 2077, 2078, 2084, 2097,
		2141, 2142, 2143, 2516, 2536, 2537, 2556, 2557, 2716
	},
	[QUESTS_CATEGORY_ID] = {										-- updated Feb 6, 2009
		31, 32, 503, 504, 505, 506, 507, 508, 941, 973, 974, 975,
		976, 977, 978, 1182, 1576, 1681, 1682	
	},
	[PVP_CATEGORY_ID] = {											-- updated Feb 6, 2009
		227, 229, 230, 231, 238, 239, 245, 246, 247, 388, 389, 396, 509, 512, 513, 515, 516, 
		603, 604, 610, 611, 612, 613, 614, 615, 616, 617, 618, 619, 700, 701, 714, 727, 869, 
		870, 907, 908, 909, 1005, 1006, 1157, 1175, 2016, 2017
	},
	[PVPARENA_CATEGORY_ID] = {										-- updated Feb 6, 2009
		397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 699, 875, 876, 
		1159, 1160, 1161, 1162, 1174, 2090, 2091, 2092, 2093
	},
	[PVPWINTERGRASP_CATEGORY_ID] = {								-- updated Oct 25, 2009
		1717, 1718, 1721, 1722, 1723, 1727, 1737, 1751, 1752, 1755, 2080, 
		2085, 2086, 2087, 2088, 2089, 2199, 2476, 2776, 3136, 3137, 3836, 3837,
	},
	[PROFESSIONS_CATEGORY_ID] = {									-- updated Feb 6, 2009
		116, 730, 731, 732, 733, 734, 735	
	},
	[COOKING_CATEGORY_ID] = {										-- updated Apr 22, 2009
		121, 122, 123, 124, 125, 877, 906, 1563, 1777, 1778, 1779, 1780, 1781, 1782, 1783, 
		1784, 1785, 1795, 1796, 1797, 1798, 1799, 1800, 1801, 1998, 1999, 2000, 2001, 2002, 
		3296
	},
	[FISHING_CATEGORY_ID] = {										-- updated Apr 22, 2009
		126, 127, 128, 129, 130, 144, 150, 153, 306, 560, 726, 878, 905, 1225,
		1243, 1257, 1516, 1517, 1556, 1557, 1558, 1559, 1560, 1561, 1836, 1837,
		1957, 1958, 2094, 2095, 2096, 3217, 3218
	},
	[FIRSTAID_CATEGORY_ID] = {										-- updated Feb 6, 2009
		131, 132, 133, 134, 135, 137, 141
	},
	[REPUTATIONS_CATEGORY_ID] = {									-- updated Feb 6, 2009
		1014, 1015, 518, 519, 520, 521, 522, 523, 524, 762, 942, 943, 945, 948, 953
	},
	[LUNARFESTIVAL_CATEGORY_ID] = {								-- updated Feb 6, 2009
		605, 606, 607, 608, 609, 626, 910, 911, 912, 914, 915, 937, 1281, 1396, 1552
	},
	[FEATS_CATEGORY_ID] = {											-- updated Sept 28, 2009
		411, 412, 414, 415, 416, 418, 419, 420, 424, 425, 426, 428, 429, 430, 431, 432,
		433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448,
		449, 450, 451, 452, 453, 454, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465,
		466, 467, 468, 469, 470, 471, 472, 473, 662, 663, 664, 665, 683, 684, 725, 729,
		871, 879, 880, 881, 882, 883, 884, 885, 886, 887, 888, 980, 1205, 1292, 1293,
		1400, 1402, 1404, 1405, 1406, 1407, 1408, 1409, 1410, 1411, 1412, 1413, 1414,
		1415, 1416, 1417, 1418, 1419, 1420, 1421, 1422, 1423, 1424, 1425, 1426, 1427,
		1436, 1463, 1636, 1637, 1705, 1706, 2079, 2081, 2116, 2316, 2336, 2357, 2358,
		2359, 2398, 2456, 2496, 3096, 3117, 3142, 3259, 3336, 3356, 3357, 3436, 3496,
		3536, 3618, 3636, 3756, 3757, 3758, 3896, 4078, 4079, 4156, 4400
	}
}

local PreSortedCategories = {
	-- To improve readability, these categories will be pre-sorted, even partially, in order to list achievements
	-- in a meaningful order (regardless of localization), as a pure alphabetical order is not always relevant, ex: 10, 100, 1000, 25, 250..etc 
	-- these arrays will thus be used as the first lines in the view, and the complement will be sorted alphabetically.
	[GENERAL_CATEGORY_ID] = {
		6, 7, 8, 9, 10, 11, 12, 13, 							-- levels
		1176, 1177, 1178, 1180, 1181, 						-- got my mind on my money
		891, 889, 890, 892,					 					-- riding skill
		2141, 2142, 2143, 2536, 2537, 						-- mounts
		1017, 15, 1248, 1250, 2516,							-- pets
		621, 1020, 1021, 											-- tabards
	},
	[QUESTS_CATEGORY_ID] = {
		503, 504, 505, 506, 507, 508, 32, 978,				-- quests completed
		973, 974, 975,	976, 977,								-- daily quests completed
	},
	[PVP_CATEGORY_ID] = {
		238, 513, 515, 516, 512, 509, 239, 869, 870,		-- honorable kills
	},
	[PVPWINTERGRASP_CATEGORY_ID] = {
		2085, 2086, 2087, 2088, 2089, 						-- Stone keeper shards
	},
	[PROFESSIONS_CATEGORY_ID] = {
		116, 731, 732, 733, 734, 								-- professional journeyman, etc..
	},
	[COOKING_CATEGORY_ID] = { 
		121, 122, 123, 124, 125,								-- journeyman, expert, artisan, master, grand master
		1999, 2000, 2001, 2002,									-- dalaran cooking awards
		1795, 1796, 1797, 1798, 1799,							-- 25, 50, 75, 100, 160 recipes
		1777, 1778, 1779,											-- northrend gourmet, 15-30-45
	},
	[FISHING_CATEGORY_ID] = {
		126, 127, 128, 129, 130, 								-- journeyman, expert, artisan, master, grand master
		1556, 1557, 1558, 1559, 1560, 1561, 				-- 25, 50 .. fishes
		2094, 2095, 1957,	2096,									-- dalaran coins
	},
	[FIRSTAID_CATEGORY_ID] = {
		131, 132, 133, 134, 135, 								-- journeyman, expert, artisan, master, grand master
	},
	[REPUTATIONS_CATEGORY_ID] = {
		522, 523, 524, 521, 520, 519, 518, 1014, 1015,	-- exalted reputations
	},
	[LUNARFESTIVAL_CATEGORY_ID] = {
		605, 606, 607, 608, 609, 								-- coins of ancestry
	},
}

-- do this differently later on, make a better datamining and streamline the differences between factions, split into 3 tables (ally, horde, both)
if UnitFactionGroup("player") == "Alliance" then
	Categories[QUESTS_WOTLK_CATEGORY_ID] = {								-- updated Oct 27, 2009
		36, 38, 39, 40, 547, 561, 938, 961, 962, 1277, 1428, 1596,	-- both factions
		33, 34, 35, 37, 41		-- alliance only
	}
	PreSortedCategories[QUESTS_WOTLK_CATEGORY_ID] = {
		33, 34, 35, 37, 36, 39, 38, 40, 41,			-- zones then loremaster
	}
else
	Categories[QUESTS_WOTLK_CATEGORY_ID] = {								-- updated Oct 27, 2009
		36, 38, 39, 40, 547, 561, 938, 961, 962, 1277, 1428, 1596,	-- both factions
		1356, 1357, 1358, 1359, 1360		-- horde only
	}
	PreSortedCategories[QUESTS_WOTLK_CATEGORY_ID] = {
		1358, 1356, 1359, 1357, 36, 39, 38, 40, 1360,			-- zones then loremaster
	}
end


local function SortByName(a, b)
	local nameA = select(2, GetAchievementInfo(a)) or ""
	local nameB = select(2, GetAchievementInfo(b)) or ""
	return nameA < nameB
end

Altoholic.Achievements = {}

function Altoholic.Achievements:BuildView(categoryID)
	
	self.view = self.view or {}
	wipe(self.view)

	if PreSortedCategories[categoryID] then		--  if the category is pre-sorted
		local hash = {}		-- temporary hash table for quick reference below
		
		-- add the pre-sorted achievements
		for _, id in pairs(PreSortedCategories[categoryID]) do
			table.insert(self.view, id)		-- simply insert the id
			hash[id] = true
		end
	
		-- .. then the remaining ones
		local remaining = {}

		for _, id in pairs(Categories[categoryID]) do
			if not hash[id] then		-- if the achievement is not yet in the view, insert it
				table.insert(remaining, id)
			end
		end
		table.sort(remaining, SortByName)	-- sort remaining achievements by name ..
		
		for _, id in pairs(remaining) do		
			table.insert(self.view, id)		-- .. then add them to the view
		end
		
	else
		if not Categories[categoryID] then
			-- if the category does not contain progressive achievements, then add all achievements to the view
			for i = 1, GetCategoryNumAchievements(categoryID) do
				local id = GetAchievementInfo(categoryID, i)
				table.insert(self.view, id)		-- simply insert the id
			end
		else
			for _, id in pairs(Categories[categoryID]) do
				table.insert(self.view, id)		-- simply insert the id
			end
		end

		-- regardless of the content, sort the achievements view in alphabetical order (based on achievement name, of course)
		table.sort(self.view, SortByName)
	end
end

function Altoholic.Achievements:Update()
	local VisibleLines = 8
	local frame = "AltoholicFrameAchievements"
	local entry = frame.."Entry"
	
	local self = Altoholic.Achievements
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	
	local realm, account = Altoholic:GetCurrentRealm()
	local character
	
	AltoholicTabAchievementsStatus:SetText(format("%s: %s", ACHIEVEMENTS, GREEN..#self.view ))
	
	for i=1, VisibleLines do
		local line = i + offset
		if line <= #self.view then	-- if the line is visible
			local achievementID = self.view[line]
			local _, achName, _, _, _, _, _, _, _, achImage = GetAchievementInfo(achievementID)
			
			_G[entry..i.."Name"]:SetText(WHITE .. achName)
			_G[entry..i.."Name"]:SetJustifyH("LEFT")
			_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
			
			for j = 1, 10 do
				local itemName = entry.. i .. "Item" .. j;
				local itemButton = _G[itemName]
				
				local classButton = _G["AltoholicFrameClassesItem" .. j]
				if classButton.CharName then
					character = DataStore:GetCharacter(classButton.CharName, realm, account)
					
					local itemTexture = _G[itemName .. "_Background"]
					
					itemTexture:SetTexture(achImage)
					
					local isStarted, isComplete = DataStore:GetAchievementInfo(character, achievementID)
					
					if isComplete then
						itemTexture:SetVertexColor(1.0, 1.0, 1.0);
						_G[itemName .. "Name"]:SetText("\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t")
					elseif isStarted then
						itemTexture:SetVertexColor(0.9, 0.6, 0.2);
						_G[itemName .. "Name"]:SetText("\124TInterface\\RaidFrame\\ReadyCheck-Waiting:14\124t")
					else
						itemTexture:SetVertexColor(0.4, 0.4, 0.4);
						_G[itemName .. "Name"]:SetText("\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t")
					end
					
					itemButton.CharName = classButton.CharName
					itemButton.id = line
					itemButton:Show()
				else
					itemButton:Hide()
					itemButton.CharName = nil
					itemButton.id = nil
				end
			end

			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end

	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], #self.view, VisibleLines, 41);
end

local CRITERIA_COMPLETE_ICON = "\124TInterface\\AchievementFrame\\UI-Achievement-Criteria-Check:14\124t"

function Altoholic.Achievements:OnEnter(self)
	if not self.CharName then return end
	
	local DS = DataStore
	local realm, account = Altoholic:GetCurrentRealm()
	local character = DS:GetCharacter(self.CharName, realm, account)
	
	local achievementID = Altoholic.Achievements.view[self.id]
	local _, achName, points, _, _, _, _, description, _, _, rewardText = GetAchievementInfo(achievementID);
	
	AltoTooltip:SetOwner(self, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();
	AltoTooltip:AddDoubleLine(DS:GetColoredCharacterName(character), achName)
	AltoTooltip:AddLine(WHITE .. description, 1, 1, 1, 1, 1);
	AltoTooltip:AddLine(WHITE .. ACHIEVEMENT_TITLE .. ": " .. YELLOW .. points);
	AltoTooltip:AddLine(" ");

	local isStarted, isComplete = DS:GetAchievementInfo(character, achievementID)
	
	if isComplete then
		AltoTooltip:AddLine(format("%s: %s", WHITE .. STATUS, GREEN .. COMPLETE ));
	elseif isStarted then
		local numCompletedCriteria = 0
		local numCriteria = GetAchievementNumCriteria(achievementID)
		
		for criteriaIndex = 1, numCriteria do	-- browse all criterias
			local criteriaString, criteriaType, _, _, reqQuantity = GetAchievementCriteriaInfo(achievementID, criteriaIndex);
			local isCriteriaStarted, isCriteriaComplete, quantity = DS:GetCriteriaInfo(character, achievementID, criteriaIndex)
			
			local icon = ""
			local color = GRAY

			if isCriteriaComplete then
				icon = CRITERIA_COMPLETE_ICON
				numCompletedCriteria = numCompletedCriteria + 1
				color = GREEN
			elseif isCriteriaStarted then
				if tonumber(quantity) > 0 then
					criteriaString = criteriaString .. WHITE
				end
				
				if criteriaType == 67 then		-- this type is an amoung of gold, format it as such, make something more generic later on if necessary
					quantity = Altoholic:GetMoneyString(tonumber(quantity))
					reqQuantity = Altoholic:GetMoneyString(tonumber(reqQuantity))
					criteriaString = format(" - %s (%s/%s)", criteriaString, quantity..WHITE, reqQuantity..WHITE)
				else
					criteriaString = format(" - %s (%s/%s)", criteriaString, quantity, reqQuantity)
				end
			else
				criteriaString = format(" - %s", criteriaString)
			end
			
			AltoTooltip:AddLine(format("%s%s%s", icon, color, criteriaString))
		end
		
		if numCriteria > 1 then
			AltoTooltip:AddLine(" ");
			AltoTooltip:AddLine(format("%s: %s%d/%d", WHITE..STATUS, GREEN, numCompletedCriteria, numCriteria));
		end
	else
		for i = 1, GetAchievementNumCriteria(achievementID) do	-- write all criterias in gray
			AltoTooltip:AddLine(GRAY .. " - " .. GetAchievementCriteriaInfo(achievementID, i));
		end
	end
	
	if strlen(rewardText) > 0 then		-- not nil if empty, so test the length of the string
		AltoTooltip:AddLine(" ");
		AltoTooltip:AddLine(GREEN .. rewardText);
	end

	if isStarted or isComplete then
		AltoTooltip:AddLine(" ");
		AltoTooltip:AddLine(GREEN .. L["Shift+Left click to link"]);
	end
	-- AltoTooltip:AddLine(GREEN .. "id : " .. achievementID);			-- debug
	
	AltoTooltip:Show();
end

function Altoholic.Achievements:OnClick(self, button)
	if not self.CharName then return end
	
	if ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
		if ( ChatFrameEditBox:IsShown() ) then
			local realm, account = Altoholic:GetCurrentRealm()
			local character = DataStore:GetCharacter(self.CharName, realm, account)
			local achievementID = Altoholic.Achievements.view[self.id]

			local link = DataStore:GetAchievementLink(character, achievementID)
			if link then 
				ChatFrameEditBox:Insert(link)
			end		
		end
	end
end
