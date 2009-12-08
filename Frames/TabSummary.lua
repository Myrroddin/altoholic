local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local SUMMARY_THISREALM = 1
local SUMMARY_ALLREALMS = 2
local SUMMARY_ALLACCOUNTS = 3

Altoholic.Tabs.Summary = {}

function Altoholic.Tabs.Summary:Init()
	self.Frames = {
		"Summary",
		"BagUsage",
		"Skills",
		"Activity",
		"GuildMembers",
		"GuildProfessions",
		"GuildBankTabs",
		"Calendar",
	}

	self.Objects = {		-- these are the tables that actually contain the BuildView & Update methods. Not really OOP, but enough for our needs
		Altoholic.Summary,
		Altoholic.BagUsage,
		Altoholic.TradeSkills,
		Altoholic.Activity,
		Altoholic.Guild.Members,
		Altoholic.Guild.Professions,
		Altoholic.Guild.BankTabs,
		Altoholic.Calendar,
	}
	
	local f = AltoholicTabSummary_SelectLocation
	UIDropDownMenu_SetSelectedValue(f, Altoholic.Options:Get("TabSummaryMode"))
	UIDropDownMenu_SetText(f, select(Altoholic.Options:Get("TabSummaryMode"), L["This realm"], L["All realms"], L["All accounts"]))
	UIDropDownMenu_Initialize(f, self.DropDownLocation_Initialize)
	
	Altoholic.Calendar:Init()
end

function Altoholic.Tabs.Summary:DropDownLocation_Initialize()
	local self = Altoholic.Tabs.Summary
	local info = UIDropDownMenu_CreateInfo();
	
	info.text = L["This realm"]
	info.value = SUMMARY_THISREALM
	info.func = self.SetRealmFilter
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	
	
	info.text = L["All realms"]
	info.value = SUMMARY_ALLREALMS
	info.func = self.SetRealmFilter
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	

	info.text = L["All accounts"]
	info.value = SUMMARY_ALLACCOUNTS
	info.func = self.SetRealmFilter
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	
end

function Altoholic.Tabs.Summary:SetRealmFilter()
	UIDropDownMenu_SetSelectedValue(AltoholicTabSummary_SelectLocation, self.value);
	
	Altoholic.Options:Set("TabSummaryMode", self.value)
	Altoholic.Characters:BuildList()
	Altoholic.Characters:BuildView()
	Altoholic.Tabs.Summary:Refresh()
end

function Altoholic.Tabs.Summary:MenuItem_OnClick(id)
	for _, v in pairs(self.Frames) do			-- hide all frames
		_G[ "AltoholicFrame" .. v]:Hide()
	end

	self:SetMode(id)
	
	if id == 5 then				-- specific treatment per frame goes here
		if IsInGuild() then
			GuildRoster()
		end
	end
	
	local f = _G[ "AltoholicFrame" .. self.Frames[id]]
	local o = self.Objects[id]
	
	if o.BuildView then
		o:BuildView()
	end
	f:Show()
	o:Update()
	
	for i=1, 8 do 
		_G[ "AltoholicTabSummaryMenuItem"..i ]:UnlockHighlight();
	end
	_G[ "AltoholicTabSummaryMenuItem"..id ]:LockHighlight();
end

function Altoholic.Tabs.Summary:SetMode(mode)
	self.mode = mode
	
	AltoholicTabSummaryStatus:SetText("")
	AltoholicTabSummaryToggleView:Show()
	AltoholicTabSummary_SelectLocation:Show()
	AltoholicTabSummary_RequestSharing:Show()
	AltoholicTabSummary_Options:Show()
	
	local Columns = Altoholic.Tabs.Columns
	Columns:Init()
	
	local title

	if mode == 1 then
		Columns:Add(NAME, 100, function(self) Altoholic.Characters:Sort(self, "GetCharacterName") end)
		Columns:Add(LEVEL, 60, function(self) Altoholic.Characters:Sort(self, "GetCharacterLevel")	end)
		Columns:Add(MONEY, 115, function(self)	Altoholic.Characters:Sort(self, "GetMoney") end)
		Columns:Add(PLAYED, 105, function(self) Altoholic.Characters:Sort(self, "GetPlayTime") end)
		Columns:Add(XP, 55, function(self) Altoholic.Characters:Sort(self, "GetXPRate") end)
		Columns:Add(TUTORIAL_TITLE26, 70, function(self) Altoholic.Characters:Sort(self, "GetRestXPRate") end)
		Columns:Add("AiL", 55, function(self) Altoholic.Characters:Sort(self, "GetAverageItemLevel")	end)
	
	elseif mode == 2 then
		Columns:Add(NAME, 100, function(self) Altoholic.Characters:Sort(self, "GetCharacterName") end)
		Columns:Add(LEVEL, 60, function(self) Altoholic.Characters:Sort(self, "GetCharacterLevel") end)
		Columns:Add(L["Bags"], 120, function(self) Altoholic.Characters:Sort(self, "GetNumBagSlots") end)
		Columns:Add(L["free"], 50, function(self) Altoholic.Characters:Sort(self, "GetNumFreeBagSlots") end)
		Columns:Add(L["Bank"], 190, function(self) Altoholic.Characters:Sort(self, "GetNumBankSlots") end)
		Columns:Add(L["free"], 50, function(self)	Altoholic.Characters:Sort(self, "GetNumFreeBankSlots")	end)
		
	elseif mode == 3 then
		Columns:Add(NAME, 100, function(self) Altoholic.Characters:Sort(self, "GetCharacterName") end)
		Columns:Add(LEVEL, 60, function(self) Altoholic.Characters:Sort(self, "GetCharacterLevel") end)
		Columns:Add(L["Prof. 1"], 65, function(self) Altoholic.Characters:Sort(self, "skillName1") end)
		Columns:Add(L["Prof. 2"], 65, function(self) Altoholic.Characters:Sort(self, "skillName2") end)
		title = GetSpellInfo(2550)		-- cooking
		Columns:Add(title, 65, function(self) Altoholic.Characters:Sort(self, "GetCookingRank") end)
		title = GetSpellInfo(3273)		-- First Aid
		Columns:Add(title, 65, function(self) Altoholic.Characters:Sort(self, "GetFirstAidRank") end)
		title = GetSpellInfo(24303)	-- Fishing
		Columns:Add(title, 65, function(self) Altoholic.Characters:Sort(self, "GetFishingRank") end)
		Columns:Add(L["Riding"], 65, function(self) Altoholic.Characters:Sort(self, "GetRidingRank") end)
		
	elseif mode == 4 then
		Columns:Add(NAME, 100, function(self) Altoholic.Characters:Sort(self, "GetCharacterName") end)
		Columns:Add(LEVEL, 60, function(self) Altoholic.Characters:Sort(self, "GetCharacterLevel") end)
		Columns:Add(L["Mails"], 60, function(self) Altoholic.Characters:Sort(self, "GetNumMails") end)
		Columns:Add(L["Visited"], 60, function(self) Altoholic.Characters:Sort(self, "GetMailboxLastVisit") end)
		Columns:Add(AUCTIONS, 70, function(self) Altoholic.Characters:Sort(self, "GetNumAuctions") end)
		Columns:Add(BIDS, 60, function(self) Altoholic.Characters:Sort(self, "GetNumBids") end)
		Columns:Add(L["Visited"], 60, function(self) Altoholic.Characters:Sort(self, "GetAuctionHouseLastVisit") end)
		Columns:Add(LASTONLINE, 90, function(self) Altoholic.Characters:Sort(self, "GetLastLogout") end)

	elseif mode == 5 then
		Columns:Add(NAME, 100, function(self) Altoholic.Guild.Members:Sort(self, "name") end)
		Columns:Add(LEVEL, 60, function(self) Altoholic.Guild.Members:Sort(self, "level") end)
		Columns:Add("AiL", 65, function(self) Altoholic.Guild.Members:Sort(self, "averageItemLvl") end)
		Columns:Add(GAME_VERSION_LABEL, 80, function(self) Altoholic.Guild.Members:Sort(self, "version") end)
		Columns:Add(CLASS, 100, function(self) Altoholic.Guild.Members:Sort(self, "englishClass") end)

	elseif mode == 6 then
		Columns:Add(NAME, 60, function(self) Altoholic.Guild.Professions:Sort(self, "name") end)
		Columns:Add(LEVEL, 60, function(self) Altoholic.Guild.Professions:Sort(self, "level") end)
		Columns:Add(CLASS, 120, function(self) Altoholic.Guild.Professions:Sort(self, "englishClass") end)
		Columns:Add(L["Prof. 1"], 110, function(self) Altoholic.Guild.Professions:Sort(self, "profLink", 1) end)
		Columns:Add(L["Prof. 2"], 110, function(self) Altoholic.Guild.Professions:Sort(self, "profLink", 2) end)
		title = GetSpellInfo(2550)		-- cooking
		Columns:Add(title, 110, function(self) Altoholic.Guild.Professions:Sort(self, "profLink", 3) end)
		
	elseif mode == 7 then
		Columns:Add(NAME, 100, nil)
		Columns:Add(TIMEMANAGER_TOOLTIP_LOCALTIME, 120,  nil)
		Columns:Add(TIMEMANAGER_TOOLTIP_REALMTIME, 120,  nil)
	elseif mode == 8 then
		AltoholicTabSummaryToggleView:Hide()
		AltoholicTabSummary_SelectLocation:Hide()
		AltoholicTabSummary_RequestSharing:Hide()
		AltoholicTabSummary_Options:Hide()
	end
end

function Altoholic.Tabs.Summary:Refresh()
	if AltoholicFrameSummary:IsVisible() then
		Altoholic.Summary:Update()
	elseif AltoholicFrameBagUsage:IsVisible() then
		Altoholic.BagUsage:Update()
	elseif AltoholicFrameSkills:IsVisible() then
		Altoholic.TradeSkills:Update()
	elseif AltoholicFrameActivity:IsVisible() then
		Altoholic.Activity:Update()
	elseif AltoholicFrameGuildMembers:IsVisible() then
		Altoholic.Guild.Members:Update()
	elseif AltoholicFrameGuildProfessions:IsVisible() then
		Altoholic.Guild.Professions:Update()
	elseif AltoholicFrameGuildBankTabs:IsVisible() then
		Altoholic.Guild.BankTabs:Update()
	elseif AltoholicFrameCalendar:IsVisible() then
		Altoholic.Calendar.Events:BuildList()
		Altoholic.Calendar:Update()
	end
end

local INFO_REALM_LINE = 0

function Altoholic.Tabs.Summary:ToggleView(self)
	local mode = Altoholic.Tabs.Summary.mode
	
	if not self.isCollapsed then
		self.isCollapsed = true
		AltoholicTabSummaryToggleView:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
	else
		self.isCollapsed = nil
		AltoholicTabSummaryToggleView:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
	end

	if (mode >= 1) and (mode <= 4) then
		for line, s in pairs(Altoholic.Characters.List) do
			if mod(s.linetype, 3) == INFO_REALM_LINE then
				s.isCollapsed = (self.isCollapsed) or false
			end
		end
		Altoholic.Tabs.Summary:Refresh()
	elseif mode == 5 then
		Altoholic.Guild.Members:ToggleView(self)
	elseif mode == 6 then
		Altoholic.Guild.Professions:ToggleView(self)
	elseif mode == 7 then
		Altoholic.Guild.BankTabs:ToggleView(self)
	end
end

function Altoholic.Tabs.Summary:AccountSharingButton_OnEnter(self)
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT")
	AltoTooltip:ClearLines()
	AltoTooltip:SetText(L["Account Sharing Request"])
	AltoTooltip:AddLine(L["Click this button to ask a player\nto share his entire Altoholic Database\nand add it to your own"],1,1,1)
	AltoTooltip:Show()
end

function Altoholic.Tabs.Summary:AccountSharingButton_OnClick()
	if Altoholic.Options:Get("AccSharingHandlerEnabled") == 0 then
		Altoholic:Print(L["Both parties must enable account sharing\nbefore using this feature (see options)"])
		return
	end
	Altoholic:ToggleUI()
	
	if AltoAccountSharing_SendButton.requestMode then
		Altoholic.Comm.Sharing:SetMode(2)
	else
		Altoholic.Comm.Sharing:SetMode(1)
	end
	AltoAccountSharing:Show()
end

