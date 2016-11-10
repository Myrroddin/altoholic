local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local function _Update(frame, account, realm, allianceID, hordeID)
	local _, achName, _, isComplete, _, _, _, _, flags = GetAchievementInfo(allianceID)		-- use the alliance name if a
	
	-- if not achName then 
		-- DEFAULT_CHAT_FRAME:AddMessage(allianceID)
		-- achName = allianceID
	-- end
	
	local isAccountBound = ( bit.band(flags, ACHIEVEMENT_FLAGS_ACCOUNT) == ACHIEVEMENT_FLAGS_ACCOUNT ) 
	
	frame.Name.Text:SetText(format("%s%s", (isAccountBound and colors.cyan or colors.white), achName))
	frame.Name.Text:SetJustifyH("LEFT")
	
	local button
	local character
	local achievementID
	
	for colIndex = 1, 12 do
		button = frame["Item"..colIndex]
		button.IconBorder:Hide()
		
		character = addon:GetOption(format("Tabs.Achievements.%s.%s.Column%d", account, realm, colIndex))
		if character then
			if hordeID and DataStore:GetCharacterFaction(character) ~= "Alliance" then
				achievementID = hordeID
			else
				achievementID = allianceID
			end
			
			button:SetImage(achievementID)
			button:SetCompletionStatus(character, achievementID, isAccountBound)
			button:SetInfo(character, achievementID)
			button:Show()
		else
			button:SetInfo(nil, nil)
			button:Hide()
		end
	end
	frame:Show()
end

addon:RegisterClassExtensions("AltoAchievementRow", {
	Update = _Update,
})
