local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"

addon.Talents = {}

local ns = addon.Talents		-- ns = talents namespace

local parent = "AltoholicFrameTalents"
local currentTalentGroup
local currentTreeID

-- ** Arrows **
local INITIAL_OFFSET_X = 25				-- constants used for positioning talents
local INITIAL_OFFSET_Y = 15
local TALENT_OFFSET_X = 62
local TALENT_OFFSET_Y = 55
local TALENT_BUTTON_SIZE = TALENT_BUTTON_SIZE or 32	-- check this value on live realms
local NUM_TALENT_BUTTONS = 28

local numArrows

local function ResetArrowCount()
	numArrows = 1
end

local function HideUnusedArrows()
	while numArrows <= 30 do
		_G[parent .. "_Arrow" .. numArrows]:Hide()
		numArrows = numArrows + 1
	end
	numArrows = nil
end

local function DrawArrow(tier, column, prereqTier, prereqColumn, blocked)
	local arrowType					-- algorithm taken from TalentFrameBase.lua, adjusted for my needs
	
	if (column == prereqColumn) then			-- Same column ? ==> TOP
		arrowType = "top"
	elseif (tier == prereqTier) then			-- Same tier ? ==> LEFT or RIGHT
		if (column < prereqColumn) then
			arrowType = "right"
		else
			arrowType = "left"
		end
	else												-- None of these ? ==> diagonal
		if not blocked then
			arrowType = "top"
		else
			if (column < prereqColumn) then
				arrowType = "right"
			else
				arrowType = "left"
			end
		end
	end
	
	if not arrowType then
		return
	end
	
	local x, y
	if arrowType == "top" then
		x = 2
		y = 18
	elseif arrowType == "left" then
		x = -17
		y = -2
	elseif arrowType == "right" then
		x = 22
		y = -2
	end
	
	x = x + INITIAL_OFFSET_X + ((column-1) * TALENT_OFFSET_X)
	y = y - (INITIAL_OFFSET_Y + ((tier-1) * TALENT_OFFSET_Y))
	
	local arrow = _G[parent .. "_Arrow" .. numArrows]
	local tc = TALENT_ARROW_TEXTURECOORDS[arrowType][1]
	
	arrow:SetTexCoord(tc[1], tc[2], tc[3], tc[4]);
	arrow:SetPoint("TOPLEFT",	ns.Parent, "TOPLEFT", x, y)
	arrow:Show()
	
	numArrows = numArrows + 1
end

-- ** Buttons **
local numButtons

local function ResetButtonCount()
	numButtons = 1
end

local function HideUnusedButtons()
	local button
	while numButtons <= NUM_TALENT_BUTTONS do
		button = _G[parent .. "_ScrollFrameTalent" .. numButtons]
		button:Hide()
		button:SetID(0)	
		
		numButtons = numButtons + 1
	end
	numButtons = nil
end

local function DrawTalent(texture, tier, column, count, id)
	local itemName = parent .. "_ScrollFrameTalent" .. numButtons
	local itemButton = _G[itemName]

	itemButton:SetPoint("TOPLEFT", itemButton:GetParent(), "TOPLEFT", 
		INITIAL_OFFSET_X + ((column-1) * TALENT_OFFSET_X), 
		-(INITIAL_OFFSET_Y + ((tier-1) * TALENT_OFFSET_Y)))
	itemButton:SetID(id)

	if texture then
		addon:SetItemButtonTexture(itemName, texture, 37, 37)
	end
	
	local itemCount = _G[itemName .. "Count"]
	local itemTexture = _G[itemName .. "IconTexture"]
	
	if count and count > 0 then
		itemCount:SetText(GREEN .. count)
		itemCount:Show()
		itemTexture:SetDesaturated(0)
	else
		itemTexture:SetDesaturated(1)
		itemCount:Hide()
	end
	itemButton:Show()

	numButtons = numButtons + 1
end

-- ** Branches **
local numBranches
local branchArray		-- a 2-dimensional array to hold branches

local function ResetBranchCount()
	numBranches = 1
end

local function InitializeBranchArray()
	branchArray = branchArray or {}
	wipe(branchArray)
	
	for i = 1, MAX_NUM_TALENT_TIERS do
		branchArray[i] = {};
		for j = 1, NUM_TALENT_COLUMNS do
			branchArray[i][j] = {};
		end
	end
end

local function ClearBranchArray()
	wipe(branchArray)
	branchArray = nil
end

local function InitBranch(tier, column, prereqTier, prereqColumn, blocked)

	-- algorithm taken from TalentFrameBase.lua, adjusted for my needs
	local left = min(column, prereqColumn);
	local right = max(column, prereqColumn);
	
	if (column == prereqColumn) then			-- Same column ? ==> TOP
		for i = prereqTier, tier - 1 do
			branchArray[i][column].down = true;
			if ( (i + 1) <= (tier - 1) ) then
				branchArray[i+1][column].up = true;
			end
		end
		return
	end
		
	if (tier == prereqTier) then			-- Same tier ? ==> LEFT or RIGHT
		for i = left, right-1 do
			branchArray[prereqTier][i].right = true;
			branchArray[prereqTier][i+1].left = true;
		end
		return
	end

	-- None of these ? ==> diagonal
	if not blocked then
		branchArray[prereqTier][column].down = true;
		branchArray[tier][column].up = true;
		
		for i = prereqTier, tier - 1 do
			branchArray[i][column].down = true;
			branchArray[i + 1][column].up = true;
		end

		for i = left, right - 1 do
			branchArray[prereqTier][i].right = true;
			branchArray[prereqTier][i+1].left = true;
		end
	else
		for i=prereqTier, tier-1 do
			branchArray[i][column].up = true;
			branchArray[i + 1][column].down = true;
		end
	end
end

local function SetBranchTexture(branchType, x, y)
	local branch = _G[parent .. "_Branch" .. numBranches]
	local tc = TALENT_BRANCH_TEXTURECOORDS[branchType][1]
	
	branch:SetTexCoord(tc[1], tc[2], tc[3], tc[4]);
	branch:SetPoint("TOPLEFT",	ns.Parent, "TOPLEFT", x, y)
	branch:Show()
	
	numBranches = numBranches + 1
end

local function DrawBranches()
	local x, y
	local ignoreUp
	
	for i = 1, MAX_NUM_TALENT_TIERS do
		for j = 1, NUM_TALENT_COLUMNS do
			local p = branchArray[i][j]
			
			x = INITIAL_OFFSET_X + ((j-1) * TALENT_OFFSET_X) + 2
			y = -(INITIAL_OFFSET_Y + ((i-1) * TALENT_OFFSET_Y)) - 2
			
			if p.node then			-- there's a talent there
				if p.up then
					if not ignoreUp then
						SetBranchTexture("up", x, y + TALENT_BUTTON_SIZE)
					else
						ignoreUp = nil
					end
				end
				if p.down then
					SetBranchTexture("down", x, y - TALENT_BUTTON_SIZE + 1)
				end
				if p.left then
					SetBranchTexture("left", x - TALENT_BUTTON_SIZE, y)
				end
				if p.right then
					SetBranchTexture("right", x + TALENT_BUTTON_SIZE, y)
				end			
			else
				if p.up and p.left and p.right then
					SetBranchTexture("tup", x, y)
				elseif p.down and p.left and p.right then
					SetBranchTexture("tdown", x, y)
				elseif p.left and p.down then
					SetBranchTexture("topright", x, y)
					SetBranchTexture("down", x, y-32)
				elseif p.left and p.up then
					SetBranchTexture("bottomright", x, y)
				elseif p.left and p.right then
					SetBranchTexture("right", x + TALENT_BUTTON_SIZE, y)
					SetBranchTexture("left", x+1, y)
				elseif p.right and p.down then
					SetBranchTexture("topleft", x, y)
					SetBranchTexture("down", x, y-32)
				elseif p.right and p.up then
					SetBranchTexture("bottomleft", x, y)
				elseif p.up and p.down then
					SetBranchTexture("up", x, y)
					SetBranchTexture("down", x, y-32)
					ignoreUp = true
				end
			end

			p.up = nil			-- clear after use
			p.left = nil
			p.right = nil
			p.down = nil
			p.node = nil
		end
	end
end

local function HideUnusedBranches()
	while numBranches <= 30 do
		_G[parent .. "_Branch" .. numBranches]:Hide()
		numBranches = numBranches + 1
	end
	numBranches = nil
end


-- *** TALENTS ***

function ns:Update()
	local treeIndex = currentTreeID or 1

	_G[ parent .. "_ScrollFrameScrollBar"]:SetMinMaxValues(0, 130);
	_G[ parent ]:Hide()
	
	local character = addon.Tabs.Characters:GetCurrent()
	if not character then return end

	local DS = DataStore
	-- if DS:GetActiveTalents(character) == 1 then
		-- AltoholicFrameTalents_PrimaryText:SetText(format("%s (%s)",WHITE..TALENT_SPEC_PRIMARY..GREEN, TALENT_ACTIVE_SPEC_STATUS ))
		-- AltoholicFrameTalents_SecondaryText:SetText(WHITE..TALENT_SPEC_SECONDARY)
		
	-- else
		-- AltoholicFrameTalents_PrimaryText:SetText(WHITE..TALENT_SPEC_PRIMARY)
		-- AltoholicFrameTalents_SecondaryText:SetText(format("%s (%s)",WHITE..TALENT_SPEC_SECONDARY..GREEN, TALENT_ACTIVE_SPEC_STATUS ))
	-- end
		
	
	local _, class = DS:GetCharacterClass(character)
	if not DS:IsClassKnown(class) then return end
	
	local level = DS:GetCharacterLevel(character)
	if not level or level < 10 then return end
	
	local treeName = DS:GetTreeNameByID(class, treeIndex)
	
	ns.Parent = _G[ parent .. "_ScrollFrameTalent1"]:GetParent()
	
	local isActiveTalentGroup = currentTalentGroup == DS:GetActiveTalents(character)

	local status = DataStore:GetColoredCharacterName(character)
	if currentTalentGroup == 1 then
		if isActiveTalentGroup then
			status = format("%s|r / %s", status, TALENT_SPEC_PRIMARY_ACTIVE)
		else
			status = format("%s|r / %s", status, TALENT_SPEC_PRIMARY)
		end
	else
		if isActiveTalentGroup then
			status = format("%s|r / %s", status, TALENT_SPEC_SECONDARY_ACTIVE)
		else
			status = format("%s|r / %s", status, TALENT_SPEC_SECONDARY)
		end
	end
	status = format("%s / %s", status, treeName)
	AltoholicTabCharactersStatus:SetText(status)
	
	-- textures are 90.625% of the original size
	local _, bg = DS:GetTreeInfo(class, treeName)
	
	_G[parent .. "_bgTopLeft"]:SetTexture(bg.."-TopLeft")
	_G[parent .. "_bgTopRight"]:SetTexture(bg.."-TopRight")
	_G[parent .. "_bgBottomLeft"]:SetTexture(bg.."-BottomLeft")
	_G[parent .. "_bgBottomRight"]:SetTexture(bg.."-BottomRight")
	
	SetDesaturation(_G[parent .. "_bgTopLeft"], not isActiveTalentGroup)
	SetDesaturation(_G[parent .. "_bgTopRight"], not isActiveTalentGroup)
	SetDesaturation(_G[parent .. "_bgBottomLeft"], not isActiveTalentGroup)
	SetDesaturation(_G[parent .. "_bgBottomRight"], not isActiveTalentGroup)

	_G[parent .. "_ScrollFrame"]:SetID(treeIndex)

	ResetButtonCount()
	ResetArrowCount()
	ResetBranchCount()
	InitializeBranchArray()
	
	-- draw all icons in their respective slot
	for i = 1, DS:GetNumTalents(class, treeName) do
		local _, _, texture, tier, column = DS:GetTalentInfo(class, treeName, i)
		local rank = DS:GetTalentRank(character, treeName, currentTalentGroup, i)
		
		DrawTalent(texture, tier, column, rank, i)
		branchArray[tier][column].node = true;
				
		-- Draw arrows & branches where applicable
		local prereqTier, prereqColumn = DS:GetTalentPrereqs(class, treeName, i)
		if prereqTier and prereqColumn then
			local left = min(column, prereqColumn);
			local right = max(column, prereqColumn);

			if ( left == prereqColumn ) then		-- Don't check the location of the current button
				left = left + 1;
			else
				right = right - 1;
			end
			
			local blocked								-- Check for blocking talents
			for j = 1, DS:GetNumTalents(class, treeName) do
				local _, _, _, searchedTier, searchedColumn = DS:GetTalentInfo(class, treeName, j)
			
				if searchedTier == prereqTier then				-- do nothing if lower tier, process if same tier, exit if higher tier
					if (searchedColumn >= left) and (searchedColumn <= right) then
						blocked = true
						break
					end
				elseif searchedTier > prereqTier then
					break
				end
			end
			
			DrawArrow(tier, column, prereqTier, prereqColumn, blocked)
			InitBranch(tier, column, prereqTier, prereqColumn, blocked)
		end
	end
	DrawBranches()
	
	HideUnusedButtons()
	HideUnusedArrows()
	HideUnusedBranches()
	ClearBranchArray()
	_G[ parent ]:Show()
end

local function GetTalentLink(frame)
	local DS = DataStore
	local treeIndex = frame:GetParent():GetParent():GetID()
	local character = addon.Tabs.Characters:GetCurrent()
	local _, class = DS:GetCharacterClass(character)
	local treeName = DS:GetTreeNameByID(class, treeIndex)
	
	local spellNumber = frame:GetID()
	local id, name = DS:GetTalentInfo(class, treeName, spellNumber)
	local rank = DS:GetTalentRank(character, treeName, currentTalentGroup, spellNumber)
	
	return DS:GetTalentLink(id, rank, name)
end

function ns:Button_OnEnter(frame)
	local link = GetTalentLink(frame)
	if not link then return	end

	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(frame, "ANCHOR_RIGHT");
	AltoTooltip:SetHyperlink(link);
	AltoTooltip:Show();
end

function ns:Button_OnClick(frame, button)
	if ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
		local chat = ChatEdit_GetLastActiveWindow()
		if chat:IsShown() then
			local link = GetTalentLink(frame)
			if link then
				chat:Insert(link)
			end
		end
	end
end

function ns:SetCurrentGroup(group)
	currentTalentGroup = group
end

function ns:SetCurrentTreeID(id)
	currentTreeID = id
end

local function OnPlayerTalentUpdate()
	if _G[ parent ]:IsVisible() then
		ns:Update()
	end
end	

addon:RegisterEvent("PLAYER_TALENT_UPDATE", OnPlayerTalentUpdate)
