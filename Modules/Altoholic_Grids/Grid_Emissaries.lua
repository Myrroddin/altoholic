local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors
local icons = addon.Icons

local ICON_VIEW_QUESTS = "Interface\\LFGFrame\\LFGIcon-Quest"
local OPTION_QUESTS = "UI.Tabs.Grids.Dailies.CurrentQuests"

local questList
local view

local function BuildView()
	questList = {}
	view = {}
	
	local account, realm = AltoholicTabGrids:GetRealm()
	
	for _, character in pairs(DataStore:GetCharacters(realm, account)) do	-- all alts on this realm
		for questID, _ in pairs(DataStore:GetEmissaryQuests()) do
			local isOnQuest, questLogIndex = DataStore:IsCharacterOnQuest(character, questID)
			if isOnQuest then
				local _, link = DataStore:GetQuestLogInfo(character, questLogIndex)
				local questName = DataStore:GetQuestInfo(link)

				if not questList[questID] then
					questList[questID] = {}
					questList[questID].title = questName
					questList[questID].notCompletedBy = {}
				end				

				questList[questID].notCompletedBy[character] = true
			end
		end
	end
	
	for k, v in pairs(questList) do
		table.insert(view, k)
	end

	table.sort(view, function(a,b) 
		return questList[a].title < questList[b].title
	end)
end

local callbacks = {
	OnUpdate = function() 
			BuildView()
		end,
	GetSize = function() return #view end,
	RowSetup = function(self, rowFrame, dataRowID)
			local name = questList[ view[dataRowID] ].title
			if name then
				rowFrame.Name.Text:SetText(format("%s%s", colors.white, name))
				rowFrame.Name.Text:SetJustifyH("LEFT")
			end
		end,
	RowOnEnter = function() end,
	RowOnLeave = function() end,
	ColumnSetup = function(self, button, dataRowID, character)
			button.Name:SetFontObject("GameFontNormalSmall")
			button.Name:SetJustifyH("CENTER")
			button.Name:SetPoint("BOTTOMRIGHT", 5, 0)
			button.Background:SetDesaturated(false)
			button.Background:SetTexCoord(0, 1, 0, 1)
			button.Background:SetTexture(ICON_VIEW_QUESTS)
			
			if questList[view[dataRowID]].notCompletedBy[character]  then
				button.Background:SetVertexColor(1.0, 1.0, 1.0)
				button.Name:SetText(icons.ready)
			else
				button.Background:SetVertexColor(0.4, 0.4, 0.4)
				button.Name:SetText(icons.notReady)
			end
		end,
	OnEnter = function(self) 
			self.link = nil
			addon:Item_OnEnter(self) 
		end,
	OnClick = nil,
	OnLeave = function(self)
			GameTooltip:Hide() 
		end,
		
	InitViewDDM = function(frame, title) 
			frame:Hide()
			title:Hide()
		end,
}

AltoholicTabGrids:RegisterGrid(12, callbacks)
