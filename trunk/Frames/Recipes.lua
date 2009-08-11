local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()

local DS

local WHITE				= "|cFFFFFFFF"
local TEAL				= "|cFF00FF9A"
local YELLOW			= "|cFFFFFF00"
local GREEN				= "|cFF00FF00"
local RECIPE_GREY		= "|cFF808080"
local RECIPE_GREEN	= "|cFF40C040"
local RECIPE_ORANGE	= "|cFFFF8040"

local RecipeColors = { RECIPE_ORANGE, YELLOW, RECIPE_GREEN, RECIPE_GREY }
local RecipeColorNames = { BI["Orange"], BI["Yellow"], BI["Green"], L["Grey"] }

function Altoholic.TradeSkills.Recipes:Init()
	DS = DataStore
end

function Altoholic.TradeSkills.Recipes:BuildView()
	self.view = self.view or {}
	wipe(self.view)
	
	local ts = Altoholic.TradeSkills
	local character = Altoholic.Tabs.Characters:GetCurrent()
	local profession = DS:GetProfession(character, ts.CurrentProfession)
	
	local selectedColor = UIDropDownMenu_GetSelectedValue(AltoholicFrameRecipesInfo_SelectColor)
	local selectedClass = UIDropDownMenu_GetSelectedValue(AltoholicFrameRecipesInfo_SelectSubclass)
	local selectedSlot = UIDropDownMenu_GetSelectedValue(AltoholicFrameRecipesInfo_SelectInvSlot)
	
	local hideCategory		-- hide or show the current header ?
	local hideLine			-- hide or show the current line ?
	
	for index = 1, DS:GetNumCraftLines(profession) do
		local isHeader, color, info = DS:GetCraftLineInfo(profession, index)

		if isHeader then
			hideCategory = false
			if selectedClass ~= ALL_SUBCLASSES and selectedClass ~= info then
				hideCategory = true	-- hide if a specific subclass is selected AND we're not on it
			end

			if not hideCategory then
				table.insert(self.view, { id = index, isCollapsed = false } )
			end
		else		-- data line
			if not hideCategory then
				hideLine = false
				if selectedColor ~= 0 and selectedColor ~= color then
					hideLine = true
				elseif selectedSlot ~= ALL_INVENTORY_SLOTS then
					if info then	-- on a data line, info contains the itemID and is numeric
						local itemID = DS:GetCraftInfo(info)
						local _, _, _, _, _, itemType, _, _, itemEquipLoc = GetItemInfo(itemID)

						if itemType == BI["Armor"] or itemType == BI["Weapon"] then
							if itemEquipLoc and strlen(itemEquipLoc) > 0 then
								if selectedSlot ~= itemEquipLoc then
									hideLine = true
								end
							end
						else	-- not a weapon or armor ? then test if it's a generic "Created item"
							if selectedSlot ~= NONEQUIPSLOT then
								hideLine = true
							end
						end
					else
						if selectedSlot ~= NONEQUIPSLOT then
							hideLine = true
						end
					end
				end
				
				if not hideLine then
					table.insert(self.view, index)
				end
			end
		end
	end

	-- going from last to first, if two headers follow one another, it means that the smallest index is an empty category, so delete it
	for i = (#self.view - 1), 1, -1 do
		if type(self.view[i]) == "table" and type(self.view[i+1]) == "table" then
			table.remove(self.view, i)
		end
	end
	
	-- to avoid testing for exceptions in the previous loop, deal with the only shortcoming here (if the last entry is a table, it's an empty category, delete it)
	if type(self.view[#self.view]) == "table" then
		table.remove(self.view)
	end
end

function Altoholic.TradeSkills.Recipes:Update()
	local ts = Altoholic.TradeSkills
	local self = ts.Recipes
	
	local VisibleLines = 14
	local frame = "AltoholicFrameRecipes"
	local entry = frame.."Entry"
	
	local character = Altoholic.Tabs.Characters:GetCurrent()
	local profession = DS:GetProfession(character, ts.CurrentProfession)
	
	AltoholicFrameRecipesInfo:Show()
	AltoholicTabCharactersStatus:SetText("")

	local curRank, maxRank = DS:GetSkillInfo(character, ts.CurrentProfession)

	AltoholicFrameRecipesInfo_NumRecipes:SetText(
		format("%s" ..TEAL .. " %d/%d", ts.CurrentProfession, curRank or 0, maxRank or 0 )
	)
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawGroup = true
	local i=1
	
	local isHeader
	local isCollapsed
	
	for index, s in pairs(self.view) do
		if type(s) == "table" then
			isHeader = true
			isCollapsed = s.isCollapsed
		else
			isHeader = nil
		end
		
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if isHeader then													-- then keep track of counters
				if isCollapsed == false then
					DrawGroup = true
				else
					DrawGroup = false
				end
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			elseif DrawGroup then
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			end
		else		-- line will be displayed
			if isHeader then
				if isCollapsed == false then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawGroup = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawGroup = false
				end
				_G[entry..i.."Collapse"]:Show()
				_G[entry..i.."Craft"]:Hide()
				
				local _, _, name = DS:GetCraftLineInfo(profession, s.id)
				_G[entry..i.."RecipeLinkNormalText"]:SetText(TEAL .. name)
				_G[entry..i.."RecipeLink"]:SetID(0)
				_G[entry..i.."RecipeLink"]:SetPoint("TOPLEFT", 25, 0)

				for j=1, 8 do
					_G[ entry..i .. "Item" .. j ]:Hide()
				end
				
				_G[ entry..i ]:SetID(index)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
				
			elseif DrawGroup then
				_G[entry..i.."Collapse"]:Hide()

				local _, color, spellID = DS:GetCraftLineInfo(profession, s)
				local itemID, reagents = DS:GetCraftInfo(spellID)
				
				if itemID then
					Altoholic:SetItemButtonTexture(entry..i.."Craft", GetItemIcon(itemID), 18, 18);
					_G[entry..i.."Craft"]:SetID(itemID)
					_G[entry..i.."Craft"]:Show()
				else
					_G[entry..i.."Craft"]:Hide()
				end
				
				if spellID then
					_G[entry..i.."RecipeLinkNormalText"]:SetText(self:GetLink(spellID, ts.CurrentProfession, RecipeColors[color]))
				else
					-- this should NEVER happen, like NEVER-EVER-ER !!
					_G[entry..i.."RecipeLinkNormalText"]:SetText(L["N/A"])
				end
				_G[entry..i.."RecipeLink"]:SetID(s)
				_G[entry..i.."RecipeLink"]:SetPoint("TOPLEFT", 32, 0)

				local j = 1
				
				if reagents then
					-- "2996x2;2318x1;2320x1"
					for reagent in reagents:gmatch("([^;]+)") do
						local itemName = entry..i .. "Item" .. j;
						local reagentID, reagentCount = strsplit("x", reagent)
						reagentID = tonumber(reagentID)
						
						if reagentID then
							reagentCount = tonumber(reagentCount)
							
							_G[itemName]:SetID(reagentID)
							Altoholic:SetItemButtonTexture(itemName, GetItemIcon(reagentID), 18, 18);

							local itemCount = _G[itemName .. "Count"]
							itemCount:SetText(reagentCount);
							itemCount:Show();
						
							_G[ itemName ]:Show()
							j = j + 1
						else
							_G[ itemName ]:Hide()
						end				
					end
				end
				
				while j <= 8 do
					_G[ entry..i .. "Item" .. j ]:Hide()
					j = j + 1
				end
					
				_G[ entry..i ]:SetID(index)
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
	
	if VisibleCount == 0 then
		AltoholicTabCharactersStatus:SetText(format("%s: %s", ts.CurrentProfession, L["No data"]))
	end
	
	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleCount, VisibleLines, 18);
end

-- small wrapper
local function DDM_AddButton(text, value, func)
	local info = UIDropDownMenu_CreateInfo()
	
	info.text = text
	info.value = value
	info.func = func
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 
end

function Altoholic.TradeSkills.Recipes:DropDownColor_Initialize()
	local ts = Altoholic.TradeSkills
	local self = ts.Recipes
	
	if not ts.CurrentProfession then
		DDM_AddButton(L["Any"], 0, self.ChangeColor)
		return
	end
	
	local character = Altoholic.Tabs.Characters:GetCurrent()
	local profession = DS:GetProfession(character, ts.CurrentProfession)
	local orange, yellow, green, grey = DS:GetNumRecipesByColor(profession)
	
	DDM_AddButton(format("%s %s(%s)", L["Any"], GREEN, orange+yellow+green+grey ), 0, self.ChangeColor)
	DDM_AddButton(format("%s %s(%s)", RecipeColors[1] .. RecipeColorNames[1], GREEN, orange ), 1, self.ChangeColor)
	DDM_AddButton(format("%s %s(%s)", RecipeColors[2] .. RecipeColorNames[2], GREEN, yellow ), 2, self.ChangeColor)
	DDM_AddButton(format("%s %s(%s)", RecipeColors[3] .. RecipeColorNames[3], GREEN, green ), 3, self.ChangeColor)
	DDM_AddButton(format("%s %s(%s)", RecipeColors[4] .. RecipeColorNames[4], GREEN, grey ), 4, self.ChangeColor)
end

function Altoholic.TradeSkills.Recipes:ChangeColor()
	UIDropDownMenu_SetSelectedValue(AltoholicFrameRecipesInfo_SelectColor, self.value);
	
	local self = Altoholic.TradeSkills.Recipes
	self:BuildView()
	self:Update()
end

function Altoholic.TradeSkills.Recipes:DropDownSubclass_Initialize()
	local ts = Altoholic.TradeSkills
	local self = ts.Recipes
	
	DDM_AddButton(ALL_SUBCLASSES, ALL_SUBCLASSES, self.ChangeSubClass)
	if not ts.CurrentProfession then return end
	
	local character = Altoholic.Tabs.Characters:GetCurrent()
	local profession = DS:GetProfession(character, ts.CurrentProfession)
		
	for index = 1, DS:GetNumCraftLines(profession) do
		local isHeader, _, name = DS:GetCraftLineInfo(profession, index)
		
		if isHeader then
			DDM_AddButton(name, name, self.ChangeSubClass)
		end
	end
end

function Altoholic.TradeSkills.Recipes:ChangeSubClass()
	UIDropDownMenu_SetSelectedValue(AltoholicFrameRecipesInfo_SelectSubclass, self.value);
	
	local self = Altoholic.TradeSkills.Recipes
	self:BuildView()
	self:Update()
end

function Altoholic.TradeSkills.Recipes:DropDownInvSlot_Initialize()
	local ts = Altoholic.TradeSkills
	local self = ts.Recipes
	
	DDM_AddButton(ALL_INVENTORY_SLOTS, ALL_INVENTORY_SLOTS, self.ChangeInvSlot)
	if not ts.CurrentProfession then return end
	
	local invSlots = {}
	local character = Altoholic.Tabs.Characters:GetCurrent()
	local profession = DS:GetProfession(character, ts.CurrentProfession)
		
	for index = 1, DS:GetNumCraftLines(profession) do
		local isHeader, _, spellID = DS:GetCraftLineInfo(profession, index)
		
		if not isHeader then		-- NON header !!
			local itemID = DS:GetCraftInfo(spellID)
			
			if itemID then
				local _, _, _, _, _, itemType, _, _, itemEquipLoc = GetItemInfo(itemID)
				
				if itemEquipLoc and strlen(itemEquipLoc) > 0 then
					local slot = Altoholic.Equipment:GetInventoryTypeName(itemEquipLoc)
					if slot then
						invSlots[slot] = itemEquipLoc
					end
				end
			end
		end
	end
	
	for k, v in pairs(invSlots) do		-- add all the slots found
		DDM_AddButton(k, v, self.ChangeInvSlot)
	end

	--NONEQUIPSLOT = "Created Items"; -- Items created by enchanting
	DDM_AddButton(NONEQUIPSLOT, NONEQUIPSLOT, self.ChangeInvSlot)
end

function Altoholic.TradeSkills.Recipes:ChangeInvSlot()
	UIDropDownMenu_SetSelectedValue(AltoholicFrameRecipesInfo_SelectInvSlot, self.value);
	
	local self = Altoholic.TradeSkills.Recipes
	self:BuildView()
	self:Update()
end

function Altoholic.TradeSkills.Recipes:GetList()
	local ts = Altoholic.TradeSkills
	
	local character = Altoholic.Tabs.Characters:GetCurrent()
	return DS:GetProfession(character, ts.CurrentProfession)		-- current profession
end

function Altoholic.TradeSkills.Recipes:GetLink(spellID, profession, color)
	local name = GetSpellInfo(spellID)
	color = color or "|cffffd000"
	return format("%s|Henchant:%s|h[%s: %s]|h|r", color, spellID, profession, name)
end

function Altoholic.TradeSkills.Recipes:GetLinkByLine(index)
	local profession = self:GetList()
	local _, _, spellID = DS:GetCraftLineInfo(profession, index)
	
	return self:GetLink(spellID, Altoholic.TradeSkills.CurrentProfession)
end

function Altoholic.TradeSkills.Recipes:ResetDropDownMenus()
	UIDropDownMenu_SetSelectedValue(AltoholicFrameRecipesInfo_SelectColor, 0);
	UIDropDownMenu_SetText(AltoholicFrameRecipesInfo_SelectColor, L["Any"])
	UIDropDownMenu_SetSelectedValue(AltoholicFrameRecipesInfo_SelectSubclass, ALL_SUBCLASSES);
	UIDropDownMenu_SetText(AltoholicFrameRecipesInfo_SelectSubclass, ALL_SUBCLASSES)
	UIDropDownMenu_SetSelectedValue(AltoholicFrameRecipesInfo_SelectInvSlot, ALL_INVENTORY_SLOTS);
	UIDropDownMenu_SetText(AltoholicFrameRecipesInfo_SelectInvSlot, ALL_INVENTORY_SLOTS)
end

function Altoholic.TradeSkills.Recipes:ToggleAll(self)
	-- expand or collapse all sections of the currently displayed alt /tradeskill
	if not self.isCollapsed then
		self.isCollapsed = true
		self:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
	else
		self.isCollapsed = nil
		self:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
	end

	local ts = Altoholic.TradeSkills
	for _, s in pairs(ts.Recipes.view) do
		if type(s) == "table" then		-- it's a header
			s.isCollapsed = (self.isCollapsed) or false
		end
	end
	
	ts.Recipes:Update()
end

function Altoholic.TradeSkills.Recipes:Link_OnClick(self, button)
	if ( button ~= "LeftButton" ) then
		return
	end
	
	if Altoholic:GetCurrentRealm() ~= GetRealmName() then
		Altoholic:Print(L["Cannot link another realm's tradeskill"])
		return
	end

	local character = Altoholic.Tabs.Characters:GetCurrent()
	local profession = DS:GetProfession(character, Altoholic.TradeSkills.CurrentProfession)
	local link = profession.FullLink

	if not link then
		Altoholic:Print(L["Invalid tradeskill link"])
		return
	end
	
	if ( ChatFrameEditBox:IsShown() ) then
		ChatFrameEditBox:Insert(Altoholic:GetCurrentCharacter() .. ": " .. link);
	end
end
