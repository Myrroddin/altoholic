local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"

local INITIAL_OFFSET_X = 25				-- constants used for positioning talents
local INITIAL_OFFSET_Y = 15
local TALENT_OFFSET_X = 62
local TALENT_OFFSET_Y = 55

Altoholic.Talents = {}
Altoholic.Talents.Buttons = {}
Altoholic.Talents.Arrows = {}
Altoholic.Talents.Branches = {}
Altoholic.Glyphs = {}
Altoholic.Glyphs.Buttons = {}

function Altoholic.Talents:Update(treeIndex)
	Altoholic.Glyphs:Update()
	treeIndex = treeIndex or 1
	AltoholicFrameTalents_ScrollFrameScrollBar:SetMinMaxValues(0, 330);
	
	-- stop all autocast
	for i = 1, 3 do
		AutoCastShine_AutoCastStop(_G[ "AltoholicFrameTalents_SpecIcon" .. i .. "Shine" ]);
	end
	AltoholicFrameTalents:Hide()
	
	local character = Altoholic.Tabs.Characters:GetCurrent()
	if not character then return end

	if character.ActiveTalents == 1 then
		AltoholicFrameTalents_PrimaryText:SetText(format("%s (%s)",WHITE..TALENT_SPEC_PRIMARY..GREEN, TALENT_ACTIVE_SPEC_STATUS ))
		AltoholicFrameTalents_SecondaryText:SetText(WHITE..TALENT_SPEC_SECONDARY)
	else
		AltoholicFrameTalents_PrimaryText:SetText(WHITE..TALENT_SPEC_PRIMARY)
		AltoholicFrameTalents_SecondaryText:SetText(format("%s (%s)",WHITE..TALENT_SPEC_SECONDARY..GREEN, TALENT_ACTIVE_SPEC_STATUS ))
	end
	
	local DS = DataStore
	local _, class = DS:GetCharacterClass(character)
	if not DS:IsClassKnown(class) then return end
	local treeName = DS:GetTreeNameByID(class, treeIndex)
	
	self.Parent = _G["AltoholicFrameTalents_ScrollFrameTalent1"]:GetParent()

	local index = 1
	for tree in DS:GetClassTrees(class) do						-- draw spec icons
		local itemName = "AltoholicFrameTalents_SpecIcon"..index
		local itemButton = _G[itemName]
		local itemCount = _G[itemName .."Count"]
		local icon = DS:GetTreeInfo(class, tree)
		
		Altoholic:SetItemButtonTexture(itemName, icon, 30, 30)
		itemCount:SetText(WHITE .. DS:GetNumPointsSpent(character, tree, self.group))
		itemCount:Show()
		itemButton:Show()
		index = index + 1
	end
	
	local isActiveTalentGroup = self.group == character.ActiveTalents

	-- textures are 90.625% of the original size
	local _, bg = DS:GetTreeInfo(class, treeName)
	AltoholicFrameTalents_bgTopLeft:SetTexture(bg.."-TopLeft")
	AltoholicFrameTalents_bgTopRight:SetTexture(bg.."-TopRight")
	AltoholicFrameTalents_bgBottomLeft:SetTexture(bg.."-BottomLeft")
	AltoholicFrameTalents_bgBottomRight:SetTexture(bg.."-BottomRight")
	
	SetDesaturation(AltoholicFrameTalents_bgTopLeft, not isActiveTalentGroup)
	SetDesaturation(AltoholicFrameTalents_bgTopRight, not isActiveTalentGroup)
	SetDesaturation(AltoholicFrameTalents_bgBottomLeft, not isActiveTalentGroup)
	SetDesaturation(AltoholicFrameTalents_bgBottomRight, not isActiveTalentGroup)

	AutoCastShine_AutoCastStart(_G[ "AltoholicFrameTalents_SpecIcon" .. treeIndex .. "Shine" ]);
	AltoholicFrameTalents_ScrollFrame:SetID(treeIndex)

	self.Buttons:ResetCount()
	self.Arrows:ResetCount()
	self.Branches:ResetCount()
	self.Branches:InitializeArray()
	
	-- draw all icons in their respective slot
	for i = 1, DS:GetNumTalents(class, treeName) do
		local _, _, texture, tier, column = DS:GetTalentInfo(class, treeName, i)
		local rank = DS:GetTalentRank(character, treeName, self.group, i)
		
		self.Buttons:Draw(texture, tier, column, rank, i)
		self.Branches.Array[tier][column].node = true;
				
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
			
			self.Arrows:Draw(tier, column, prereqTier, prereqColumn, blocked)
			self.Branches:Init(tier, column, prereqTier, prereqColumn, blocked)
		end
	end
	self.Branches:Draw()
	
	self.Buttons:HideUnused()
	self.Arrows:HideUnused()
	self.Branches:HideUnused()
	self.Branches:ClearArray()
	AltoholicFrameTalents:Show()
end

function Altoholic.Talents.Buttons:ResetCount()
	self.count = 1
end

function Altoholic.Talents.Buttons:Draw(texture, tier, column, count, id)
	local itemName = "AltoholicFrameTalents_ScrollFrameTalent" .. self.count
	local itemButton = _G[itemName]

	itemButton:SetPoint("TOPLEFT", itemButton:GetParent(), "TOPLEFT", 
		INITIAL_OFFSET_X + ((column-1) * TALENT_OFFSET_X), 
		-(INITIAL_OFFSET_Y + ((tier-1) * TALENT_OFFSET_Y)))
	itemButton:SetID(id)

	if texture then
		Altoholic:SetItemButtonTexture(itemName, texture, 37, 37)
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

	self.count = self.count + 1
end

function Altoholic.Talents.Buttons:HideUnused()
	while self.count <= 40 do
		_G["AltoholicFrameTalents_ScrollFrameTalent" .. self.count]:Hide()
		_G["AltoholicFrameTalents_ScrollFrameTalent" .. self.count]:SetID(0)	
		self.count = self.count + 1
	end
	self.count = nil
end

function Altoholic.Talents.Arrows:ResetCount()
	self.count = 1
end

function Altoholic.Talents.Arrows:Draw(tier, column, prereqTier, prereqColumn, blocked)
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
	
	local arrow = _G["AltoholicFrameTalents_Arrow" .. self.count]
	local tc = TALENT_ARROW_TEXTURECOORDS[arrowType][1]
	
	arrow:SetTexCoord(tc[1], tc[2], tc[3], tc[4]);
	arrow:SetPoint("TOPLEFT",	Altoholic.Talents.Parent, "TOPLEFT", x, y)
	arrow:Show()
	
	self.count = self.count + 1
end

function Altoholic.Talents.Arrows:HideUnused()
	while self.count <= 30 do
		_G["AltoholicFrameTalents_Arrow" .. self.count]:Hide()
		self.count = self.count + 1
	end
	self.count = nil
end

function Altoholic.Talents.Branches:ResetCount()
	self.count = 1
end

function Altoholic.Talents.Branches:InitializeArray()
	self.Array = self.Array or {};		-- branch array
	wipe(self.Array)
	
	for i = 1, MAX_NUM_TALENT_TIERS do
		self.Array[i] = {};
		for j = 1, NUM_TALENT_COLUMNS do
			self.Array[i][j] = {};
		end
	end
end

function Altoholic.Talents.Branches:ClearArray()
	wipe(self.Array)
	self.Array = nil
end

function Altoholic.Talents.Branches:Init(tier, column, prereqTier, prereqColumn, blocked)

	-- algorithm taken from TalentFrameBase.lua, adjusted for my needs
	local left = min(column, prereqColumn);
	local right = max(column, prereqColumn);
	
	if (column == prereqColumn) then			-- Same column ? ==> TOP
		for i = prereqTier, tier - 1 do
			self.Array[i][column].down = true;
			if ( (i + 1) <= (tier - 1) ) then
				self.Array[i+1][column].up = true;
			end
		end
		return
	end
		
	if (tier == prereqTier) then			-- Same tier ? ==> LEFT or RIGHT
		for i = left, right-1 do
			self.Array[prereqTier][i].right = true;
			self.Array[prereqTier][i+1].left = true;
		end
		return
	end

	-- None of these ? ==> diagonal
	if not blocked then
		self.Array[prereqTier][column].down = true;
		self.Array[tier][column].up = true;
		
		for i = prereqTier, tier - 1 do
			self.Array[i][column].down = true;
			self.Array[i + 1][column].up = true;
		end

		for i = left, right - 1 do
			self.Array[prereqTier][i].right = true;
			self.Array[prereqTier][i+1].left = true;
		end
	else
		for i=prereqTier, tier-1 do
			self.Array[i][column].up = true;
			self.Array[i + 1][column].down = true;
		end
	end
end

function Altoholic.Talents.Branches:Draw()
	local x, y
	local ignoreUp
	
	for i = 1, MAX_NUM_TALENT_TIERS do
		for j = 1, NUM_TALENT_COLUMNS do
			local p = self.Array[i][j]
			
			x = INITIAL_OFFSET_X + ((j-1) * TALENT_OFFSET_X) + 2
			y = -(INITIAL_OFFSET_Y + ((i-1) * TALENT_OFFSET_Y)) - 2
			
			if p.node then			-- there's a talent there
				if p.up then
					if not ignoreUp then
						self:SetTexture("up", x, y + TALENT_BUTTON_SIZE)
					else
						ignoreUp = nil
					end
				end
				if p.down then
					self:SetTexture("down", x, y - TALENT_BUTTON_SIZE + 1)
				end
				if p.left then
					self:SetTexture("left", x - TALENT_BUTTON_SIZE, y)
				end
				if p.right then
					self:SetTexture("right", x + TALENT_BUTTON_SIZE, y)
				end			
			else
				if p.up and p.left and p.right then
					self:SetTexture("tup", x, y)
				elseif p.down and p.left and p.right then
					self:SetTexture("tdown", x, y)
				elseif p.left and p.down then
					self:SetTexture("topright", x, y)
					self:SetTexture("down", x, y-32)
				elseif p.left and p.up then
					self:SetTexture("bottomright", x, y)
				elseif p.left and p.right then
					self:SetTexture("right", x + TALENT_BUTTON_SIZE, y)
					self:SetTexture("left", x+1, y)
				elseif p.right and p.down then
					self:SetTexture("topleft", x, y)
					self:SetTexture("down", x, y-32)
				elseif p.right and p.up then
					self:SetTexture("bottomleft", x, y)
				elseif p.up and p.down then
					self:SetTexture("up", x, y)
					self:SetTexture("down", x, y-32)
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

function Altoholic.Talents.Branches:SetTexture(branchType, x, y)
	local branch = _G["AltoholicFrameTalents_Branch" .. self.count]
	local tc = TALENT_BRANCH_TEXTURECOORDS[branchType][1]
	
	branch:SetTexCoord(tc[1], tc[2], tc[3], tc[4]);
	branch:SetPoint("TOPLEFT",	Altoholic.Talents.Parent, "TOPLEFT", x, y)
	branch:Show()
	
	self.count = self.count + 1
end

function Altoholic.Talents.Branches:HideUnused()
	while self.count <= 30 do
		_G["AltoholicFrameTalents_Branch" .. self.count]:Hide()
		self.count = self.count + 1
	end
	self.count = nil
end

function Altoholic.Talents:Icon_OnEnter(self)
	local DS = DataStore
	local character = Altoholic.Tabs.Characters:GetCurrent()
	local _, class = DS:GetCharacterClass(character)
	local treeName = DS:GetTreeNameByID(class, self:GetID())
	
	if treeName then
		AltoTooltip:ClearLines();
		AltoTooltip:SetOwner(self, "ANCHOR_RIGHT");
		AltoTooltip:AddLine(treeName,1,1,1);
		AltoTooltip:Show();
	end
end

function Altoholic.Talents:GetLink(self)
	local DS = DataStore
	local treeIndex = self:GetParent():GetParent():GetID()
	local character = Altoholic.Tabs.Characters:GetCurrent()
	local _, class = DS:GetCharacterClass(character)
	local treeName = DS:GetTreeNameByID(class, treeIndex)
	
	local spellNumber = self:GetID()
	local id, name = DS:GetTalentInfo(class, treeName, spellNumber)
	local rank = DS:GetTalentRank(character, treeName, Altoholic.Talents.group, spellNumber)
	
	return DS:GetTalentLink(id, rank, name)
end

function Altoholic.Talents:SetCurrentGroup(group)
	self.group = group
end

function Altoholic.Talents:OnUpdate()
	if AltoholicFrameTalents:IsVisible() then
		Altoholic.Talents:Update()
	end
end	

-- copied from Blizzard_GlyphUI.lua, no idea why they're not visible from here .. :/
Altoholic.Glyphs.Buttons.SlotsTC = {

	-- Empty Texture
	[0] = { left = 0.78125, right = 0.91015625, top = 0.69921875, bottom = 0.828125 },
	[1] = { left = 0, right = 0.12890625, top = 0.87109375, bottom = 1 },
	[2] = { left = 0.130859375, right = 0.259765625, top = 0.87109375, bottom = 1 },
	[3] = { left = 0.392578125, right = 0.521484375, top = 0.87109375, bottom = 1 },
	[4] = { left = 0.5234375, right = 0.65234375, top = 0.87109375, bottom = 1 },
	[5] = { left = 0.26171875, right = 0.390625, top = 0.87109375, bottom = 1 },
	[6] = { left = 0.654296875, right = 0.783203125, top = 0.87109375, bottom = 1 }
}

function Altoholic.Glyphs:Update()
	-- GLYPHTYPE_MAJOR = 1;
	-- GLYPHTYPE_MINOR = 2;

	--		1
	--	3		5
	--	6		4
	--		2

	for i = 1, 6 do
		self.Buttons:Draw(i)
	end
end

function Altoholic.Glyphs.Buttons:Draw(id)
	local name = "AltoholicFrameTalentsGlyph" .. id
	local glyph = _G[name]
	
	local DS = DataStore
	local character = Altoholic.Tabs.Characters:GetCurrent()
	local enabled, glyphType, spell, icon = DS:GetGlyphInfo(character, Altoholic.Talents.group, id)
	
	if glyphType == 1 then
		glyph.glyph:SetVertexColor(1, 0.25, 0);
	else
		glyph.glyph:SetVertexColor(0, 0.25, 1);
	end
	
	if enabled == 0 then
		glyph.shine:Hide();
		glyph.background:Hide();
		glyph.glyph:Hide();
		glyph.ring:Hide();
		glyph.setting:SetTexture("Interface\\Spellbook\\UI-GlyphFrame-Locked");
		glyph.setting:SetTexCoord(.1, .9, .1, .9);
	elseif not spell then
		local tc = self.SlotsTC[0]
		
		glyph.shine:Show();
		glyph.background:Show();
		glyph.background:SetTexCoord(tc.left, tc.right, tc.top, tc.bottom);
		glyph.glyph:Hide();
		glyph.ring:Show();
		glyph.setting:SetTexture("Interface\\Spellbook\\UI-GlyphFrame");
		glyph.setting:SetTexCoord(0.740234375, 0.953125, 0.484375, 0.697265625);
	else
		local tc = self.SlotsTC[id]
		
		glyph.shine:Show();
		glyph.background:Show();
		glyph.background:SetAlpha(1);
		glyph.background:SetTexCoord(tc.left, tc.right, tc.top, tc.bottom);
		glyph.glyph:Show();
		glyph.glyph:SetTexture(icon);
		glyph.ring:Show();
		glyph.setting:SetTexture("Interface\\Spellbook\\UI-GlyphFrame");
		glyph.setting:SetTexCoord(0.740234375, 0.953125, 0.484375, 0.697265625);
	end
end

function Altoholic.Glyphs.Buttons:OnLoad(id)
	local name = "AltoholicFrameTalentsGlyph" .. id
	local glyph = _G[name]
	
	glyph.glyph = _G[name .. "Glyph"]
	glyph.setting = _G[name .. "Setting"]
	glyph.highlight = _G[name .. "Highlight"]
	glyph.background = _G[name .. "Background"]
	glyph.ring = _G[name .. "Ring"]
	glyph.shine = _G[name .. "Shine"]
	
	local ratio
	
	if (id == 1) or (id == 4) or (id == 6) then		-- major
		ratio = 0.85
	else
		ratio = 0.70
	end

	glyph.glyph:SetWidth(63 * ratio);
	glyph.glyph:SetHeight(63 * ratio);
	
	glyph.setting:SetWidth(108 * ratio);
	glyph.setting:SetHeight(108 * ratio);
	glyph.setting:SetTexture("Interface\\Spellbook\\UI-GlyphFrame");
	glyph.setting:SetTexCoord(0.740234375, 0.953125, 0.484375, 0.697265625);
	glyph.highlight:SetWidth(108 * ratio);
	glyph.highlight:SetHeight(108 * ratio);
	glyph.highlight:SetTexCoord(0.740234375, 0.953125, 0.484375, 0.697265625);
	glyph.ring:SetWidth(82 * ratio);
	glyph.ring:SetHeight(82 * ratio);
	glyph.ring:SetPoint("CENTER", glyph, "CENTER", 0, -1);
	glyph.ring:SetTexCoord(0.767578125, 0.92578125, 0.32421875, 0.482421875);
	glyph.shine:SetTexCoord(0.9609375, 1, 0.9609375, 1);
	glyph.background:SetWidth(70 * ratio);
	glyph.background:SetHeight(70 * ratio);
end

function Altoholic.Glyphs.Buttons:OnEnter(self)
	local id = self:GetID()
	local DS = DataStore
	local character = Altoholic.Tabs.Characters:GetCurrent()
	local enabled, glyphType, spell, _, glyphID = DS:GetGlyphInfo(character, Altoholic.Talents.group, id)
	
	local glyphTypeText
	if tonumber(glyphType) == 1 then
		glyphTypeText = "|cFF69CCF0" .. MAJOR_GLYPH
	else
		glyphTypeText = "|cFF69CCF0" .. MINOR_GLYPH
	end	
	
	AltoTooltip:SetOwner(self, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();
	if enabled == 0 then
		AltoTooltip:AddLine("|cFFFF0000" .. GLYPH_LOCKED);
		AltoTooltip:AddLine(glyphTypeText);
		AltoTooltip:AddLine(_G["GLYPH_SLOT_TOOLTIP"..id]);

		AltoTooltip:Show();
		return
	elseif not spell then

		AltoTooltip:AddLine("|cFF808080" .. GLYPH_EMPTY);
		AltoTooltip:AddLine(glyphTypeText);
		AltoTooltip:AddLine(GLYPH_EMPTY_DESC);
		AltoTooltip:Show();
		return 
	end

	local link = DS:GetGlyphLink(id, spell, glyphID)
	AltoTooltip:SetHyperlink(link);
	AltoTooltip:Show();
end

function Altoholic.Glyphs.Buttons:OnClick(self, button)
	local id = self:GetID()
	local DS = DataStore
	local character = Altoholic.Tabs.Characters:GetCurrent()
	local enabled, glyphType, spell, _, glyphID = DS:GetGlyphInfo(character, Altoholic.Talents.group, id)

	if not spell then return end
	
	if ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
		if ( ChatFrameEditBox:IsShown() ) then
			local link = DS:GetGlyphLink(id, spell, glyphID)
			
			ChatFrameEditBox:Insert(link);
		end
	end
end
