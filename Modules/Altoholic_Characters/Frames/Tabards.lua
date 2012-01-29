local addonName = "Altoholic"
local addon = _G[addonName]

local WHITE		= "|cFFFFFFFF"

addon.Tabards = {}

local ns = addon.Tabards		-- ns = namespace

local tabardList

local function BuildTabardList()
	tabardList = {}
	
	local tabardNames = {}	-- temp table, used to sort the list faster
	local criteriaID
	
	-- do not use GetAchievementNumCriteria(1021) as it returns 1
	for i = 1, 87 do
		_, _, _, _, _, _, _, _, _, criteriaID = GetAchievementCriteriaInfo(1021, i)
		tabardNames[criteriaID] = GetAchievementCriteriaInfo(criteriaID)
		table.insert(tabardList, criteriaID)
	end
	
	-- sort on tabard name
	table.sort(tabardList, function(a,b) 
		return tabardNames[a] < tabardNames[b]
	end)
	
end

local function Refresh()
	local tabardSlot = GetInventorySlotInfo("TabardSlot")
	local link = GetInventoryItemLink("player", tabardSlot)
	
	if link then
		ns:Update()
	end
end

function ns:Update()
	if not tabardList then
		BuildTabardList()
		addon:RegisterEvent("UNIT_INVENTORY_CHANGED", Refresh)
	end
	
	AltoholicTabCharactersStatus:SetText("")

	local VisibleLines = 8
	local frame = "AltoholicFrameTabards"
	local entry = frame.."Entry"
		
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );

	local criteriaID, itemID
	local realm, account = addon.Tabs.Characters:GetRealm()
	local character

	for i=1, VisibleLines do
		local line = i + offset
		if line <= #tabardList then	-- if the line is visible

			criteriaID = tabardList[line]
			local tabardName, _, _, _, _, _, _, itemID = GetAchievementCriteriaInfo(criteriaID)
			
			if tabardName then
				_G[entry..i.."Name"]:SetText(WHITE .. tabardName)
				_G[entry..i.."Name"]:SetJustifyH("LEFT")
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
			end
			
			for j = 1, 10 do
				local itemName = entry.. i .. "Item" .. j;
				local itemButton = _G[itemName]
				local itemTexture = _G[itemName .. "_Background"]
				
				character = addon:GetOption(format("Tabs.Characters.%s.%s.Column%d", account, realm, j))
				if character then
					itemButton:SetScript("OnEnter", function(self) 
						self.link = nil
						addon:Item_OnEnter(self) 
					end)
					itemButton:SetScript("OnClick", function(self, button)
						self.link = nil
						addon:Item_OnClick(self, button)
					end)
					itemButton:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
					
					itemTexture:SetTexture(GetItemIcon(itemID))
					
					if DataStore:IsTabardKnown(character, criteriaID) then
						itemTexture:SetVertexColor(1.0, 1.0, 1.0);
						_G[itemName .. "Name"]:SetText("\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t")
					else
						itemTexture:SetVertexColor(0.4, 0.4, 0.4);
						_G[itemName .. "Name"]:SetText("\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t")
					end
					itemButton.id = itemID
					itemButton:Show()
				else
					itemButton.id = nil
					itemButton:Hide()
				end
			end

			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end

	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], #tabardList, VisibleLines, 41);
end
