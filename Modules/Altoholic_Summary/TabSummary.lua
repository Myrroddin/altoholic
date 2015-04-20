local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local parent = "AltoholicTabSummary"
local rcMenuName = parent .. "RightClickMenu"	-- name of right click menu frames (add a number at the end to get it)

local OPTION_REALMS = "UI.Tabs.Summary.CurrentRealms"

local THISREALM_THISACCOUNT = 1
local THISREALM_ALLACCOUNTS = 2
local ALLREALMS_THISACCOUNT = 3
local ALLREALMS_ALLACCOUNTS = 4

local NUM_MENU_ITEMS = 6

addon.Tabs.Summary = {}

local ns = addon.Tabs.Summary		-- ns = namespace

local locationLabels = {
	[THISREALM_THISACCOUNT] = format("%s %s(%s)", L["This realm"], colors.green, L["This account"]),
	[THISREALM_ALLACCOUNTS] = format("%s %s(%s)", L["This realm"], colors.green, L["All accounts"]),
	[ALLREALMS_THISACCOUNT] = format("%s %s(%s)", L["All realms"], colors.green, L["This account"]),
	[ALLREALMS_ALLACCOUNTS] = format("%s %s(%s)", L["All realms"], colors.green, L["All accounts"]),
}

local function OnRealmFilterChange(self)
	UIDropDownMenu_SetSelectedValue(AltoholicTabSummary_SelectLocation, self.value);
	
	addon:SetOption(OPTION_REALMS, self.value)
	addon.Characters:InvalidateView()
	addon.Summary:Update()
end

local function DropDownLocation_Initialize()
	local info = UIDropDownMenu_CreateInfo();
	
	info.text = locationLabels[THISREALM_THISACCOUNT]
	info.value = THISREALM_THISACCOUNT
	info.func = OnRealmFilterChange
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	
	
	info.text = locationLabels[THISREALM_ALLACCOUNTS]
	info.value = THISREALM_ALLACCOUNTS
	info.func = OnRealmFilterChange
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	
	
	info.text = locationLabels[ALLREALMS_THISACCOUNT]
	info.value = ALLREALMS_THISACCOUNT
	info.func = OnRealmFilterChange
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	

	info.text = locationLabels[ALLREALMS_ALLACCOUNTS]
	info.value = ALLREALMS_ALLACCOUNTS
	info.func = OnRealmFilterChange
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	
end

function ns:MenuItem_OnClick(id)
	addon.Summary:SetMode(id)
	addon.Summary:Update()
	
	for i=1, NUM_MENU_ITEMS do 
		AltoholicTabSummary["MenuItem"..i]:UnlockHighlight()
	end
	AltoholicTabSummary["MenuItem"..id]:LockHighlight()
end

function ns:ToggleView(frame)
	if not frame.isCollapsed then
		frame.isCollapsed = true
		AltoholicTabSummaryToggleView:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
	else
		frame.isCollapsed = nil
		AltoholicTabSummaryToggleView:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
	end

	addon.Characters:ToggleView(frame)
	addon.Summary:Update()
end

function ns:AccountSharingButton_OnEnter(self)
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT")
	AltoTooltip:ClearLines()
	AltoTooltip:SetText(L["Account Sharing Request"])
	AltoTooltip:AddLine(L["Click this button to ask a player\nto share his entire Altoholic Database\nand add it to your own"],1,1,1)
	AltoTooltip:Show()
end

function ns:AccountSharingButton_OnClick()
	if addon:GetOption("UI.AccountSharing.IsEnabled") == 0 then
		addon:Print(L["Both parties must enable account sharing\nbefore using this feature (see options)"])
		return
	end
	addon:ToggleUI()
	
	if AltoAccountSharing_SendButton.requestMode then
		addon.Comm.Sharing:SetMode(2)
	else
		addon.Comm.Sharing:SetMode(1)
	end
	AltoAccountSharing:Show()
end

local DDM_Add = addon.Helpers.DDM_Add
local DDM_AddTitle = addon.Helpers.DDM_AddTitle
local DDM_AddCloseMenu = addon.Helpers.DDM_AddCloseMenu
local NUM_RC_MENUS = 2

-- ** Icon events **
local function ShowOptionsCategory(self)
	addon:ToggleUI()
	InterfaceOptionsFrame_OpenToCategory(self.value)
end

local function ResetAllData_MsgBox_Handler(self, button)
	if not button then return end
	
	DataStore:ClearAllData()
	addon:Print(L["Information saved in DataStore has been completely deleted !"])
	
	-- rebuild the main character table, and all the menus
	addon.Characters:InvalidateView()
	addon.Summary:Update()
end

local function ResetAllData()
	-- reset all data stored in datastore modules
	addon:SetMsgBoxHandler(ResetAllData_MsgBox_Handler)
	
	AltoMsgBox_Text:SetText(L["WIPE_DATABASE"])
	AltoMsgBox:Show()
end

local function ResetConnectedRealms_MsgBox_Handler(self, button)
	if not button then return end
	
	DataStore:ClearAllConnectedRealms()
	addon:Print(L["Realm links successfully deleted"])
end

local function ResetConnectedRealms()
	-- reset connected realms, only the links between realms, not the data from other alts
	addon:SetMsgBoxHandler(ResetConnectedRealms_MsgBox_Handler)
	
	AltoMsgBox_Text:SetText(L["Reset connected realms ?"])
	AltoMsgBox:Show()
end

-- ** Menu Icons **
function ns:Icon_OnEnter(frame)
	local currentMenuID = frame:GetID()
	
	-- hide all
	for i = 1, NUM_RC_MENUS do
		if i ~= currentMenuID and _G[ rcMenuName .. i ].visible then
			ToggleDropDownMenu(1, nil, _G[ rcMenuName .. i ], frame:GetName(), 0, -5);	
			_G[ rcMenuName .. i ].visible = false
		end
	end

	-- show current
	ToggleDropDownMenu(1, nil, _G[ rcMenuName .. currentMenuID ], frame:GetName(), 0, -5);	
	_G[ rcMenuName .. currentMenuID ].visible = true
end

local function AltoholicOptionsIcon_Initialize(self, level)
	DDM_AddTitle(format("%s: %s", GAMEOPTIONS_MENU, addonName))

	DDM_Add(GENERAL, AltoholicGeneralOptions, ShowOptionsCategory)
	DDM_Add(L["Calendar"], AltoholicCalendarOptions, ShowOptionsCategory)
	DDM_Add(MAIL_LABEL, AltoholicMailOptions, ShowOptionsCategory)
	DDM_Add(MISCELLANEOUS, AltoholicMiscOptions, ShowOptionsCategory)
	DDM_Add(SEARCH, AltoholicSearchOptions, ShowOptionsCategory)
	DDM_Add(L["Tooltip"], AltoholicTooltipOptions, ShowOptionsCategory)
	
	DDM_AddTitle(" ")	
	DDM_AddTitle(OTHER)	
	DDM_Add("What's new?", AltoholicWhatsNew, ShowOptionsCategory)
	DDM_Add("Getting support", AltoholicSupport, ShowOptionsCategory)
	DDM_Add(L["Memory used"], AltoholicMemoryOptions, ShowOptionsCategory)
	DDM_Add(HELP_LABEL, AltoholicHelp, ShowOptionsCategory)
	DDM_AddCloseMenu()
end

local addonList = {
	"DataStore_Auctions",
	"DataStore_Characters",
	"DataStore_Garrisons",
	"DataStore_Inventory",
	"DataStore_Mails",
	"DataStore_Quests",
}

local function DataStoreOptionsIcon_Initialize(self, level)
	DDM_AddTitle(format("%s: %s", GAMEOPTIONS_MENU, "DataStore"))
	
	for _, module in ipairs(addonList) do
		if _G[module] then	-- only add loaded modules
			DDM_Add(module, module, ShowOptionsCategory)
		end
	end
	
	DDM_AddTitle(" ")	
	
	DDM_Add(L["Reset all data"], nil, ResetAllData)
	DDM_Add(L["Reset connected realms"], nil, ResetConnectedRealms)
	DDM_Add(HELP_LABEL, DataStoreHelp, ShowOptionsCategory)
	DDM_AddCloseMenu()
end

function ns:OnLoad()
	AltoholicTabSummary.MenuItem1:SetText(L["Account Summary"])
	AltoholicTabSummary.MenuItem2:SetText(L["Bag Usage"])
	AltoholicTabSummary.MenuItem4:SetText(L["Activity"])
	AltoholicTabSummary_RequestSharing:SetText(L["Account Sharing"])

	addon:DDM_Initialize(_G[rcMenuName.."1"], AltoholicOptionsIcon_Initialize)
	addon:DDM_Initialize(_G[rcMenuName.."2"], DataStoreOptionsIcon_Initialize)
	
	local f = AltoholicTabSummary_SelectLocation
	UIDropDownMenu_SetSelectedValue(f, addon:GetOption(OPTION_REALMS))
	UIDropDownMenu_SetText(f, select(addon:GetOption(OPTION_REALMS), locationLabels[THISREALM_THISACCOUNT], locationLabels[THISREALM_ALLACCOUNTS], locationLabels[ALLREALMS_THISACCOUNT], locationLabels[ALLREALMS_ALLACCOUNTS]))
	addon:DDM_Initialize(f, DropDownLocation_Initialize)
end
