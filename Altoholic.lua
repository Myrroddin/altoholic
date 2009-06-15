--[[	*** Altoholic ***
Written by : Thaoky, EU-Marécages de Zangar
--]]

local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()

local V = Altoholic.vars
Altoholic.Version = "v3.1.003c"
Altoholic.VersionNum = 301003

local WHITE		= "|cFFFFFFFF"
local RED		= "|cFFFF0000"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"
local ORANGE	= "|cFFFF7F00"
local TEAL		= "|cFF00FF9A"
local GOLD		= "|cFFFFD700"

Altoholic.ProfessionSpellID = {
	[BI["Alchemy"]] = 2259,
	[BI["Blacksmithing"]] = 3100,
	[BI["Cooking"]] = 2550,
	[BI["Enchanting"]] = 7411,
	[BI["Engineering"]] = 4036,
	[BI["First Aid"]] = 3273,
	[BI["Jewelcrafting"]] = 25229,
	[BI["Leatherworking"]] = 2108,
	[BI["Tailoring"]] = 3908,
	[L["Inscription"]] = 45357,
	[L["Skinning"]] = 8613,
	[L["Mining"]] = 2575,
	[L["Herbalism"]] = 2366,
	[BI["Fishing"]] = 7733,
}

Altoholic.ClassInfo = {
	["MAGE"] = "|cFF69CCF0",
	["WARRIOR"] = "|cFFC79C6E",
	["HUNTER"] = "|cFFABD473",
	["ROGUE"] = "|cFFFFF569",
	["WARLOCK"] = "|cFF9482CA", 
	["DRUID"] = "|cFFFF7D0A", 
	["SHAMAN"] = "|cFF2459FF",
	["PALADIN"] = "|cFFF58CBA", 
	["PRIEST"] = WHITE,
	["DEATHKNIGHT"] = "|cFFC41F3B"
}

local function Hook_LinkWrangler (frame)
	local name, link = frame:GetItem ()
	if name and link then
		Altoholic.Tooltip:Process(frame, name, link)
	end
end

local THIS_ACCOUNT = "Default"
local MSG_GUILD_ANNOUNCELOGIN		= 1
local INFO_REALM_LINE = 0
local INFO_CHARACTER_LINE = 1
local INFO_TOTAL_LINE = 2

function Altoholic:InitLocalization()
	-- this function's purpose is to initialize the text attribute of widgets created in XML.
	-- in versions prior to 3.1.003, they were initialized through global constants named XML_ALTO_???
	-- the strings stayed in memory for no reason, and could not be included in the automated localization offered by curse, hence the change of approach.
	
	AltoholicMinimapButton.tooltip = format("%s\n%s\n%s",
		"Altoholic", WHITE..L["Left-click to |cFF00FF00open"], WHITE..L["Right-click to |cFF00FF00drag"] )
	
	AltoAccountSharing_InfoButton.tooltip = format("%s|r\n%s\n%s\n\n%s",
		WHITE..L["Account Name"], 
		L["Enter an account name that will be\nused for |cFF00FF00display|r purposes only."],
		L["This name can be anything you like,\nit does |cFF00FF00NOT|r have to be the real account name."],
		L["This field |cFF00FF00cannot|r be left empty."])
	
	AltoholicFrameTab1:SetText(L["Summary"])
	AltoholicFrameTab2:SetText(L["Characters"])
	AltoholicTabSummaryMenuItem1:SetText(L["Account Summary"])
	AltoholicTabSummaryMenuItem2:SetText(L["Bag Usage"])
	AltoholicTabSummaryMenuItem4:SetText(L["Activity"])
	AltoholicTabSummaryMenuItem5:SetText(L["Guild Members"])
	AltoholicTabSummaryMenuItem6:SetText(L["Guild Skills"])
	AltoholicTabSummaryMenuItem7:SetText(L["Guild Bank Tabs"])
	AltoholicTabSummaryMenuItem8:SetText(L["Calendar"])
	AltoholicTabSummary_RequestSharing:SetText(L["Account Sharing"])
	
	AltoholicTabCharactersText1:SetText(L["Realm"])
	AltoholicTabCharactersText2:SetText(L["Character"])
	
	AltoholicTabSearch_Sort1:SetText(L["Item / Location"])
	AltoholicTabSearch_Sort2:SetText(L["Character"])
	AltoholicTabSearch_Sort3:SetText(L["Realm"])
	AltoholicTabSearchSlot:SetText(L["Equipment Slot"])
	AltoholicTabSearchLocation:SetText(L["Location"])
	
	AltoholicTabOptionsMenuItem1:SetText(L["General"])
	AltoholicTabOptionsMenuItem5:SetText(L["Tooltip"])
	AltoholicTabOptionsMenuItem6:SetText(L["Calendar"])
	
	AltoholicFramePetsText1:SetText(L["View"])
	
	AltoholicTabGuildBank_HideInTooltipText:SetText(L["Hide this guild in the tooltip"])
	
	AltoAccountSharingName:SetText(L["Account Name"])
	AltoAccountSharingText1:SetText(L["Send account sharing request to:"])
	AltoAccountSharing_UseNameText:SetText(L["Character"])
	
	AltoholicTabAchievements_NotStarted:SetText("\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t" .. L["Not started"])
	AltoholicTabAchievements_Partial:SetText("\124TInterface\\RaidFrame\\ReadyCheck-Waiting:14\124t" .. L["Started"])
	AltoholicTabAchievements_Completed:SetText("\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t" .. COMPLETE)
	
	AltoholicFrameTotals:SetText(L["Totals"])
	AltoholicFrameSearchLabel:SetText(L["Search Containers"])
	AltoholicFrame_ResetButton:SetText(L["Reset"])
	
	
	-- nil strings to save memory, since they are not used later on.
	L["Summary"] = nil
	L["Characters"] = nil
	L["Account Summary"] = nil
	L["Bag Usage"] = nil
	L["Activity"] = nil
	L["Guild Skills"] = nil
	L["Guild Bank Tabs"] = nil
	L["Calendar"] = nil
	L["Account Sharing"] = nil
	L["View"] = nil
	L["Hide this guild in the tooltip"] = nil
	L["Not started"] = nil
	L["Started"] = nil
	L["General"] = nil
	L["Tooltip"] = nil
	L["Search Containers"] = nil
	L["Equipment Slot"] = nil
	L["Location"] = nil
	L["Reset"] = nil
	L["Send account sharing request to:"] = nil
	L["Left-click to |cFF00FF00open"] = nil
	L["Right-click to |cFF00FF00drag"] = nil
	L["Enter an account name that will be\nused for |cFF00FF00display|r purposes only."] = nil
	L["This name can be anything you like,\nit does |cFF00FF00NOT|r have to be the real account name."] = nil
	L["This field |cFF00FF00cannot|r be left empty."] = nil

	if GetLocale() == "deDE" then
		-- This is a global string from wow, for some reason the original is causing problem. DO NOT copy this line in localization files
		ITEM_MOD_SPELL_POWER = "Erh\195\182ht die Zaubermacht um %d."; 
	end
end

function Altoholic:OnEnable()
	self:InitLocalization()
	self.Options:Init()
	self.Tasks:Init()
	self.Profiler:Init()
	self.Tooltip:Init()
	
	self:RegisterEvent("PLAYER_ALIVE")
	self:RegisterEvent("PLAYER_LEVEL_UP")
	self:RegisterEvent("PLAYER_MONEY")
	self:RegisterEvent("PLAYER_XP_UPDATE")
	self:RegisterEvent("PLAYER_LOGOUT")
	self:RegisterEvent("PLAYER_UPDATE_RESTING")
	self:RegisterEvent("PLAYER_GUILD_UPDATE")		-- for gkick, gquit, etc..
	self:RegisterEvent("UPDATE_INSTANCE_INFO", "UpdateRaidTimers")
	self:RegisterEvent("RAID_INSTANCE_WELCOME", "RequestUpdateRaidInfo")
	self:RegisterEvent("ZONE_CHANGED", "UpdatePlayerLocation")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "UpdatePlayerLocation")
	self:RegisterEvent("ZONE_CHANGED_INDOORS", "UpdatePlayerLocation")
	self:RegisterEvent("TIME_PLAYED_MSG")
	self:RegisterEvent("BANKFRAME_OPENED", Altoholic.Containers.OnBankOpened)
	self:RegisterEvent("GUILDBANKFRAME_OPENED", Altoholic.GuildBank.OnOpen)
	self:RegisterEvent("AUCTION_HOUSE_SHOW", Altoholic.AuctionHouse.OnShow)

	self:RegisterEvent("PLAYER_TALENT_UPDATE");
	self:RegisterEvent("MAIL_SHOW", Altoholic.Mail.OnShow)
	
	AltoholicFrameName:SetText("Altoholic |cFFFFFFFF".. Altoholic.Version .. " by |cFF69CCF0Thaoky")

	local realm = GetRealmName()
	local player = UnitName("player")
	
	self.ThisAccount = Altoholic.db.global.data[THIS_ACCOUNT]
	self.ThisRealm = self.ThisAccount[realm]
	self.ThisCharacter = self.ThisRealm.char[player]
	
	Altoholic:SetCurrentCharacter(player)
	Altoholic:SetCurrentRealm(realm)
	Altoholic:SetCurrentAccount(THIS_ACCOUNT)

	local c = Altoholic.ThisCharacter
	c.lastlogout = 0
	c.faction = UnitFactionGroup("player")

	self.Tabs.Summary:Init()
	self.Containers:Init()
	
	-- do not move this one into the frame's OnLoad
	UIDropDownMenu_Initialize(AltoholicFrameEquipmentRightClickMenu, Equipment_RightClickMenu_OnLoad, "MENU");
	
	
	RequestTimePlayed()	-- trigger a TIME_PLAYED_MSG event if playtime is unavailable for this character
	
	_G["AltoholicFrameClassesItem10"]:SetPoint("BOTTOMRIGHT", "AltoholicFrameClasses", "BOTTOMRIGHT", -15, 0);
	for j=9, 1, -1 do
		_G["AltoholicFrameClassesItem" .. j]:SetPoint("BOTTOMRIGHT", "AltoholicFrameClassesItem" .. (j + 1), "BOTTOMLEFT", -5, 0);
	end

	self.Options:RestoreToUI()

	if Altoholic.Options:Get("ShowMinimap") == 1 then
		self:MoveMinimapIcon()
		AltoholicMinimapButton:Show();
	else
		AltoholicMinimapButton:Hide();
	end
	
	self.Containers:ScanPlayerBags()		-- manually update bags 0 to 4, then register the event
	self:RegisterEvent("BAG_UPDATE", self.Containers.OnBagUpdate)
	self:RegisterEvent("UNIT_INVENTORY_CHANGED", self.Equipment.Scan)
	self:RegisterEvent("UNIT_QUEST_LOG_CHANGED", self.Quests.OnLogChanged)
	self:RegisterEvent("TRADE_SKILL_SHOW", self.TradeSkills.OnShow)
	self:RegisterEvent("COMPANION_UPDATE", self.Pets.OnUpdate)
	self:RegisterEvent("ACHIEVEMENT_EARNED");
	self:RegisterEvent("GLYPH_ADDED", self.Glyphs.Scan);
	self:RegisterEvent("GLYPH_REMOVED", self.Glyphs.Scan);
	self:RegisterEvent("GLYPH_UPDATED", self.Glyphs.Scan);
	self:RegisterEvent("LEARNED_SPELL_IN_TAB", self.Spells.Scan);
	self:RegisterEvent("FRIENDLIST_UPDATE", self.UpdateFriends);
	self:RegisterEvent("CHAT_MSG_SKILL")
	self:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")
	self:RegisterEvent("CHAT_MSG_SYSTEM");
	self:RegisterEvent("CHAT_MSG_LOOT")
	self:RegisterEvent("UNIT_PET", self.Pets.OnChange);
	
	if IsInGuild() then
		self:RegisterEvent("GUILD_ROSTER_UPDATE", self.Guild.Members.OnRosterUpdate);
	end
	
	local currentGuild = GetGuildInfo("player")
	if not currentGuild then	-- if the player is not in a guild, set the drop down to the first guild available on this realm, if any.
		for GuildName, _ in pairs(Altoholic.db.global.data[THIS_ACCOUNT][GetRealmName()].guild) do
			currentGuild = GuildName
			break	-- if there's at least one guild, let's set the right value and break immediately
		end
	end
	
	if currentGuild then	-- if the current guild or at least a guild on this realm was found..set the right values
		UIDropDownMenu_SetSelectedValue(AltoholicTabGuildBank_SelectGuild, 
				THIS_ACCOUNT .. "|" .. GetRealmName() .."|".. currentGuild )
		UIDropDownMenu_SetText(AltoholicTabGuildBank_SelectGuild, 
				GREEN .. currentGuild .. WHITE .. " (" .. GetRealmName() .. ")"	)

		Altoholic.Tabs.GuildBank:LoadGuild(THIS_ACCOUNT, GetRealmName(), currentGuild)
	end
	
	self.UnsafeItems:BuildList()
	
	-- LinkWrangler supoprt
   if LinkWrangler then
      LinkWrangler.RegisterCallback ("Altoholic",  Hook_LinkWrangler, "refresh")
   end
	self.DoInitialBroadcast = true
	self.DoMailExpiryCheck = true	

	-- create an empty frame to manager the timer via its Onupdate
	self.TimerFrame = CreateFrame("Frame", "AltoholicTimerFrame", UIParent)
	local f = self.TimerFrame
	
	f:SetWidth(1)
	f:SetHeight(1)
	f:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 1, 1)
	f:SetScript("OnUpdate", function(self, elapsed) Altoholic.Tasks:OnUpdate(elapsed) end)
	f:Show()
	
	-- temporary fix to help Bean Counter's hooking the right mail function
	self.UpdatePlayerMail = self.Mail.Scan
	
	self:ConvertCraftDB()
end

function Altoholic:OnDisable()
end

function Altoholic:ToggleUI()
	if (AltoholicFrame:IsVisible()) then
		AltoholicFrame:Hide();
	else
		AltoholicFrame:Show();
	end
end

function Altoholic:OnShow()
	self:ScanAll()
	self.Containers:ScanPlayerBags()
	
	SetPortraitTexture(AltoholicFramePortrait, "player");	

	self.Reputations:BuildView()
	self.Characters:BuildList()
	self.Characters:BuildView()
	
	if not Altoholic.Tabs.current then
		Altoholic.Tabs.current = 1
		self.Tabs.Summary:MenuItem_OnClick(1)
	end
end

function Altoholic:ConvertCraftDB()
	local done = Altoholic.Options:Get("CraftDBConversionDone")
	if done then return end
	
	-- this converts all recipes from the old format (table) to the new (string) - huge memory gain
	local spellID
	for AccountName, a in pairs(Altoholic.db.global.data) do
		for RealmName, r in pairs(a) do
			for CharacterName, c in pairs(r.char) do	-- loop through all alts, all realms, all accounts
				-- convert professions
				for ProfessionName, p in pairs(c.recipes) do			
					if p.list then
						local corruptedList
						for index, craft in pairs(p.list) do
							
							if type(craft) == "table" then		-- old type = stored as table, new type = string
								if craft.isHeader then
									if craft.name then
										p.list[index] = "0^" .. craft.name
									else
										corruptedList = true
										break
									end
								else
									spellID = Altoholic:GetSpellIDFromLink(craft.link)
									if craft.reagents then
										p.list[index] = (craft.color or 4) .. "^" .. (craft.id or "") .. "^" .. spellID .. "^" .. craft.reagents
									else
										corruptedList = true
										break
									end
								end
							end
						end
						
						if corruptedList then
							p.ScanFailed = true	-- DB corruption detected, invalidate data
						end
					end
				end
				
				-- convert pets
				for PetType, PetTable in pairs(c.pets) do
					for index, p in pairs(PetTable) do
						if type(p) == "table" then
							PetTable[index] = p.name .. "|" .. p.spellID .. "|" .. string.gsub(p.icon, "Interface\\Icons\\", "") .. "|" .. p.modelID
						end
					end
				end
			end
		end
	end
	
	Altoholic.Options:Set("CraftDBConversionDone", true)
end


Altoholic.Characters = {}

local SUMMARY_THISREALM = 1
local SUMMARY_ALLREALMS = 2
local SUMMARY_ALLACCOUNTS = 3

function Altoholic.Characters:BuildList()
	self.List = self.List or {}
	wipe(self.List)
	
	local money = 0
	local played = 0
	local levels = 0
	local realmID = 0 -- will be required for sorting purposes
	local mode = Altoholic.Options:Get("TabSummaryMode")

	-- The info table is static and contains characters of all realms on all accounts
	for AccountName, a in pairs(Altoholic.db.global.data) do
		for RealmName, _ in pairs(a) do
			local realmmoney, realmplayed, realmlevels = self:AddRealm(AccountName, RealmName, realmID)

			if mode == SUMMARY_THISREALM then
				-- if we show only this realm, then counters for other accounts or other realms are at 0
				if (AccountName ~= THIS_ACCOUNT) or (RealmName ~= GetRealmName()) then
					realmmoney = 0
					realmplayed = 0
					realmlevels = 0
				end
			elseif mode == SUMMARY_ALLREALMS then
				-- All realms, but this account only
				if (AccountName ~= THIS_ACCOUNT) then
					realmmoney = 0
					realmplayed = 0
					realmlevels = 0
				end
			end

			money = money + realmmoney
			played = played + realmplayed
			levels = levels + realmlevels
			
			realmID = realmID + 1
		end
	end
	
	AltoholicFrameTotalLv:SetText(WHITE .. levels .. " |rLv")
	AltoholicFrameTotalGold:SetText(floor( money / 10000 ) .. "|cFFFFD700g")
	AltoholicFrameTotalPlayed:SetText(floor(played / 86400) .. "|cFFFFD700d")
end

function Altoholic.Characters:AddRealm(AccountName, RealmName, realmID)

	local comm = Altoholic.Comm.Sharing
	if comm.SharingInProgress then
		if comm.account == AccountName and RealmName == GetRealmName() then
			-- if we're trying to add the account+realm we're currently copying, then don't add it now.
			return 0, 0, 0
		end
	end

	local realmmoney = 0
	local realmplayed = 0
	local realmlevels = 0
	local realmBagSlots = 0
	local realmFreeBagSlots = 0
	local realmBankSlots = 0
	local realmFreeBankSlots = 0
	
	local SkillsCache = { {name = "", rank = 0}, {name = "", rank = 0} }
	
	table.insert(self.List, { linetype = INFO_REALM_LINE + (realmID*3),
		isCollapsed = false,
		account = AccountName,
		realm = RealmName
	} )
	
	local parentRealm = #self.List
	local r = Altoholic:GetRealmTable(RealmName, AccountName)
	
	for CharacterName, c in pairs(r.char) do
		SkillsCache[1].name = ""
		SkillsCache[1].rank = 0
		SkillsCache[1].spellID = nil
		SkillsCache[2].name = ""
		SkillsCache[2].rank = 0
		SkillsCache[2].spellID = nil

		local i = 1
		for SkillName, s in pairs(c.skill[L["Professions"]]) do
			SkillsCache[i].name = SkillName
			SkillsCache[i].rank = Altoholic.TradeSkills:GetRank(s)
			SkillsCache[i].spellID = Altoholic:GetProfessionSpellID(SkillName)
			i = i + 1
			
			if i > 2 then		-- it seems that under certain conditions, the loop continues after 2 professions.., so break
				break
			end
		end
		
		local sk = c.skill[L["Secondary Skills"]]
		
		table.insert(self.List, { linetype = INFO_CHARACTER_LINE + (realmID*3),
			name = CharacterName,
			parentID = parentRealm,
			skillName1 = SkillsCache[1].name,
			skillRank1 = SkillsCache[1].rank,
			spellID1 = SkillsCache[1].spellID,
			skillName2 = SkillsCache[2].name,
			skillRank2 = SkillsCache[2].rank,
			spellID2 = SkillsCache[2].spellID,
			cooking = Altoholic.TradeSkills:GetRank( sk[BI["Cooking"]] ),
			firstaid = Altoholic.TradeSkills:GetRank( sk[BI["First Aid"]] ),
			fishing = Altoholic.TradeSkills:GetRank( sk[BI["Fishing"]] ),
			riding = Altoholic.TradeSkills:GetRank( sk[L["Riding"]] ),
		} )

		realmlevels = realmlevels + c.level
		realmmoney = realmmoney + c.money
		realmplayed = realmplayed + c.played
		realmBagSlots = realmBagSlots + c.numBagSlots
		realmFreeBagSlots = realmFreeBagSlots + c.numFreeBagSlots
		realmBankSlots = realmBankSlots + c.numBankSlots
		realmFreeBankSlots = realmFreeBankSlots + c.numFreeBankSlots
	end		-- end char

	table.insert(self.List, { linetype = INFO_TOTAL_LINE + (realmID*3),
		parentID = parentRealm,
		level = WHITE .. realmlevels,
		money = Altoholic:GetMoneyString(realmmoney, WHITE),
		played = Altoholic:GetTimeString(realmplayed),
		bagSlots = realmBagSlots,
		freeBagSlots = realmFreeBagSlots,
		bankSlots = realmBankSlots,
		freeBankSlots = realmFreeBankSlots
	} )

	return realmmoney, realmplayed, realmlevels
end

function Altoholic.Characters:BuildView()
	-- The character info index is a small table that basically indexes character info
	-- ex: character info contains data for 4 realms on two accounts, but the index only cares about the summary tab filter,
	-- and indexes just one realm, or one account
	self.view = self.view or {}
	wipe(self.view)
	
	local mode = Altoholic.Options:Get("TabSummaryMode")
	
	if mode == SUMMARY_THISREALM then
		self:AddRealmView(THIS_ACCOUNT, GetRealmName())
	elseif mode == SUMMARY_ALLREALMS then
		for RealmName, _ in pairs(Altoholic.db.global.data[THIS_ACCOUNT]) do
			self:AddRealmView(THIS_ACCOUNT, RealmName)
		end
	elseif mode == SUMMARY_ALLACCOUNTS then
		for AccountName, a in pairs(Altoholic.db.global.data) do
			for RealmName, _ in pairs(a) do
				self:AddRealmView(AccountName, RealmName)
			end
		end
	end
end

function Altoholic.Characters:AddRealmView(AccountName, RealmName)
	for line, s in pairs(self.List) do
		if mod(s.linetype, 3) == INFO_REALM_LINE then
			if (s.account == AccountName) and (s.realm == RealmName) then
				-- insert index to current line (INFO_REALM_LINE)
				table.insert(self.view, line)
				line = line + 1

				-- insert index to the rest of the realm 
				local linetype = mod(self.List[line].linetype, 3)
				while (linetype ~= INFO_REALM_LINE) do
					table.insert(self.view, line)
					line = line + 1
					if line > #self.List then
						return
					end
					linetype = mod(self.List[line].linetype, 3)
				end
				return
			end
		end
	end
end

local function SortByName(a, b, ascending)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by field xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end
		
		if ascending then
			return a.name < b.name
		else
			return a.name > b.name
		end
	end
end

local function SortByXP(a, b, ascending)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by field xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end
		-- same linetype implies same account & same realm, so r could refer to either a or b
		local r = Altoholic.db.global.data[a.account][a.realm]
		local charA = r.char[a.name]
		local charB = r.char[b.name]
		
		if ascending then
			return (charA.xp / charA.xpmax) < (charB.xp / charB.xpmax)
		else
			return (charA.xp / charA.xpmax) > (charB.xp / charB.xpmax)
		end
	end
end

local function SortByRestXP(a, b, ascending)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by field xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end
		-- same linetype implies same account & same realm, so r could refer to either a or b
		local r = Altoholic.db.global.data[a.account][a.realm]
		local charA = r.char[a.name]
		local charB = r.char[b.name]
		
		local restXPA, restXPB
		
		if charA.level == MAX_PLAYER_LEVEL then
			restXPA = 0
		else
			restXPA = select(2, Altoholic:GetRestedXP(charA.xpmax, charA.restxp, charA.lastlogout, charA.isResting))
		end
		
		if charB.level == MAX_PLAYER_LEVEL then
			restXPB = 0
		else
			restXPB = select(2, Altoholic:GetRestedXP(charB.xpmax, charB.restxp, charB.lastlogout, charB.isResting))
		end
		
		if ascending then
			return restXPA < restXPB
		else
			return restXPA > restXPB
		end
	end
end

local function SortByTableSize(a, b, field, ascending)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by field xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end
		
		-- same linetype implies same account & same realm, so r could refer to either a or b
		local r = Altoholic.db.global.data[a.account][a.realm]
		local tableA = r.char[a.name][field]
		local tableB = r.char[b.name][field]
		
		if ascending then
			return #tableA < #tableB
		else
			return #tableA > #tableB
		end
	end
end

local function SortByDelay(a, b, field, ascending)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by field xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end
		
		-- same linetype implies same account & same realm, so r could refer to either a or b
		local r = Altoholic.db.global.data[a.account][a.realm]
		local delayA = r.char[a.name][field]
		if delayA ~= 0 then					-- do this because "online" means there's no delay, so leave it at zero
			delayA = time() - delayA
		end
		local delayB = r.char[b.name][field]
		if delayB ~= 0 then
			delayB = time() - delayB
		end		
		
		if ascending then
			return delayA < delayB
		else
			return delayA > delayB
		end
	end
end

local function SortByPrimarySkill(a, b, skillName, ascending)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by field xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end
		-- same linetype implies same account & same realm, so r could refer to either a or b
		local r = Altoholic.db.global.data[a.account][a.realm]
		local charA = r.char[a.name]
		local charB = r.char[b.name]
		
		local skillA = Altoholic.TradeSkills:GetRank( charA.skill[L["Professions"]][a[skillName]] )
		local skillB = Altoholic.TradeSkills:GetRank( charB.skill[L["Professions"]][b[skillName]] )
		
		if ascending then
			return skillA < skillB
		else
			return skillA > skillB
		end
	end
end

local function SortBySecondarySkill(a, b, skillName, ascending)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by field xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end
		-- same linetype implies same account & same realm, so r could refer to either a or b
		local r = Altoholic.db.global.data[a.account][a.realm]
		local charA = r.char[a.name]
		local charB = r.char[b.name]
		
		local skillA = Altoholic.TradeSkills:GetRank( charA.skill[L["Secondary Skills"]][skillName] )
		local skillB = Altoholic.TradeSkills:GetRank( charB.skill[L["Secondary Skills"]][skillName] )
		
		if ascending then
			return skillA < skillB
		else
			return skillA > skillB
		end
	end
end

local function SortByField(a, b, field, ascending)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by field xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end
		
		-- same linetype implies same account & same realm, so r could refer to either a or b
		local r = Altoholic.db.global.data[a.account][a.realm]
		local charA = r.char[a.name]
		local charB = r.char[b.name]
		
		if ascending then
			return charA[field] < charB[field]
		else
			return charA[field] > charB[field]
		end
	end
end

function Altoholic.Characters:Sort(self, field)
	-- Because the CharacterInfo table contains parentID's to quickly find realm & account for each character,
	-- it is necessary to keep the indexes of the parent rows unchanged, however, lua does not guarantee this, so 
	-- each INFO_CHARACTER_LINE will be enriched before the sort, and cleaned after it.
	
	local ascending = self.ascendingSort
	local self = Altoholic.Characters
	
	local account, realm
	for _, s in pairs(self.List) do
		local lineType = mod(s.linetype, 3)
		
		if lineType == INFO_REALM_LINE then
			account = s.account
			realm = s.realm
		elseif lineType == INFO_CHARACTER_LINE then
			s.account = account
			s.realm = realm
		end
	end
		
	if field == "name" then
		table.sort(self.List, function(a, b) return SortByName(a, b, ascending)	end)
	elseif field == "xp" then
		table.sort(self.List, function(a, b) return SortByXP(a, b, ascending) end)
	elseif field == "restxp" then
		table.sort(self.List, function(a, b) return SortByRestXP(a, b, ascending) end)
	elseif (field == "mail") or (field == "auctions") or (field == "bids") then
		table.sort(self.List, function(a, b) return SortByTableSize(a, b, field, ascending)	end)
	elseif (field == "lastmailcheck") or (field == "lastAHcheck") or (field == "lastlogout") then
		table.sort(self.List, function(a, b) return SortByDelay(a, b, field, ascending) end)
		
	-- Primary Skill
	elseif (field == "skillName1") or (field == "skillName2") then
		table.sort(self.List, function(a, b) return SortByPrimarySkill(a, b, field, ascending)
			end)
	-- Secondary Skill
	elseif (field == BI["Cooking"]) or (field == BI["First Aid"]) or 
			(field == BI["Fishing"]) or (field == L["Riding"]) then
		table.sort(self.List, function(a, b) return SortBySecondarySkill(a, b, field, ascending) end)
	else
		table.sort(self.List, function(a, b) return SortByField(a, b, field, ascending) end)
	end
	
	for _, s in pairs(self.List) do
		local lineType = mod(s.linetype, 3)
		
		if lineType == INFO_CHARACTER_LINE then
			s.account = nil		-- clean up the additional info added just for the sort
			s.realm = nil
		end
	end

	Altoholic.Tabs.Summary:Refresh()
end

function Altoholic.Characters:Get(n)
	return self.List[n]
end

function Altoholic.Characters:GetView()
	return self.view
end

function Altoholic.Characters:GetNum()
	return #self.List or 0
end

function Altoholic.Characters:GetInfo(line)
	-- with the line number in the self.List table, return the realm & account based on the parent id of this line
	local c = self.List[line]
	local p = self.List[ c.parentID ]
	return c.name, p.realm, p.account
end

function Altoholic.Characters:GetInfoLineNum(charName, realm, account)
	-- with the name of a character, returns the line number in the self.List table
	-- This prevents from saving the character name, realm and account in the search results table.

	for k, v in pairs(self.List) do
		if mod(v.linetype,3) == INFO_CHARACTER_LINE then
			local s = self.List[ v.parentID ] 
			if v.name == charName and s.account == account and s.realm == realm then 
				return k
			end
		end
	end
end


function Altoholic:SendPublicInfo(msgType, player, guildName)

	guildName = guildName or GetGuildInfo("player")
	
	local c = Altoholic.ThisCharacter
	local t = {
		name = UnitName("player"),					-- can be removed in a future release (like 4.0)
		level = c.level,								-- can be removed
		averageItemLvl = c.averageItemLvl,
		class = c.class,								-- can be removed
		englishClass = c.englishClass,			-- can be removed
		version = Altoholic.Version
	}
	
	local r = Altoholic.ThisRealm
	local SkillsCache = { {}, {}, {} }	-- 3 tables for prof 1, 2, cooking
	
	t.skills = {}
	for CharacterName, charTable in pairs(r.char) do
		-- broadcast the skills of all chars of the same realm, same guild
		if c.guildName and charTable.guildName then
			if c.guildName == charTable.guildName then
				for i = 1, 3 do 
					SkillsCache[i].link = nil
				end
				
				local i = 1
				for SkillName, s in pairs(charTable.skill[L["Professions"]]) do
					-- if there's a full link for this profession, use it
					if charTable.recipes[SkillName].FullLink then
						SkillsCache[i].link = charTable.recipes[SkillName].FullLink
					else
						SkillsCache[i].link = SkillName
					end
					i = i + 1
				end

				if charTable.recipes[BI["Cooking"]].FullLink then
					SkillsCache[3].link = charTable.recipes[BI["Cooking"]].FullLink
				end
				
				table.insert(t.skills, {
					name = CharacterName,
					level = charTable.level,							-- can be removed
					class = charTable.class,							-- can be removed
					englishClass = charTable.englishClass,			-- can be removed
					averageItemLvl = charTable.averageItemLvl,
					prof1link = SkillsCache[1].link,
					prof2link = SkillsCache[2].link,
					cookinglink = SkillsCache[3].link,
				})
			end
		end
	end
	
	-- GetGuildInfo("player") may not yet return a correct value at this point, so get it from the player table
	if r.guild[guildName] then		-- if faction is not nil, there's a known guild
		t.guildbank = {}
		
		for i=1, 6 do
			local tab = r.guild[guildName].bank[i]
		
			if tab.ClientDate then			-- if there's a client date, the tab can be sent
				table.insert(t.guildbank, {
					name = tab.name,
					ClientDate = tab.ClientDate,
					ClientHour = tab.ClientHour,
					ClientMinute = tab.ClientMinute,
					ServerHour = tab.ServerHour,
					ServerMinute = tab.ServerMinute
				})
			end
		end
	end
	
	if msgType == MSG_GUILD_ANNOUNCELOGIN then
		self.Comm.Guild:Broadcast(MSG_GUILD_ANNOUNCELOGIN, t)
	else
		self.Comm.Guild:Whisper(player, msgType, t)
	end
end

function Altoholic:ScanAll()

	self:PLAYER_XP_UPDATE()
	self:PLAYER_UPDATE_RESTING()
	self:PLAYER_GUILD_UPDATE()
	self.Talents:Scan()
	self.Spells:Scan()
	self:UpdatePlayerSkills()
	self.Equipment:Scan()
	self:PLAYER_MONEY()
	self.Reputations:Scan()
	self.Quests:Scan()
	self:UpdatePVPStats()
	self.Pets:Scan("CRITTER")
	self.Pets:Scan("MOUNT")
	self:UpdateTokens()
	self.Glyphs:Scan()
		-- ** updates up to here take roughly 2ms altogether **
end

function Altoholic:UpdatePlayerSkills()
	local c = Altoholic.ThisCharacter
	
	if not c then return end

	for i = GetNumSkillLines(), 1, -1 do		-- 1st pass, expand all categories
		local _, isHeader = GetSkillLineInfo(i)
		if isHeader then
			ExpandSkillHeader(i)
		end
	end

	-- local category
	for i = 1, GetNumSkillLines() do
		local skillName, isHeader, _, skillRank, _, _, skillMaxRank = GetSkillLineInfo(i)
		if isHeader then
			category = skillName
		else
			if category and skillName then
				c.skill[category][skillName] = skillRank .. "|" .. skillMaxRank
				if category == L["Professions"] or category == L["Secondary Skills"] then
					-- should be nil anyway for fishing, mining, etc..
					local newLink = select(2, GetSpellLink(skillName))
					if newLink then		-- sometimes a nil value may be returned, so keep the old one if nil
						c.recipes[skillName].FullLink = newLink
					end
				end
			end
		end
	end
end

function Altoholic:UpdateStats()
	local c = Altoholic.ThisCharacter
	if not c then return end
	
	c.Stats["HealthMax"] = UnitHealthMax("player")
	-- info on power types here : http://www.wowwiki.com/API_UnitPowerType
	c.Stats["MaxPower"] = UnitPowerType("player") .. "|" .. UnitPowerMax("player")
	
	local t = {}
	-- *** resistances  ***
	for i = 1, 6 do
		t[i] = UnitResistance("player", i)
		-- base, total, bonus, minus = UnitResistance(unitId [, resistanceIndex])
		-- base = base
		-- total = total after all modifiers
		-- bonus = positive modif total
		-- minus = negative ...
	end
	c.Stats["Resistances"] = table.concat(t, "|")	--	["Resistances"] = "holy | fire | nature | frost | shadow | arcane"

	-- *** base stats ***
	for i = 1, 5 do
		t[i] = UnitStat("player", i)
		-- stat, effectiveStat, posBuff, negBuff = UnitStat("player", statIndex);
	end
	t[6] = UnitArmor("player")
	c.Stats["Base"] = table.concat(t, "|")	--	["Base"] = "strength | agility | stamina | intellect | spirit | armor"
	
	-- *** melee stats ***
	local minDmg, maxDmg = UnitDamage("player")
	t[1] = floor(minDmg) .."-" ..ceil(maxDmg)				-- Damage "215-337"
	t[2] = UnitAttackSpeed("player")
	t[3] = UnitAttackPower("player")
	t[4] = GetCombatRating(CR_HIT_MELEE)
	t[5] = GetCritChance()
	t[6] = GetExpertise()
	c.Stats["Melee"] = table.concat(t, "|")	--	["Melee"] = "Damage | Speed | Power | Hit rating | Crit chance | Expertise"
	
	-- *** ranged stats ***
	local speed
	speed, minDmg, maxDmg = UnitRangedDamage("player")
	t[1] = floor(minDmg) .."-" ..ceil(maxDmg)
	t[2] = speed
	t[3] = UnitRangedAttackPower("player")
	t[4] = GetCombatRating(CR_HIT_RANGED)
	t[5] = GetRangedCritChance()
	t[6] = nil
	c.Stats["Ranged"] = table.concat(t, "|")	--	["Ranged"] = "Damage | Speed | Power | Hit rating | Crit chance"
	
	-- *** spell stats ***
	t[1] = GetSpellBonusDamage(2)			-- 2, since 1 = physical damage
	t[2] = GetSpellBonusHealing()
	t[3] = GetCombatRating(CR_HIT_SPELL)
	t[4] = GetSpellCritChance(2)
	t[5] = GetCombatRating(CR_HASTE_SPELL)
	t[6] = floor(GetManaRegen() * 5.0)
	c.Stats["Spell"] = table.concat(t, "|")	--	["Spell"] = "+Damage | +Healing | Hit | Crit chance | Haste | Mana Regen"
	
	-- *** defenses stats ***
	t[1] = UnitArmor("player")
	t[2] = UnitDefense("player")
	t[3] = GetDodgeChance()
	t[4] = GetParryChance()
	t[5] = GetBlockChance()
	local minResilience = min(GetCombatRating(CR_CRIT_TAKEN_MELEE), GetCombatRating(CR_CRIT_TAKEN_RANGED))
	t[6] = min(minResilience, GetCombatRating(CR_CRIT_TAKEN_SPELL))
	c.Stats["Defense"] = table.concat(t, "|")	--	["Defense"] = "Armor | Defense | Dodge | Parry | Block | Resilience"

	-- *** PVP Stats ***
	t[1], t[2] = GetPVPLifetimeStats()
	t[3] = GetArenaCurrency()
	t[4] = GetHonorCurrency()
	t[5] = nil
	t[6] = nil
	c.Stats["PVP"] = table.concat(t, "|")	--	["PVP"] = "honorable kills | dishonorable kills | arena points | honor points"
	
	-- *** Arena Teams ***
	for i = 1, MAX_ARENA_TEAMS do
		local teamName, teamSize = GetArenaTeam(i)
		if teamName then
			c.Stats["Arena"..teamSize] = table.concat({ GetArenaTeam(i) }, "|")
			-- more info here : http://www.wowwiki.com/API_GetArenaTeam
		end
	end
end

function Altoholic:UpdateFriends()
	local c = Altoholic.ThisCharacter
	wipe(c.Friends)
	
	for i = 1, GetNumFriends() do
	   local name = GetFriendInfo(i);
	   table.insert(c.Friends, name)
	end
end

function Altoholic:UpdatePVPStats()
	-- to do: remove this function, data is now in c.Stats["PVP"]
	-- remove it when the stats pane will be implemented, and get rid of this info in the tooltip.
	local c = Altoholic.ThisCharacter
	
	c.pvp_hk, c.pvp_dk = GetPVPLifetimeStats()
	c.pvp_ArenaPoints = GetArenaCurrency()
	c.pvp_HonorPoints = GetHonorCurrency()
end

Altoholic.Spells = {}

function Altoholic.Spells:Scan()
	local c = Altoholic.ThisCharacter
	c.coldWeatherFlying = nil		-- clear this, was saved in an earlier version of the db.
	wipe(c.Spells)

	local name, offset, numSpells
	local spell, rank, link, spellID

	for tabID = 1, GetNumSpellTabs() do
		name, _, offset, numSpells = GetSpellTabInfo(tabID);
		if name then
			c.Spells[#c.Spells+1] = "0|" .. name		-- ex: "0|Arcane", 
			for s = offset + 1, offset + numSpells do
			   spell, rank = GetSpellName(s, BOOKTYPE_SPELL);
			   if spell and rank then
					link = GetSpellLink(spell)
					if link then
						spellID = tonumber(link:match("spell:(%d+)")) 
						c.Spells[#c.Spells+1] = spellID .. "|" .. rank		-- ex: "43017|Rank 1",
					end
				end
			end		
		end
	end
end

function Altoholic.Spells:IsKnownByChar(char, spellID)
	for _, v in pairs(char.Spells) do
		local id = strsplit("|", v)
		if tonumber(id) == spellID then
			return true
		end
	end
end

function Altoholic:UpdateRaidTimers()	
	local c = Altoholic.ThisCharacter
	
	wipe(c.SavedInstance)
	
	for i=1, GetNumSavedInstances() do
		local instanceName, instanceID, instanceReset, difficulty = GetSavedInstanceInfo(i)
		
		if difficulty > 1 then
			instanceName = instanceName .. L[" (Heroic)"]
		end
		
		c.SavedInstance[instanceName.. "|" .. instanceID ] =  instanceReset .. "|" .. time()
	end
end

function Altoholic:UpdateTokens()
	
	for i = GetCurrencyListSize(), 1, -1 do		-- 1st pass, expand all headers (from last to first), otherwise data can't be collected
		local _, isHeader, isExpanded = GetCurrencyListInfo(i);
		if isHeader and not isExpanded then
			ExpandCurrencyList(i, 1)
		end
	end
	
	local r = Altoholic.ThisRealm
	
	for i = 1, GetCurrencyListSize() do
		local name, isHeader, _, _, _, count = GetCurrencyListInfo(i);
		count = (count or 0)
		if (name) and (not isHeader) and (count > 0) then	-- don't track if it's a header or if count = 0
			r.tokens[name][UnitName("player")] = count
		end
	end
end


-- *** DB functions ***

function Altoholic:GetCharacterTable(charName, realm, account)
	-- Usage: 
	-- 	local c = Altoholic:GetCharacterTable(char, realm, account)
	--	all 3 parameters default to current player, realm or account
	-- use this for features that have to work regardless of an alt's location (any realm, any account)
	charName = charName or Altoholic.CurrentAlt
	realm = realm or Altoholic.CurrentRealm
	account = account or Altoholic.CurrentAccount
	
	return Altoholic.db.global.data[account][realm].char[charName]
end

function Altoholic:GetCharacterTableByLine(line)
	-- shortcut to get the right character table based on the line number in the info table.
	
	local charName, realm, account = Altoholic.Characters:GetInfo(line)
	return Altoholic.db.global.data[account][realm].char[charName]
end

function Altoholic:GetRealmTable(realm, account)
	-- Usage: 
	-- 	local c = Altoholic:GetRealmTable(char, realm, account)
	--	both parameters default to current realm or account
	realm = realm or Altoholic.CurrentRealm
	account = account or Altoholic.CurrentAccount
	
	return Altoholic.db.global.data[account][realm]
end

function Altoholic:GetRealmTableByLine(line)
	-- shortcut to get the right realm table based on the line number in the info table.

	local _, realm, account = Altoholic.Characters:GetInfo(line)
	return Altoholic.db.global.data[account][realm]
end

function Altoholic:GetThisGuild()
	return Altoholic.db.global.data[THIS_ACCOUNT][GetRealmName()].guild[GetGuildInfo("player")]
end

function Altoholic:GetReferenceTable()
	return Altoholic.db.global.reference
end

function Altoholic:GetClassReferenceTable(class)
	return Altoholic.db.global.reference[class]
end

function Altoholic:GetCurrentCharacter()
	return self.CurrentAlt, self.CurrentRealm, self.CurrentAccount
end

function Altoholic:SetCurrentCharacter(charName, realm, account)
	self.CurrentAlt = charName
	if realm then
		Altoholic:SetCurrentRealm(realm)
	end
	if account then
		Altoholic:SetCurrentAccount(account)
	end
end

function Altoholic:GetCurrentRealm()
	return self.CurrentRealm
end

function Altoholic:SetCurrentRealm(name)
	self.CurrentRealm = name
end

function Altoholic:GetCurrentAccount()
	return self.CurrentAccount
end

function Altoholic:SetCurrentAccount(name)
	self.CurrentAccount = name
end

function Altoholic:GetProfessions(charName, realm, account)
	-- return the two main professions of a character
	-- either prof1, prof2
	-- or prof1, nil
	-- or nil, nil
	local c = Altoholic:GetCharacterTable(charName, realm, account)
	
	local prof1, prof2
	for SkillName, _ in pairs(c.skill[L["Professions"]]) do
		if not prof1 then
			prof1 = SkillName
		elseif not prof2 then
			prof2 = SkillName
		end
	end
	return prof1, prof2
end

function Altoholic:IsProfessionKnown(profession, charName, realm, account)
	-- does an alt know this profession or not ?
	local c = Altoholic:GetCharacterTable(charName, realm, account)
	local professionType

	if (profession == BI["Cooking"]) or (profession == BI["First Aid"]) or (profession == BI["Fishing"]) then
		professionType = L["Secondary Skills"] 
	else
		professionType = L["Professions"]
	end
	
	if type(c.skill[professionType][profession]) == "nil" then
		return nil
	else
		return true
	end
end


-- *** Utility functions ***
function Altoholic:ClearScrollFrame(name, entry, lines, height)
	for i=1, lines do					-- Hides all entries of the scrollframe, and updates it accordingly
		_G[ entry..i ]:Hide()
	end
	FauxScrollFrame_Update( name, lines, lines, height);
end

function Altoholic:Print(message, color)
	color = color or WHITE
	print(format("%sAltoholic: %s%s", TEAL, color, message))
end

function Altoholic:Item_OnEnter(frame)
	if not frame.id then return end
	
	GameTooltip:SetOwner(frame, "ANCHOR_LEFT");
	frame.link = frame.link or select(2, GetItemInfo(frame.id) )
	
	if frame.link then
		GameTooltip:SetHyperlink(frame.link);
	else
		GameTooltip:AddLine(L["Unknown link, please relog this character"],1,1,1);
	end
	GameTooltip:Show();
end

function Altoholic:Item_OnClick(frame, button)
	if not frame.id then return end
	
	if not frame.link then
		frame.link = select(2, GetItemInfo(frame.id) )
	end
	if not frame.link then return end		-- still not valid ? exit
	
	if ( button == "LeftButton" ) and ( IsControlKeyDown() ) then
		DressUpItemLink(frame.link);
	elseif ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
		if ( ChatFrameEditBox:IsShown() ) then
			ChatFrameEditBox:Insert(frame.link);
		else
			AltoholicFrame_SearchEditBox:SetText(GetItemInfo(frame.link))
		end
	end
end

function Altoholic:SetItemButtonTexture(button, texture, width, height)
	-- wrapper for SetItemButtonTexture from ItemButtonTemplate.lua
	width = width or 36
	height = height or 36

	local itemTexture = _G[button.."IconTexture"]
	
	itemTexture:SetWidth(36);
	itemTexture:SetHeight(36);
	itemTexture:SetAllPoints(_G[button]);
	
	SetItemButtonTexture(_G[button], texture)
end

function Altoholic:TextureToFontstring(name, width, height)
	return format("|T%s:%s:%s|t", name, width, height)
end

function Altoholic:GetSpellIcon(spellID)
	return select(3, GetSpellInfo(spellID))
end

function Altoholic:GetIDFromLink(link)
	if link then
		return tonumber(link:match("item:(%d+)"))
	end
end

function Altoholic:GetProfessionSpellID(name)
	return Altoholic.ProfessionSpellID[name]
end

function Altoholic:GetSpellIDFromLink(link)
	return tonumber(link:match("enchant:(%d+)"))
end

function Altoholic:GetSpellIDFromRecipeLink(link)
	-- returns nil if recipe id is not in the DB, returns the spellID otherwise
	local recipeID = self:GetIDFromLink(link)
	return self.RecipeDB[recipeID]
end

function Altoholic:GetCompanionSpellID(itemID)
	-- returns nil if  id is not in the DB, returns the spellID otherwise
	return Altoholic.Pets.CompanionToSpellID[itemID]
end

function Altoholic:GetMountSpellID(itemID)
	-- returns nil if  id is not in the DB, returns the spellID otherwise
	return Altoholic.Pets.MountToSpellID[itemID]
end

function Altoholic:GetCraftFromRecipe(link)
	-- get the craft name from the itemlink (strsplit on | to get the 4th value, then split again on ":" )
	local recipeName = select(4, strsplit("|", link))
	local craftName

	-- try to determine if it's a transmute (has 2 colons in the string --> Alchemy: Transmute: blablabla)
	local pos = string.find(recipeName, L["Transmute"])
	if pos then	-- it's a transmute
		return string.sub(recipeName, pos, -2)
	else
		craftName = select(2, strsplit(":", recipeName))
	end
	
	if craftName == nil then		-- will be nil for enchants
		return string.sub(recipeName, 3, -2)		-- ex: "Enchant Weapon - Striking"
	end
	
	return string.sub(craftName, 2, -2)	-- at this point, get rid of the leading space and trailing square bracket
end

function Altoholic:GetEnchantInfo(link)
	local _, _, itemString = strsplit("|", link)
	local _, itemID, enchantId, jewelId1, jewelId2, jewelId3, 
					jewelId4, suffixId = strsplit(":", itemString)

	local isEnchanted = false
	-- note: don't try to replace this code with something like : tonumber(x) or tonumber(y) etc..conversions make it slower than what's below
	
	for i=1, 6 do	-- parse all arguments
		-- if not nil and differs from "0" .. item is enchanted
		if select(i, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId) and
			select(i, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId) ~= "0" then
			
			isEnchanted = true
			break
		end
	end
	
	return isEnchanted, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId
end

function Altoholic:GetMoneyString(copper, color)
	color = color or "|cFFFFD700"

	local gold = floor( copper / 10000 );
	copper = mod(copper, 10000)
	local silver = floor( copper / 100 );
	copper = mod(copper, 100)
	
	-- use this later, when it will be possible to use texcoords in a fontstring
	--DEFAULT_CHAT_FRAME:AddMessage("|TInterface\\MoneyFrame\\UI-MoneyIcons:30|t")
	
	return color .. gold .. "|cFFFFD700g " .. color .. silver .. "|cFFC7C7CFs " .. color .. copper .. "|cFFEDA55Fc"
end

function Altoholic:GetTimeString(seconds)
	local days = floor(seconds / 86400);				-- TotalTime is expressed in seconds
	seconds = mod(seconds, 86400)
	local hours = floor(seconds / 3600);
	seconds = mod(seconds, 3600)
	local minutes = floor(seconds / 60);
	seconds = mod(seconds, 60)
	
	local c1 = WHITE
	local c2 = "|r"

	return c1 .. days .. c2 .. "d " .. c1 .. hours .. c2 .. "h " .. c1 .. minutes .. c2 .. "m"
end

function Altoholic:ColourFaction(faction)
	if faction == "Alliance" then
		return "|cFF2459FF" .. FACTION_ALLIANCE
	else
		return "|cFFFF0000" .. FACTION_HORDE
	end
end

function Altoholic:GetFactionColour(faction)
	if faction == "Alliance" then
		return "|cFF2459FF"
	else
		return "|cFFFF0000"
	end
end

function Altoholic:GetClassColor(class)
	-- parameter should be the english class, as in :
	-- c.class, c.englishClass = UnitClass("player")

	return Altoholic.ClassInfo[class] or WHITE
end

function Altoholic:GetDelayInDays(delay)
	return floor((time() - delay) / 86400)
end

function Altoholic:FormatDelay(timeStamp)
	-- timeStamp = value when time() was last called for a given variable (ex: last time the mailbox was checked)
	if timeStamp == 0 then
		return YELLOW .. "N/A"
	end
	
	local seconds = (time() - timeStamp)
	
	-- 86400 seconds per day
	-- assuming 30 days / month = 2.592.000 seconds
	-- assuming 365 days / year = 31.536.000 seconds
	-- in the absence of possibility to track real dates, these approximations will have to do the trick, as it's not possible at this point to determine the number of days in a month, or in a year.

	local year = floor(seconds / 31536000);
	seconds = mod(seconds, 31536000)

	local month = floor(seconds / 2592000);
	seconds = mod(seconds, 2592000)

	local day = floor(seconds / 86400);
	seconds = mod(seconds, 86400)

	local hour = floor(seconds / 3600);
	seconds = mod(seconds, 3600)

	-- note: RecentTimeDate is not a direct API function, it's in UIParent.lua
	return RecentTimeDate(year, month, day, hour)
end

function Altoholic:GetRestedXP(maxXP, restXP, logout, isResting)
	-- get the known rate of rest xp (the one saved at last logout) + the rate represented by the elapsed time since last logout
	-- (elapsed time / 3600) * 0.625 * (2/3)  simplifies to elapsed time / 8640
	-- 0.625 comes from 8 hours rested = 5% of a level, *2/3 because 100% rested = 150% of xp (1.5 level)
	local rate = self:GetRestXPRate(maxXP, restXP)
	
	if logout ~= 0 then		-- time since last logout, 0 for current char, <> for all others
		if isResting then
			rate = rate + ((time() - logout) / 8640)
		else
			rate = rate + ((time() - logout) / 34560)	-- 4 times less if not at an inn
		end
	end

	local coeff = 1
	if Altoholic.Options:Get("RestXPMode") == 1 then
		coeff = 1.5
	end
	rate = rate * coeff
	
	-- second return value = the actual percentage of rest xp, as a numeric value (1 to 100, not 150)
	if rate >= (100 * coeff) then 
		return "|cFF00FF00" .. format("%d", (100 * coeff)) .. "%", 100 * coeff
	else
		local color
		if rate < (30 * coeff) then
			color = "|cFFFF0000"
		elseif rate < (60 * coeff) then
			color = "|cFFFFFF00"
		else
			color = GREEN
		end
		return color .. format("%d", rate) .. "%", rate
	end
end

function Altoholic:GetRestXPRate(maxXP, restXP)

	-- after extensive tests, it seems that the known formula to calculate rest xp is incorrect.
	-- I believed that the maximum rest xp was exactly 1.5 level, and since 8 hours of rest = 5% of a level
	-- being 100% rested would mean having 150% xp .. but there's a trick...
	-- One would expect that 150% of rest xp would be split over the following levels, and that calculating the exact amount of rest
	-- would require taking into account that 30% are over the current level, 100% over lv+1, and the remaining 20% over lv+2 ..
	
	-- .. But that is not the case.Blizzard only takes into account 150% of rest xp AT THE CURRENT LEVEL RATE.
	-- ex: at level 15, it takes 13600 xp to go to 16, therefore the maximum attainable rest xp is:
	--	136 (1% of the level) * 150 = 20400 

	-- thus, to calculate the exact rate (ex at level 15): 
		-- divide xptonext by 100 : 		13600 / 100 = 136	==> 1% of the level
		-- multiply by 1.5				136 * 1.5 = 204
		-- divide rest xp by this value	20400 / 204 = 100	==> rest xp rate
		
	if not restXP then return 0 end
	return (restXP / ((maxXP / 100) * 1.5))
end



function Altoholic:GetGuildBankItemCount(searchedID, guildName, realm, account)

	local r = Altoholic:GetRealmTable(realm, account)

	local guildCount = 0
	for TabName, t in pairs(r.guild[guildName].bank) do
		for slotID, id in pairs(t.ids) do
			if (id) and (id == searchedID) then
				guildCount = guildCount + (t.counts[slotID] or 1)
			end
		end	-- end slots
	end	-- end tabs

	return guildCount
end

-- finally some decent code for the tooltip counters ...
local ItemCounts = {}
local ItemCountsLabels = {	L["Bags"], L["Bank"], L["AH"], L["Equipped"], L["Mail"] }

function Altoholic:GetCharacterItemCount(searchedID, charName, realm, account)
	
	-- keep a pointer to the character that will be scanned
	self.CountCharacter = self:GetCharacterTable(charName, realm, account)
	local c = self.CountCharacter

	ItemCounts[1], ItemCounts[2] = self.Containers:GetItemCount(searchedID)
	ItemCounts[3] = self.AuctionHouse:GetItemCount(searchedID)
	ItemCounts[4] = self.Equipment:GetItemCount(searchedID)
	ItemCounts[5] = self.Mail:GetItemCount(searchedID)
	
	local charCount = 0
	for _, v in ipairs(ItemCounts) do
		charCount = charCount + v
	end
	
	if charCount > 0 then
		local name = Altoholic:GetClassColor(c.englishClass) .. charName
		-- if after this call, the name is displayed in white for a class other than priest, there's a problem.
		-- 25/03/2009: I fixed a bug that caused invalid character entries to be automatically added to the DB due to Ace3 DB's magic wildcard.
		-- the issue happened when mousing over an achievement AFTER having changed realm, thereby creating new alts from another realm in the current one.
		-- the solution was to actually hide the buttons to prevent this from happening, but a better fix will be brought later when tabs will be reviewed.
		
		if account ~= THIS_ACCOUNT then
			name = name .. YELLOW .. " (" .. account .. ")"
		end
		
		local t = {}
		for k, v in ipairs(ItemCounts) do
			if v > 0 then	-- if there are more than 0 items in this container
				table.insert(t, WHITE .. ItemCountsLabels[k] .. ": "  .. TEAL .. v)
			end
		end

		-- charInfo should look like 	(Bags: 4, Bank: 8, Equipped: 1, Mail: 7), table concat takes care of this
		V.ItemCount[name] = format("%s (%s%s)", ORANGE .. charCount .. WHITE,
			table.concat(t, WHITE..", "), WHITE	)
	end
	
	self.CountCharacter = nil
	
	return charCount
end

function Altoholic:GetAccountItemCount(searchedID, account)
	
	local realm = GetRealmName()		-- implicit: this realm only
	local count = 0

	for CharacterName, c in pairs(Altoholic.db.global.data[account][realm].char) do
		if Altoholic.Options:Get("TooltipCrossFaction") == 1 then
			count = count + Altoholic:GetCharacterItemCount(searchedID, CharacterName, realm, account)
		else
			if	c.faction == UnitFactionGroup("player") then
				count = count + Altoholic:GetCharacterItemCount(searchedID, CharacterName, realm, account)
			end
		end
	end
	return count
end

function Altoholic:GetItemCount(searchedID)
	-- Return the total amount of times an item is present on this realm, and prepares the V.ItemCount table for later display by the tooltip

	V.ItemCount = V.ItemCount or {}
	wipe(V.ItemCount)

	local count = 0
	if Altoholic.Options:Get("TooltipMultiAccount") == 1 and not Altoholic.Comm.Sharing.SharingInProgress then
		for AccountName, a in pairs(Altoholic.db.global.data) do
			count = count + Altoholic:GetAccountItemCount(searchedID, AccountName)
		end
	else
		count = Altoholic:GetAccountItemCount(searchedID, THIS_ACCOUNT)
	end
	
	if Altoholic.Options:Get("TooltipGuildBank") == 1 then
		-- multi account ici
		for guildName, g in pairs(Altoholic.db.global.data[THIS_ACCOUNT][GetRealmName()].guild) do
			if not g.hideInTooltip then
				local guildCount = Altoholic:GetGuildBankItemCount(searchedID, guildName, GetRealmName(), THIS_ACCOUNT)
				if guildCount > 0 then
					V.ItemCount[GREEN .. guildName] = format("%s(%s: %s%s)", WHITE, GUILD_BANK, TEAL..guildCount, WHITE)
				end
				
				if Altoholic.Options:Get("TooltipGuildBankCount") == 1 then
					count = count + guildCount
				end
			end	-- end if not hidden
		end	-- end guild
	end

	return count
end

function Altoholic:IsGatheringNode(name)
	-- returns the itemID if "name" is a known type of gathering node (mines & herbs)
	if not name then return nil end

	for k, v in pairs( self.Gathering ) do
		if name == k then
			return v
		end
	end
	return nil	-- not found, return nil
end

function Altoholic:GetSuggestion(index, level)
	if self.Suggestions[index] == nil then return nil end
	
	for k, v in pairs( self.Suggestions[index] ) do
		if level < v[1] then		-- the suggestions are sorted by level, so whenever we're below, return the text
			return v[2]
		end
	end
	return nil	-- already at max level, no suggestion
end

function Altoholic:UpdateSlider(name, text, field)
	local s = _G[name]
	_G[name .. "Text"]:SetText(text .. " (" .. s:GetValue() ..")");

	if not Altoholic.db then return end
	local a = Altoholic.db.global
	if a == nil then return	end
	
	a.options[field] = s:GetValue()
	self:MoveMinimapIcon()
end

function Altoholic:ShowWidgetTooltip(frame)
	if not frame.tooltip then return end
	
	AltoTooltip:SetOwner(frame, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();
	AltoTooltip:AddLine(frame.tooltip)
	AltoTooltip:Show(); 
end

function Altoholic:ShowClassIcons()
	local r = Altoholic:GetRealmTable()
	local i = 1
	
	for CharacterName, c in pairs(r.char) do
		local itemName = "AltoholicFrameClassesItem" .. i;
		local itemButton = _G[itemName];
		itemButton:SetScript("OnEnter", function(self) 
				Altoholic:DrawCharacterTooltip(self, self.CharName)
			end)
		itemButton:SetScript("OnLeave", function(self) 
				AltoTooltip:Hide()
			end)
		itemButton:SetScript("OnClick", Altoholic_Equipment_OnClick)
		
		local tc = CLASS_ICON_TCOORDS[c.englishClass]
		local itemTexture = _G[itemName .. "IconTexture"]
		itemTexture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes");
		itemTexture:SetTexCoord(tc[1], tc[2], tc[3], tc[4]);
		itemTexture:SetWidth(36);
		itemTexture:SetHeight(36);
		itemTexture:SetAllPoints(itemButton);
		
		Altoholic:CreateButtonBorder(itemButton)

		if c.faction == "Alliance" then
			itemButton.border:SetVertexColor(0.1, 0.25, 1, 0.5)
		else
			itemButton.border:SetVertexColor(1, 0, 0, 0.5)
		end
		itemButton.border:Show()
		
		itemButton.CharName = CharacterName
		itemButton:Show()
		
		i = i + 1
		if i > 10 then 	-- users of Symbolic Links might have more than 10 columns, prevent it
			break
		end
	end
	
	while i <= 10 do
		_G[ "AltoholicFrameClassesItem" .. i ]:Hide()
		_G[ "AltoholicFrameClassesItem" .. i ].CharName = nil
		i = i + 1
	end
end

function Altoholic:CreateButtonBorder(frame)
	if frame.border ~= nil then return end

	-- this part was taken from Combuctor
	local border = frame:CreateTexture(nil, 'OVERLAY')
	border:SetWidth(67);
	border:SetHeight(67)
	border:SetPoint('CENTER', frame)
	border:SetTexture('Interface/Buttons/UI-ActionButton-Border')
	border:SetBlendMode('ADD')
	border:Hide()
	
	frame.border = border
end

function Altoholic:DrawCharacterTooltip(self, charName)
	local r = Altoholic:GetRealmTable()
	local c = r.char[charName]
	
	AltoTooltip:SetOwner(self, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();

	AltoTooltip:AddDoubleLine(Altoholic:GetClassColor(c.englishClass) .. charName, Altoholic:ColourFaction(c.faction))
	AltoTooltip:AddLine(L["Level"] .. " " .. GREEN .. c.level .. " |r".. c.race .. " " .. c.class,1,1,1);
	AltoTooltip:AddLine(L["Zone"] .. ": " .. GOLD .. c.zone .. " |r(" .. GOLD .. c.subzone .."|r)",1,1,1);
	if c.restxp then
		AltoTooltip:AddLine(L["Rest XP"] .. ": " .. GREEN .. c.restxp,1,1,1);
	end
	AltoTooltip:AddLine("Average iLevel: " .. GREEN .. format("%.1f", c.averageItemLvl),1,1,1);	
	if c.CompletedAchievements > 0 then
		AltoTooltip:AddLine(ACHIEVEMENTS_COMPLETED ..": " .. GREEN .. c.CompletedAchievements .. "/"..c.TotalAchievements)
		AltoTooltip:AddLine(ACHIEVEMENT_TITLE ..": " .. GREEN .. c.TotalAchievementPoints)
	end
	
	AltoTooltip:Show();
end


-- *** Hooks ***
local Orig_ChatEdit_InsertLink = ChatEdit_InsertLink

function ChatEdit_InsertLink(text, ...)
	if text and AltoholicFrame_SearchEditBox:IsVisible() then
		if not Altoholic.TradeSkills.isOpen then
			AltoholicFrame_SearchEditBox:Insert(GetItemInfo(text))
			return true
		end
	end
	return Orig_ChatEdit_InsertLink(text, ...)
end

-- ** GameTooltip Hooks **
Altoholic.Tooltip = {}

function Altoholic.Tooltip:Init()
	self.Orig_GameTooltip_OnShow = GameTooltip:GetScript("OnShow")
	self.Orig_GameTooltip_SetItem = GameTooltip:GetScript("OnTooltipSetItem")
	self.Orig_GameTooltip_ClearItem = GameTooltip:GetScript("OnTooltipCleared")
	
	self.Orig_ItemRefTooltip_OnShow = ItemRefTooltip:GetScript("OnShow")
	self.Orig_ItemRefTooltip_SetItem = ItemRefTooltip:GetScript("OnTooltipSetItem")
	self.Orig_ItemRefTooltip_ClearItem = ItemRefTooltip:GetScript("OnTooltipCleared")
	
	GameTooltip:SetScript("OnShow", self.OnGameTooltipShow)
	GameTooltip:SetScript("OnTooltipSetItem", self.OnGameTooltipSetItem)
	GameTooltip:SetScript("OnTooltipCleared", self.OnGameTooltipCleared)
	
	ItemRefTooltip:SetScript("OnShow", self.OnItemRefTooltipShow)
	ItemRefTooltip:SetScript("OnTooltipSetItem", self.OnItemRefTooltipSetItem)
	ItemRefTooltip:SetScript("OnTooltipCleared", self.OnItemRefTooltipCleared)
end

function Altoholic.Tooltip.OnGameTooltipShow(tooltip, ...)
	local self = Altoholic.Tooltip
	
	if self.Orig_GameTooltip_OnShow then
		self.Orig_GameTooltip_OnShow(tooltip, ...)
	end	

	-- exit if player does not want counters for known gathering nodes
	if Altoholic.Options:Get("TooltipGatheringNode") == 0 then return end
	
	local itemID = Altoholic:IsGatheringNode( _G["GameTooltipTextLeft1"]:GetText() )
	if itemID and (itemID ~= self.CachedItemID) then			-- is the item in the tooltip a known type of gathering node ?

		-- check player bags to see how many times he owns this item, and where
		if Altoholic.Options:Get("TooltipCount") == 1 or Altoholic.Options:Get("TooltipTotal") == 1 then
			self.CachedCount = Altoholic:GetItemCount(itemID) -- if one of the 2 options is active, do the count
			if self.CachedCount > 0 then
				self.CachedTotal = GOLD .. L["Total owned"] .. ": |cff00ff9a" .. self.CachedCount
			else
				self.CachedTotal = nil
			end
		end		
		
		if (Altoholic.Options:Get("TooltipCount") == 1) then			-- add count per character
			GameTooltip:AddLine(" ",1,1,1);
			for CharacterName, c in pairs (V.ItemCount) do
				--GameTooltip:AddDoubleLine(CharacterName .. ":",  TEAL .. c);
				GameTooltip:AddDoubleLine(CharacterName,  TEAL .. c);
			end
		end
		
		if (Altoholic.Options:Get("TooltipTotal") == 1) and (self.CachedTotal) then		-- add total count
			GameTooltip:AddLine(self.CachedTotal,1,1,1);
		end		
	end

	GameTooltip:Show()
end

function Altoholic.Tooltip.OnGameTooltipSetItem(tooltip, ...)

	local self = Altoholic.Tooltip

	if self.Orig_GameTooltip_SetItem then
		self.Orig_GameTooltip_SetItem(tooltip, ...)
	end
	if (not self.isDone) and tooltip then
		local name, link = tooltip:GetItem()
		self.isDone = true
		if link then
			self:Process(tooltip, name, link)
		end
	end
end

function Altoholic.Tooltip.OnGameTooltipCleared(tooltip, ...)

	local self = Altoholic.Tooltip

	self.isDone = nil
	return self.Orig_GameTooltip_ClearItem(tooltip, ...)
end

function Altoholic.Tooltip.OnItemRefTooltipShow(tooltip, ...)
	local self = Altoholic.Tooltip
	
	if self.Orig_ItemRefTooltip_OnShow then
		self.Orig_ItemRefTooltip_OnShow(tooltip, ...)
	end

	Altoholic.Quests:IsKnown( _G["ItemRefTooltipTextLeft1"]:GetText() )
	ItemRefTooltip:Show()
end

function Altoholic.Tooltip.OnItemRefTooltipSetItem(tooltip, ...)

	local self = Altoholic.Tooltip
	
	if self.Orig_ItemRefTooltip_SetItem then
		self.Orig_ItemRefTooltip_SetItem(tooltip, ...)
	end
	
	if (not self.isDone) and tooltip then
		local name, link = tooltip:GetItem()
		self.isDone = true
		if link then
			self:Process(tooltip, name, link)
		end
	end
end

function Altoholic.Tooltip.OnItemRefTooltipCleared(tooltip, ...)

	local self = Altoholic.Tooltip
	
	self.isDone = nil
	return self.Orig_ItemRefTooltip_ClearItem(tooltip, ...)
end

function Altoholic.Tooltip:Process(tooltip, name, link)
	--	*** Note about tooltips ***
	--	If an error occurs with a specific item, like a gathering node, make sure its item id is valid in core.lua
	--	28/12/2008: I fixed an issue with black lotus, which did not display its counters at all, this was due to an invalid item id

	local itemID = Altoholic:GetIDFromLink(link)
	
	-- if there's no cached item id OR if it's different from the previous one ..
	if (not self.CachedItemID) or 
		(self.CachedItemID and (itemID ~= self.CachedItemID)) then

		self.RecipeCache = nil
		
		-- these are the cpu intensive parts of the update .. so do them only if necessary
		self.CachedSource = nil
		if Altoholic.Options:Get("TooltipSource") == 1 then
			local Instance, Boss = Altoholic.Loots:GetSource(itemID)
			
			self.CachedItemID = itemID			-- we have searched this ID ..
		
			if Instance then
				self.CachedSource = GOLD .. L["Source"]..  ": |cff00ff9a" .. Instance .. ", " .. Boss
			end
		end
		
		-- .. then check player bags to see how many times he owns this item, and where
		if Altoholic.Options:Get("TooltipCount") == 1 or Altoholic.Options:Get("TooltipTotal") == 1 then
			self.CachedCount = Altoholic:GetItemCount(itemID) -- if one of the 2 options is active, do the count
			if self.CachedCount > 0 then
				self.CachedTotal = GOLD .. L["Total owned"] .. ": |cff00ff9a" .. self.CachedCount
			else
				self.CachedTotal = nil
			end
		end
	end

	-- add item cooldown text
	local owner = tooltip:GetOwner()
	if owner and owner.startTime then
		tooltip:AddLine(format(ITEM_COOLDOWN_TIME, 
				SecondsToTime(owner.duration - (GetTime() - owner.startTime))),1,1,1);
	end
	
	if (Altoholic.Options:Get("TooltipCount") == 1) then			-- add count per character
		tooltip:AddLine(" ",1,1,1);
		for CharacterName, c in pairs (V.ItemCount) do
			tooltip:AddDoubleLine(CharacterName,  TEAL .. c);
		end
	end
	
	if (Altoholic.Options:Get("TooltipTotal") == 1) and (self.CachedTotal) then		-- add total count
		tooltip:AddLine(self.CachedTotal,1,1,1);
	end
	
	if self.CachedSource then		-- add item source
		tooltip:AddLine(" ",1,1,1);
		tooltip:AddLine(self.CachedSource,1,1,1);
	end
	
	-- Altoholic:CheckMaterialUtility(itemID)
	
	if Altoholic.Options:Get("TooltipItemID") == 1 then
		local iLevel = select(4, GetItemInfo(itemID))
		
		if iLevel then
			tooltip:AddLine(" ",1,1,1);
			tooltip:AddDoubleLine("Item ID: " .. GREEN .. itemID,  "iLvl: " .. GREEN .. iLevel);
--			tooltip:AddLine(TEAL .. select(10, GetItemInfo(itemID)));		-- texture path
		end
	end
	
	local companionID = Altoholic:GetCompanionSpellID(itemID)
	if companionID then
		tooltip:AddLine(" ",1,1,1);	
		self:WhoKnowsPet(companionID, "CRITTER", tooltip)
		return	-- it's certainly not a recipe if we passed here
	end
	
	local mountID = Altoholic:GetMountSpellID(itemID)
	if mountID then
		tooltip:AddLine(" ",1,1,1);	
		self:WhoKnowsPet(mountID, "MOUNT", tooltip)
		return	-- it's certainly not a recipe if we passed here
	end
	
	
	if Altoholic.Options:Get("TooltipRecipeInfo") == 0 then return end -- exit if recipe information is not wanted
	
	local _, _, _, _, _, itemType, itemSubType = GetItemInfo(itemID)
	if itemType ~= BI["Recipe"] then return end		-- exit if not a recipe
	if itemSubType == BI["Book"] then return end		-- exit if it's a book

	if not self.RecipeCache then
		local tooltipName = tooltip:GetName()
		local reqLevel
		for i = 2, tooltip:NumLines() do			-- parse all tooltip lines, one by one
			local tooltipText = _G[tooltipName .. "TextLeft" .. i]:GetText()
			if tooltipText then
				if string.find(tooltipText, "%d+") then	-- try to find a numeric value .. 
					reqLevel = tonumber(string.sub(tooltipText, string.find(tooltipText, "%d+")))
					break
				end
			end
		end
		self.RecipeCache = self:WhoKnowsRecipe(itemSubType, link, reqLevel)
	end
	
	if self.RecipeCache then
		tooltip:AddLine(" ",1,1,1);	
		tooltip:AddLine(self.RecipeCache, 1, 1, 1, 1);
	end	
end

function Altoholic.Tooltip:ForceRefresh()
	self.CachedItemID = nil	-- putting this at NIL will force a tooltip refresh in self:ProcessToolTip
end

function Altoholic.Tooltip:WhoKnowsPet(companionSpellID, petType, tooltip)
	local know = {}				-- list of alts who know this pet
	local couldLearn = {}		-- list of alts who could learn it
	
	for CharacterName, c in pairs(Altoholic.ThisRealm.char) do
		local p = c.pets[petType]
		if p then
			local isKnownByChar
			for k, v in pairs(p) do
				local _, spellID = strsplit("|", v)
			
				if tonumber(spellID) == companionSpellID then
					isKnownByChar = true
					break
				end
			end
			
			if isKnownByChar then
				table.insert(know, CharacterName)
			else
				table.insert(couldLearn, CharacterName)
			end
		end
	end
	
	if #know > 0 then
		tooltip:AddLine(TEAL .. L["Already known by "] ..": ".. WHITE.. table.concat(know, ", "), 1, 1, 1, 1);
	end
	
	if #couldLearn > 0 then
		tooltip:AddLine(YELLOW .. L["Could be learned by "] ..": ".. WHITE.. table.concat(couldLearn, ", "), 1, 1, 1, 1);
	end
end

function Altoholic.Tooltip:WhoKnowsRecipe(profession, link, recipeLevel)
	local craftName

	local spellID = Altoholic:GetSpellIDFromRecipeLink(link)
	if not spellID then		-- spell id unknown ? let's parse the tooltip
		craftName = Altoholic:GetCraftFromRecipe(link)
	
		if not craftName then return end		-- still nothing usable ? then exit
		-- keep these 2 for debug.
		-- DEFAULT_CHAT_FRAME:AddMessage("searching with craft name : "..craftName)
	-- else
		-- DEFAULT_CHAT_FRAME:AddMessage("searching with spell id : "..spellID)
	end
	
	local know = {}				-- list of alts who know this recipe
	local couldLearn = {}		-- list of alts who could learn it
	local willLearn = {}			-- list of alts who will be able to learn it later
	
	for CharacterName, c in pairs(Altoholic.ThisRealm.char) do
		local p = c.recipes[profession]
		if p.ScanFailed == false then
			local isKnownByChar
			
			if spellID then			-- if spell id is known, just find its equivalent in the professions
				for _, TradeSkillInfo in pairs (p.list) do
					local _, _, id = strsplit("^", TradeSkillInfo)
					id = tonumber(id)
					if id and spellID == id then
						isKnownByChar = true
						break
					end
				end
			else
				for _, TradeSkillInfo in pairs (p.list) do
					local _, _, id = strsplit("^", TradeSkillInfo)
					id = tonumber(id)
					if id then
						local skillName = GetSpellInfo(id) or ""

						if string.lower(skillName) == string.lower(craftName) then
							isKnownByChar = true
							break
						end
					end
				end	-- known skills loop
			end

			if isKnownByChar then
				table.insert(know, CharacterName)
			else
				local curRank
				if (profession == BI["Cooking"]) or 
					(profession == BI["First Aid"]) or
					(profession == BI["Fishing"]) then
					curRank = Altoholic.TradeSkills:GetRank( c.skill[L["Secondary Skills"]][profession] )
				else
					curRank = Altoholic.TradeSkills:GetRank( c.skill[L["Professions"]][profession] )
				end
				if curRank < recipeLevel then
					table.insert(willLearn, CharacterName)
				else
					table.insert(couldLearn, CharacterName)
				end
			end
		end
	end
	
	local lines = {}
	if #know > 0 then
		table.insert(lines, TEAL .. L["Already known by "] ..": ".. WHITE.. table.concat(know, ", "))
	end
	
	if #couldLearn > 0 then
		table.insert(lines, YELLOW .. L["Could be learned by "] ..": ".. WHITE.. table.concat(couldLearn, ", "))
	end
	
	if #willLearn > 0 then
		table.insert(lines, RED .. L["Will be learnable by "] ..": ".. WHITE.. table.concat(willLearn, ", "))
	end
	
	return table.concat(lines, "\n")
end

function Altoholic:CheckMaterialUtility(itemID)
	for CharacterName, c in pairs(Altoholic.db.global.data[THIS_ACCOUNT][GetRealmName()].char) do
		-- for each character ... 
		for SkillName, s in pairs(c.skill[L["Professions"]]) do
			if Altoholic.TradeSkills:GetRank(s) ~= 450 then		-- if the tradeskill level is not at 450
				local p = c.recipes[SkillName]
				if p.ScanFailed == false then
					-- loop through all recipes of this tradeskill that are yellow or orange
					for craftIndex, craft in pairs(p.list) do
						if craft.color and (craft.color >= 2) then
							-- test if the mat would be useful
							local i=1
							local reagent = select(i, strsplit("|", craft.reagents))
							
							while reagent do
								local reagentID = select(1, strsplit(":", reagent))
								reagentID = tonumber(reagentID)
								if reagentID and (reagentID == itemID) then
									DEFAULT_CHAT_FRAME:AddMessage("found !" .. CharacterName .. ", " .. SkillName .. ", " ..craft.link )
								end
								i = i + 1
								reagent = select(i, strsplit("|", craft.reagents))
							end
						end
					end
				end
			end
		end
	end
end

-- *** EVENT HANDLERS ***
function Altoholic:PLAYER_ALIVE()
	local c = Altoholic.ThisCharacter

	c.level = UnitLevel("player")
	c.race = UnitRace("player")
	c.class, c.englishClass = UnitClass("player")
	
	self:ScanAll()
	self.Talents:Scan()
	self.Achievements:Scan()		-- ** updating achievements takes 165 ms on my machine, try not to call this too often.
end

function Altoholic:PLAYER_LEVEL_UP(event, newLevel)
	local c = Altoholic.ThisCharacter
	c.level = newLevel
end

function Altoholic:PLAYER_XP_UPDATE()
	local c = Altoholic.ThisCharacter
	c.xp = UnitXP("player")
	c.xpmax = UnitXPMax("player")
	c.restxp = GetXPExhaustion() or 0
end

function Altoholic:PLAYER_MONEY()
	local c = Altoholic.ThisCharacter
	c.money = GetMoney();
end

function Altoholic:PLAYER_UPDATE_RESTING()
	local c = Altoholic.ThisCharacter
	c.isResting = IsResting();
end

function Altoholic:PLAYER_GUILD_UPDATE()
	-- at login this event is called between OnEnable and PLAYER_ALIVE, where GetGuildInfo returns a wrong value
	-- however, the value returned here is correct
	if IsInGuild() then
		local c = Altoholic.ThisCharacter
		c.guildName, c.guildRankName, c.guildRankIndex = GetGuildInfo("player")
		
		if self.DoInitialBroadcast and c.guildName then
			-- best place to do this, since it depends on the guild name returned above.
			Altoholic:SendPublicInfo(MSG_GUILD_ANNOUNCELOGIN, nil, c.guildName)
			self.DoInitialBroadcast = nil
		end
	end
end

function Altoholic:CHAT_MSG_SKILL(self, msg)
	if msg then
		Altoholic:UpdatePlayerSkills()
	end
end

function Altoholic:CHAT_MSG_COMBAT_FACTION_CHANGE(event, text)
	self.Reputations:Scan()
end

function Altoholic:UpdatePlayerLocation()
	local c = Altoholic.ThisCharacter
	c.zone = GetRealZoneText()
	c.subzone = GetSubZoneText()
end

function Altoholic:PLAYER_LOGOUT()
	local c = Altoholic.ThisCharacter
	c.lastlogout = time()
end

function Altoholic:TIME_PLAYED_MSG(event, TotalTime, CurrentLevelTime)
	local c = Altoholic.ThisCharacter
	c.played = TotalTime

	-- I'm not entirely happy to have to put this here, but in all events triggered prior to this one, the icon button is not yet valid,
	-- and can't be hidden programmatically. Hopefully, this event is only triggered at login and when /played is typed, so minimal impact.
	if self:IsFuBarMinimapAttached() then
		--	still required to test if it's not nil, when a new character  is created for instance.
		if type(_G["LibFuBarPlugin-3.0_Altoholic_FrameMinimapButton"]) ~= "nil" then
			_G["LibFuBarPlugin-3.0_Altoholic_FrameMinimapButton"]:Hide()
		end
	end

	self.Mail:CheckExpiries()
end

function Altoholic:RequestUpdateRaidInfo()
	RequestRaidInfo()
end

function Altoholic:CHAT_MSG_LOOT(event, arg)
	local item = arg:match("%b[]")
	if not item then return end
	
	item = gsub(item, "[\[]", "")
	item = gsub(item, "[\]]", "")
	
	local trackedItems = {		-- temporarly here, will be moved
		[39878] = 604800, -- Mysterious Egg, 7 days
		[44717] = 604800, -- Disgusting Jar, 7 days
	}

	for k, v in pairs(trackedItems) do
		local name = GetItemInfo(k)
		if name and name == item then
			local c = Altoholic.ThisCharacter
			table.insert(c.Timers, name .."|" .. time() .. "|" .. v)
			Altoholic.Calendar.Events:BuildList()
			Altoholic.Tabs.Summary:Refresh()
		end
	end
end

function Altoholic:CHAT_MSG_SYSTEM(event, arg)
	if arg then
		if arg:match(L["has come online"]) or arg:match(L["has gone offline"]) then
			if IsInGuild() then
				GuildRoster()
			end
		elseif tostring(arg1) == INSTANCE_SAVED then
			Altoholic:RequestUpdateRaidInfo()
		end
	end
end

function Altoholic:PLAYER_TALENT_UPDATE()
	Altoholic.Talents:Scan()
	if AltoholicFrameTalents:IsVisible() then
		Altoholic.Talents:Update()
	end
end	
