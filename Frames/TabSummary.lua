local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
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
	
	local Columns = Altoholic.Tabs.Columns
	Columns:Init()

	if mode == 1 then
		Columns:Add(NAME, 100, function(self) Altoholic.Characters:Sort(self, "name") end)
		Columns:Add(LEVEL, 60, function(self) Altoholic.Characters:Sort(self, "level")	end)
		Columns:Add(MONEY, 115, function(self)	Altoholic.Characters:Sort(self, "money") end)
		Columns:Add(PLAYED, 105, function(self) Altoholic.Characters:Sort(self, "played") end)
		Columns:Add(XP, 55, function(self) Altoholic.Characters:Sort(self, "xp") end)
		Columns:Add(TUTORIAL_TITLE26, 70, function(self) Altoholic.Characters:Sort(self, "restxp") end)
		Columns:Add("AiL", 55, function(self) Altoholic.Characters:Sort(self, "averageItemLvl")	end)
	
	elseif mode == 2 then
		Columns:Add(NAME, 100, function(self) Altoholic.Characters:Sort(self, "name") end)
		Columns:Add(LEVEL, 60, function(self) Altoholic.Characters:Sort(self, "level") end)
		Columns:Add(L["Bags"], 120, function(self) Altoholic.Characters:Sort(self, "numBagSlots") end)
		Columns:Add(L["free"], 50, function(self) Altoholic.Characters:Sort(self, "numFreeBagSlots") end)
		Columns:Add(L["Bank"], 190, function(self) Altoholic.Characters:Sort(self, "numBankSlots") end)
		Columns:Add(L["free"], 50, function(self)	Altoholic.Characters:Sort(self, "numFreeBankSlots")	end)
		
	elseif mode == 3 then
		Columns:Add(NAME, 100, function(self) Altoholic.Characters:Sort(self, "name") end)
		Columns:Add(LEVEL, 60, function(self) Altoholic.Characters:Sort(self, "level") end)
		Columns:Add(L["Prof. 1"], 65, function(self) Altoholic.Characters:Sort(self, "skillName1") end)
		Columns:Add(L["Prof. 2"], 65, function(self) Altoholic.Characters:Sort(self, "skillName2") end)
		Columns:Add(BI["Cooking"], 65, function(self) Altoholic.Characters:Sort(self, BI["Cooking"]) end)
		Columns:Add(BI["First Aid"], 65, function(self) Altoholic.Characters:Sort(self, BI["First Aid"]) end)
		Columns:Add(BI["Fishing"], 65, function(self) Altoholic.Characters:Sort(self, BI["Fishing"]) end)
		Columns:Add(L["Riding"], 65, function(self) Altoholic.Characters:Sort(self, L["Riding"]) end)
		
	elseif mode == 4 then
		Columns:Add(NAME, 100, function(self) Altoholic.Characters:Sort(self, "name") end)
		Columns:Add(LEVEL, 60, function(self) Altoholic.Characters:Sort(self, "level") end)
		Columns:Add(L["Mails"], 60, function(self) Altoholic.Characters:Sort(self, "mail") end)
		Columns:Add(L["Visited"], 60, function(self) Altoholic.Characters:Sort(self, "lastmailcheck") end)
		Columns:Add(AUCTIONS, 70, function(self) Altoholic.Characters:Sort(self, "auctions") end)
		Columns:Add(BIDS, 60, function(self) Altoholic.Characters:Sort(self, "bids") end)
		Columns:Add(L["Visited"], 60, function(self) Altoholic.Characters:Sort(self, "lastAHcheck") end)
		Columns:Add(LASTONLINE, 90, function(self) Altoholic.Characters:Sort(self, "lastlogout") end)

	elseif mode == 5 then
		Columns:Add(NAME, 100, function(self) Altoholic.Tabs.Summary:SortGuild(self, "name") end)
		Columns:Add(LEVEL, 60, function(self) Altoholic.Tabs.Summary:SortGuild(self, "level") end)
		Columns:Add("AiL", 65, function(self) Altoholic.Tabs.Summary:SortGuild(self, "averageItemLvl") end)
		Columns:Add(GAME_VERSION_LABEL, 80, function(self) Altoholic.Tabs.Summary:SortGuild(self, "version") end)
		Columns:Add(CLASS, 100, function(self) Altoholic.Tabs.Summary:SortGuild(self, "englishClass") end)

	elseif mode == 6 then
		Columns:Add(NAME, 60, function(self) Altoholic.Tabs.Summary:SortGuild(self, "name") end)
		Columns:Add(LEVEL, 60, function(self) Altoholic.Tabs.Summary:SortGuild(self, "level") end)
		Columns:Add(CLASS, 120, function(self) Altoholic.Tabs.Summary:SortGuild(self, "englishClass") end)
		Columns:Add(L["Prof. 1"], 110, function(self) Altoholic.Tabs.Summary:SortGuild(self, "prof1link") end)
		Columns:Add(L["Prof. 2"], 110, function(self) Altoholic.Tabs.Summary:SortGuild(self, "prof2link") end)
		Columns:Add(BI["Cooking"], 110, function(self) Altoholic.Tabs.Summary:SortGuild(self, "cookinglink") end)
		
	elseif mode == 7 then
		Columns:Add(NAME, 100, nil)
		Columns:Add(TIMEMANAGER_TOOLTIP_LOCALTIME, 120,  nil)
		Columns:Add(TIMEMANAGER_TOOLTIP_REALMTIME, 120,  nil)
	elseif mode == 8 then
		AltoholicTabSummaryToggleView:Hide()
		AltoholicTabSummary_SelectLocation:Hide()
		AltoholicTabSummary_RequestSharing:Hide()
	end
	
end

function Altoholic.Tabs.Summary:SortGuild(self, field)
	
	if Altoholic.Tabs.Summary.mode == 6 then
		Altoholic.Tabs.Summary.GuildProfessionsSortBy = field
		Altoholic.Tabs.Summary.GuildProfessionsSortOrder = self.ascendingSort
	end
	
	Altoholic.Guild.Members:Sort(field, self.ascendingSort)
	Altoholic.Tabs.Summary:Refresh()
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
		Altoholic.Guild.Members:BuildView()
		Altoholic.Guild.Members:Update()
	elseif AltoholicFrameGuildProfessions:IsVisible() then
		Altoholic.Guild.Professions:BuildView()
		Altoholic.Guild.Professions:Update()
	elseif AltoholicFrameGuildBankTabs:IsVisible() then
		Altoholic.Guild.BankTabs:BuildView()
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
		for line, s in pairs(Altoholic.Guild.Members.view) do
			if s.linetype == 1 then			-- ALTO_MAIN_LINE = 1
				s.isCollapsed = (self.isCollapsed) or false
			end
		end
		Altoholic.Guild.Members:Update()
	elseif mode == 6 then
		for line, s in pairs(Altoholic.Guild.Professions.view) do
			if mod(s.linetype, 2) == 0 then		-- MAIN_LINE = 0
				s.isCollapsed = (self.isCollapsed) or false
			end
		end
		Altoholic.Guild.Professions:Update()
	elseif mode == 7 then
		for line, s in pairs(Altoholic.Guild.BankTabs.view) do
			if mod(s.linetype, 2) == 0 then		-- CHAR_LINE = 0
				s.isCollapsed = (self.isCollapsed) or false
			end
		end
		Altoholic.Guild.BankTabs:Update()
	end
end
