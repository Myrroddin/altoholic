local addonName = "Altoholic"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0", "AceSerializer-3.0")

local addon = _G[addonName]

addon.Version = "v3.2.003b"
addon.VersionNum = 302003

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local commPrefix = addonName

BINDING_HEADER_ALTOHOLIC = addonName;
BINDING_NAME_ALTOHOLIC_TOGGLE = "Toggle UI";

local options = { 
	type= "group",
	args = {
		search = {
			type = "input",
			name = L['search'],
			usage = "<item name>",
			desc = L["Search in bags"],
			get = false,
			set = "CmdSearchBags",
		},
		show = {
			type = "execute",
			name = L['show'],
			desc = L["Shows the UI"],
			func = function() AltoholicFrame:Show() end
		},
		hide = {
			type = "execute",
			name = L['hide'],
			desc = L["Hides the UI"],
			func = function() AltoholicFrame:Hide() end
		},
		toggle = {
			type = "execute",
			name = L['toggle'],
			desc = L["Toggles the UI"],
			func = function() Altoholic:ToggleUI() end
		},
	},
}
 
local AltoholicDB_Defaults = {
	global = {
		Guilds = {
			['*'] = {			-- ["Account.Realm.Name"] 
				hideInTooltip = nil,		-- true if this guild should not be shown in the tooltip counters
				bankmoney = 0,
				faction = nil,
				members = {
					['*'] = {		-- player name
						prof1link = nil,
						prof2link = nil,
						cookinglink = nil,
					}
				},
			},
		},
		Characters = {
			['*'] = {					-- ["Account.Realm.Name"] 
				Friends = {},
				SavedInstance = {},	-- raid timers
				Calendar = {},
				Timers = {},			-- goes in pair with Calendar, different table to prevent messing with Calendar, SavedInstance and ProfessionCooldowns, used for eggs among others
				ConnectMMO = {},		-- Imported events come here
			},
		},
		Sharing = {
			Clients = {},
			SharedContent = {			-- lists the shared content
				--	["Account.Realm.Name"]  = true means the char is shared,
				--	["Account.Realm.Name.Module"]  = true means the module is shared for that char
			},
			Domains = {
				['*'] = {			-- ["Account.Realm"] 
					lastSharingTimestamp = nil,	-- a date, the last time information from this realm/account was queried and successfully saved.
					lastUpdatedWith = nil,		-- last player with whom the account sharing took place
				},
			},
		},
		unsafeItems = {},
		options = {
			-- ** Misc options **
			TabSummaryMode = 2,
			lastContainerView = 1,			-- default container view = bags+bank
			
			-- ** General options **
			RestXPMode = 0, 					-- display max rest xp in normal 100% mode or in level equivalent 150% mode (1) ?
			AccSharingHandlerEnabled = 0,	-- account sharing communication handler is disabled by default
			GuildBankAutoUpdate = 0,		-- can the guild bank tabs update requests be answered automatically or not.
			GuildHandlerEnabled = 1,		-- guild communication handler is enabled by default
			UIScale = 1.0,
			UITransparency = 1.0,
			
			-- ** Search options **
			TotalLoots = 0,					-- make at least one search in the loot tables to initialize these values
			UnknownLoots = 0,
			SearchAutoQuery = 0,
			SortDescending = 0, 				-- display search results in the loot table in ascending (0) or descending (1) order ?
			IncludeNoMinLevel = 1,
			IncludeMailbox = 1,
			IncludeGuildBank = 1,
			IncludeRecipes = 1,
			IncludeGuildSkills = 1,			-- search other guild members' professions ? (via their profession links)

			-- ** Mail options **
			GuildMailWarning = 1,			-- be informed when a guildie sends a mail to one of my alts
			NameAutoComplete = 1,
			
			-- ** Minimap options **
			MinimapIconAngle = 180,
			MinimapIconRadius = 78,
			ShowMinimap = 1,
			
			-- ** Tooltip options **
			TooltipSource = 1,
			TooltipCount = 1,
			TooltipTotal = 1,
			TooltipRecipeInfo = 1,
			TooltipItemID = 0,				-- display item id & item level in the tooltip (default: off)
			TooltipGatheringNode = 1,		-- display counters when mousing over a gathering node (default:  on)
			TooltipCrossFaction = 1,		-- display counters for both factions on a pve server
			TooltipMultiAccount = 1,		-- display counters for all accounts on the same realm
			
			TooltipGuildBank = 1,
			TooltipGuildBankCount = 1,		-- total count = alts + guildbank (1) or alts only (0)
			TooltipGuildBankCountPerTab = 0,	-- guild count = guild:count or guild (tab 1: x, tab2: y ..)
			
			-- ** Calendar options **
			WeekStartsMonday = 0,
			WarningDialogBox = 0,			-- use a dialog box for warnings (1), or default chat frame (0)
			DisableWarnings = 0,
			WarningType1 = "30|15|10|5|4|3|2|1",		-- for profession cooldowns
			WarningType2 = "30|15|10|5|4|3|2|1",		-- for dungeon resets
			WarningType3 = "30|15|10|5|4|3|2|1",		-- for calendar events
			WarningType4 = "30|15|10|5|4|3|2|1",		-- for item timers (like mysterious egg)
		},
}}

-- ** LDB Launcher **
LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject(addonName, {
	type = "launcher",
	icon = "Interface\\Icons\\INV_Drink_13",
	OnClick = function(clickedframe, button)
		Altoholic:ToggleUI()
	end,
})


local guildMembersVersion = {} 	-- hash table containing guild member info

-- Message types
local MSG_SEND_VERSION							= 1	-- Send Altoholic's version
local MSG_VERSION_REPLY							= 2	-- Reply

-- *** Utility functions ***
local function GuildBroadcast(messageType, ...)
	local serializedData = addon:Serialize(messageType, ...)
	addon:SendCommMessage(commPrefix, serializedData, "GUILD")
end

local function GuildWhisper(player, messageType, ...)
	if DataStore:IsGuildMemberOnline(player) then
		local serializedData = addon:Serialize(messageType, ...)
		addon:SendCommMessage(commPrefix, serializedData, "WHISPER", player)
	end
end

local function SaveVersion(sender, version)
	guildMembersVersion[sender] = version
end

-- *** Guild Comm ***
local function OnAnnounceLogin(self, guildName)
	-- when the main DataStore module sends its login info, share the guild bank last visit time across guild members
	GuildBroadcast(MSG_SEND_VERSION, addon.Version)
end

local function OnSendVersion(sender, version)
	if sender ~= UnitName("player") then								-- don't send back to self
		GuildWhisper(sender, MSG_VERSION_REPLY, addon.Version)		-- reply by sending my own version
	end
	SaveVersion(sender, version)											-- .. and save it
end

local function OnVersionReply(sender, version)
	SaveVersion(sender, version)
end

local GuildCommCallbacks = {
	[MSG_SEND_VERSION] = OnSendVersion,
	[MSG_VERSION_REPLY] = OnVersionReply,
}

function addon:OnInitialize()
	Altoholic.db = LibStub("AceDB-3.0"):New("AltoholicDB", AltoholicDB_Defaults)
	LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, options)

	addon:RegisterChatCommand("Altoholic", "ChatCommand")
	addon:RegisterChatCommand("Alto", "ChatCommand")
	
	DataStore:SetGuildCommCallbacks(commPrefix, GuildCommCallbacks)

	addon:RegisterMessage("DATASTORE_ANNOUNCELOGIN", OnAnnounceLogin)
	addon:RegisterMessage("DATASTORE_GUILD_ALTS_RECEIVED")
	
	addon:RegisterComm("AltoShare", "AccSharingHandler")
	addon:RegisterComm(commPrefix, DataStore:GetGuildCommHandler())
	
	addon:RegisterMessage("DATASTORE_BANKTAB_REQUESTED")
	addon:RegisterMessage("DATASTORE_BANKTAB_REQUEST_ACK")
	addon:RegisterMessage("DATASTORE_BANKTAB_REQUEST_REJECTED")
	addon:RegisterMessage("DATASTORE_BANKTAB_UPDATE_SUCCESS")
	addon:RegisterMessage("DATASTORE_PLAYER_EQUIPMENT_RECEIVED")
	addon:RegisterMessage("DATASTORE_GUILD_BANKTABS_UPDATED")
	addon:RegisterMessage("DATASTORE_GUILD_PROFESSION_RECEIVED")
	addon:RegisterMessage("DATASTORE_GUILD_MEMBER_OFFLINE")
	addon:RegisterMessage("DATASTORE_GUILD_MAIL_RECEIVED")
	addon:RegisterMessage("DATASTORE_GLOBAL_MAIL_EXPIRY")
end

function addon:GetGuildMemberVersion(member)
	if guildMembersVersion[member] then			-- version number of a main ?
		return guildMembersVersion[member]		-- return it immediately
	end
	
	-- check if member is an alt
	local main = DataStore:GetNameOfMain(member)
	if main and guildMembersVersion[main] then
		return guildMembersVersion[main]
	end
end

function Altoholic:ChatCommand(input)
	if not input then
		LibStub("AceConfigDialog-3.0"):Open(addonName)
	else
		LibStub("AceConfigCmd-3.0").HandleCommand(Altoholic, "Alto", "Altoholic", input)
	end
end

Altoholic.vars = {}

Altoholic.Guild = {}
Altoholic.TradeSkills = {}
Altoholic.TradeSkills.Recipes = {}
Altoholic.Tabs = {}
Altoholic.Tabs.List = {
	"Summary",
	"Characters",
	"Search",
	"GuildBank",
	"Achievements",
}

function Altoholic.Tabs:HideAll()
	for _, v in pairs(self.List) do
		_G["AltoholicTab" .. v]:Hide();
	end
end

function Altoholic.Tabs:OnClick(index)
	PanelTemplates_SetTab(AltoholicFrame, index);
	self:HideAll()
	self.current = index
	self.Columns.prefix = "AltoholicTab"..self.List[index].."_Sort"
	_G["AltoholicTab" .. self.List[index]]:Show()
end

Altoholic.Tabs.Columns = {}

function Altoholic.Tabs.Columns:Init()
	local i = 1
	local prefix = self.prefix or "AltoholicTabSummary_Sort"
	local button = _G[ prefix .. i ]
	local arrow = _G[ prefix .. i .. "Arrow"]
	
	while button do
		arrow:Hide()
		button.ascendingSort = nil		-- not sorted by default
		button:Hide()
		
		i = i + 1
		button = _G[ prefix .. i ]
		arrow = _G[ prefix .. i .. "Arrow"]
	end
	self.count = 0
	self.prefix = prefix
end

function Altoholic.Tabs.Columns:Add(title, width, func)
	local prefix = self.prefix
	self.count = self.count + 1
	local button = _G[ prefix..self.count ]

	if not title then		-- no title ? count the column, but hide it
		button:Hide()
		return
	end
	
	button:SetText(title)
	button:SetWidth(width)
	button:SetScript("OnClick", function(self)
			local prefix = Altoholic.Tabs.Columns.prefix
			local i = 1
			local arrow = _G[ prefix .. i .. "Arrow"]
			
			while arrow do		-- hide all arrows
				arrow:Hide()
				i = i + 1
				arrow = _G[ prefix .. i .. "Arrow"]
			end

			arrow = _G[ prefix .. self:GetID() .. "Arrow"]
			arrow:Show()	-- show selected arrow
			
			if not self.ascendingSort then
				self.ascendingSort = true
				arrow:SetTexCoord(0, 0.5625, 1.0, 0);		-- arrow pointing up
			else
				self.ascendingSort = nil
				arrow:SetTexCoord(0, 0.5625, 0, 1.0);		-- arrow pointing down
			end
	
			if func then
				func(self)
			end
		end)
	button:Show()
end


-- Allow ESC to close the main frame
tinsert(UISpecialFrames, "AltoholicFrame");
tinsert(UISpecialFrames, "AltoMsgBox");

-- Add herb/ore possession info to Plants/Mines, thanks to Tempus on wowace for gathering this.
Altoholic.Gathering = {

	-- Mining nodes
	[L["Adamantite Deposit"]]              = 23425, -- Adamantite Ore
	[L["Copper Vein"]]                     =  2770, -- Copper Ore
	[L["Dark Iron Deposit"]]               = 11370, -- Dark Iron Ore
	[L["Fel Iron Deposit"]]                = 23424, -- Fel Iron Ore
	[L["Gold Vein"]]                       =  2776, -- Gold Ore
	[L["Hakkari Thorium Vein"]]            = 10620, -- Thorium Ore
	[L["Iron Deposit"]]                    =  2772, -- Iron Ore
	[L["Khorium Vein"]]                    = 23426, -- Khorium Ore
	[L["Mithril Deposit"]]                 =  3858, -- Mithril Ore
	[L["Ooze Covered Gold Vein"]]          =  2776, -- Gold Ore
	[L["Ooze Covered Mithril Deposit"]]    =  3858, -- Mithril Ore
	[L["Ooze Covered Rich Thorium Vein"]]  = 10620, -- Thorium Ore
	[L["Ooze Covered Silver Vein"]]        =  2775, -- Silver Ore
	[L["Ooze Covered Thorium Vein"]]       = 10620, -- Thorium Ore
	[L["Ooze Covered Truesilver Deposit"]] =  7911, -- Truesilver Ore
	[L["Rich Adamantite Deposit"]]         = 23425, -- Adamantite Ore
	[L["Rich Thorium Vein"]]               = 10620, -- Thorium Ore
	[L["Silver Vein"]]                     =  2775, -- Silver Ore
	[L["Small Thorium Vein"]]              = 10620, -- Thorium Ore
	[L["Tin Vein"]]                        =  2771, -- Tin Ore
	[L["Truesilver Deposit"]]              =  7911, -- Truesilver Ore

	[L["Lesser Bloodstone Deposit"]]       =  4278, -- Lesser Bloodstone Ore
	[L["Incendicite Mineral Vein"]]        =  3340, -- Incendicite Ore
	[L["Indurium Mineral Vein"]]           =  5833, -- Indurium Ore
	[L["Nethercite Deposit"]]              = 32464, -- Nethercite Ore
	[L["Large Obsidian Chunk"]]				= 22203,	-- Large Obsidian Shard	Both drop on both nodes..
	[L["Small Obsidian Chunk"]]				= 22202,	-- Small Obsidian Shard
	
	-- wotlk
	["Cobalt Deposit"]							= 36909, -- Cobalt Ore
	["Rich Cobalt Deposit"]						= 36909, -- Cobalt Ore
	["Saronite Deposit"]							= 36912, -- Saronite Ore
	["Rich Saronite Deposit"]					= 36912, -- Saronite Ore
	["Titanium Vein"]								= 36910, -- Titanium Ore

	-- Herbs
	[L["Ancient Lichen"]]       = 22790,
	[L["Arthas' Tears"]]        =  8836,
	[L["Black Lotus"]]          = 13468,
	[L["Blindweed"]]            =  8839,
	[L["Bloodthistle"]]         = 22710,
	[L["Briarthorn"]]           =  2450,
	[L["Bruiseweed"]]           =  2453,
	[L["Dreamfoil"]]            = 13463,
	[L["Dreaming Glory"]]       = 22786,
	[L["Earthroot"]]            =  2449,
	[L["Fadeleaf"]]             =  3818,
	[L["Felweed"]]              = 22785,
	[L["Firebloom"]]            =  4625,
	[L["Flame Cap"]]            = 22788,
	[L["Ghost Mushroom"]]       =  8845,
	[L["Golden Sansam"]]        = 13464,
	[L["Goldthorn"]]            =  3821,
	[L["Grave Moss"]]           =  3369,
	[L["Gromsblood"]]           =  8846,
	[L["Icecap"]]               = 13467,
	[L["Khadgar's Whisker"]]    =  3358,
	[L["Kingsblood"]]           =  3356,
	[L["Liferoot"]]             =  3357,
	[L["Mageroyal"]]            =   785,
	[L["Mana Thistle"]]         = 22793,
	[L["Mountain Silversage"]]  = 13465,
	[L["Netherbloom"]]          = 22791,
	[L["Nightmare Vine"]]       = 22792,
	[L["Peacebloom"]]           =  2447,
	[L["Plaguebloom"]]          = 13466,
	[L["Purple Lotus"]]         =  8831,
	[L["Ragveil"]]              = 22787,
	[L["Silverleaf"]]           =   765,
	[L["Stranglekelp"]]         =  3820,
	[L["Sungrass"]]             =  8838,
	[L["Terocone"]]             = 22789,
	[L["Wild Steelbloom"]]      =  3355,
	[L["Wintersbite"]]          =  3819,

	[L["Glowcap"]]              = 24245,
	[L["Netherdust Bush"]]      = 32468, -- Netherdust Pollen
	[L["Sanguine Hibiscus"]]    = 24246,

	["Fel Lotus"]					= 22794,
	["Goldclover"]					= 36901,
	["Adder's Tongue"]			= 36903,
	["Tiger Lily"]					= 36904,
	["Lichbloom"]					= 36905,
	["Icethorn"]					= 36906,
	["Talandra's Rose"]			= 36907,
	["Frost Lotus"]				= 36908,
	["Firethorn"]					= 39970,
}

function Altoholic:CmdSearchBags(arg1, arg2)
	-- arg 1 is a table, no idea of what it does, investigate later, only  arg2 matters at this point
	
	if string.len(arg2) == 0 then
		DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF9A" .. L["Altoholic:|r Usage = /altoholic search <item name>"])
		return
	end
	
	if not (AltoholicFrame:IsVisible()) then
		AltoholicFrame:Show();
	end
	AltoholicFrame_SearchEditBox:SetText(strlower(arg2))
	Altoholic.Search:FindItem();
end	