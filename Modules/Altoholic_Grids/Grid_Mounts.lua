local addonName = "Altoholic"
local addon = _G[addonName]

local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()

local WHITE		= "|cFFFFFFFF"

local ICON_NOTREADY = "\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t"
local ICON_READY = "\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t"

local petList
local currentSpellID
local currentPetTexture

-- local mountList = {
	-- {
		-- name = L["Classes"],
		-- name = "Classes",
		-- {
			-- {
			-- }
			-- name = BI["Death Knight"],
			-- { 48778, 54729
			-- },
			-- name = BI["Warlock"],
			-- {
			-- },
			-- name = BI["Paladin"],
			-- {
			-- },
		-- },
	-- },
	-- {
		-- name = ,
		-- {
			-- name = ,
			-- {
			-- },
		-- },
	-- },
	-- {
		-- name = ,
		-- {
			-- name = ,
			-- {
			-- },
		-- },
	-- },
	-- {
		-- name = ,
		-- {
			-- name = ,
			-- {
			-- },
		-- },
	-- },
	

-- }

local function SortPets(a, b)
	local textA = GetSpellInfo(a) or ""
	local textB = GetSpellInfo(b) or ""
	return textA < textB
end

if DataStore_Pets then
	table.sort(DataStore:GetMountList(), SortPets)
	table.sort(DataStore:GetCompanionList(), SortPets)
end

local companionsCallbacks = {
	OnUpdate = function() 
			petList = DataStore:GetCompanionList()
		end,
	GetSize = function() return #petList end,
	RowSetup = function(self, entry, row, dataRowID)
			currentSpellID = petList[dataRowID]
			local petName
			petName, _, currentPetTexture = GetSpellInfo(currentSpellID)
			
			if petName then
				local rowName = entry .. row
				_G[rowName.."Name"]:SetText(WHITE .. petName)
				_G[rowName.."Name"]:SetJustifyH("LEFT")
				_G[rowName.."Name"]:SetPoint("TOPLEFT", 15, 0)
			end
		end,
	ColumnSetup = function(self, entry, row, column, dataRowID, character)
			local itemName = entry.. row .. "Item" .. column;
			local itemTexture = _G[itemName .. "_Background"]
			local itemButton = _G[itemName]
			local itemText = _G[itemName .. "Name"]
						
			itemText:SetFontObject("GameFontNormalSmall")
			itemText:SetJustifyH("CENTER")
			itemText:SetPoint("BOTTOMRIGHT", 5, 0)
			itemTexture:SetDesaturated(0)
			itemTexture:SetTexCoord(0, 1, 0, 1)
			itemTexture:SetTexture(currentPetTexture)
			
			if DataStore:IsPetKnown(character, "CRITTER", currentSpellID) then
				itemTexture:SetVertexColor(1.0, 1.0, 1.0);
				itemText:SetText(ICON_READY)
			else
				itemTexture:SetVertexColor(0.4, 0.4, 0.4);
				itemText:SetText(ICON_NOTREADY)
			end
			itemButton.id = currentSpellID
		end,
	OnEnter = function(frame) 
			local id = frame.id
			if id then 
				AltoTooltip:SetOwner(frame, "ANCHOR_LEFT");
				AltoTooltip:ClearLines();
				AltoTooltip:SetHyperlink("spell:" ..id);
				AltoTooltip:Show();
			end
			
		end,
	OnClick = nil,
	OnLeave = function(self)
			AltoTooltip:Hide() 
		end,
		
	InitViewDDM = function(frame, title) 
			frame:Hide()
			title:Hide()
		end,
}

local mountsCallbacks = {
	OnUpdate = function() 
			petList = DataStore:GetMountList()
		end,
	GetSize = function() return #petList end,
	RowSetup = function(self, entry, row, dataRowID)
			currentSpellID = petList[dataRowID]
			local petName
			petName, _, currentPetTexture = GetSpellInfo(currentSpellID)
			
			if petName then
				local rowName = entry .. row
				_G[rowName.."Name"]:SetText(WHITE .. petName)
				_G[rowName.."Name"]:SetJustifyH("LEFT")
				_G[rowName.."Name"]:SetPoint("TOPLEFT", 15, 0)
			end
		end,
	ColumnSetup = function(self, entry, row, column, dataRowID, character)
			local itemName = entry.. row .. "Item" .. column;
			local itemTexture = _G[itemName .. "_Background"]
			local itemButton = _G[itemName]
			local itemText = _G[itemName .. "Name"]
			
			itemText:SetFontObject("GameFontNormalSmall")
			itemText:SetJustifyH("CENTER")
			itemText:SetPoint("BOTTOMRIGHT", 5, 0)
			itemTexture:SetDesaturated(0)
			itemTexture:SetTexCoord(0, 1, 0, 1)
			itemTexture:SetTexture(currentPetTexture)
			
			if DataStore:IsPetKnown(character, "MOUNT", currentSpellID) then
				itemTexture:SetVertexColor(1.0, 1.0, 1.0);
				itemText:SetText(ICON_READY)
			else
				itemTexture:SetVertexColor(0.4, 0.4, 0.4);
				itemText:SetText(ICON_NOTREADY)
			end
			itemButton.id = currentSpellID
		end,
	OnEnter = function(frame) 
			local id = frame.id
			if id then 
				AltoTooltip:SetOwner(frame, "ANCHOR_LEFT");
				AltoTooltip:ClearLines();
				AltoTooltip:SetHyperlink("spell:" ..id);
				AltoTooltip:Show();
			end
			
		end,
	OnClick = nil,
	OnLeave = function(self)
			AltoTooltip:Hide() 
		end,
		
	InitViewDDM = function(frame, title) 
			frame:Hide()
			title:Hide()
		end,
}

local tab = addon.Tabs.Grids

tab:RegisterGrid(5, companionsCallbacks)
tab:RegisterGrid(6, mountsCallbacks)
