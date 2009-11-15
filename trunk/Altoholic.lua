--[[	*** Altoholic ***
Written by : Thaoky, EU-Marécages de Zangar
--]]

local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
local DS

local V = Altoholic.vars


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
	AltoholicTabOptionsMenuItem4:SetText(L["Account Sharing"])
	AltoholicTabOptionsMenuItem5:SetText(L["Tooltip"])
	AltoholicTabOptionsMenuItem6:SetText(L["Calendar"])
	
	AltoholicFramePetsText1:SetText(L["View"])
	AltoholicFrameReputationsText1:SetText(L["View"])
	AltoholicFrameCurrenciesText1:SetText(L["View"])
	
	AltoholicTabGuildBank_HideInTooltipText:SetText(L["Hide this guild in the tooltip"])
	
	AltoAccountSharingName:SetText(L["Account Name"])
	AltoAccountSharingText1:SetText(L["Send account sharing request to:"])
	AltoAccountSharingText2:SetText(ORANGE.."Available Content")
	AltoAccountSharingText3:SetText(ORANGE.."Size")
	AltoAccountSharingText4:SetText(ORANGE.."Date")
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
	DS = DataStore

	self:InitLocalization()
	self.Options:Init()
	self.Tasks:Init()
	self.Profiler:Init()
	self.Tooltip:Init()
	
	self:RegisterEvent("PLAYER_ALIVE")
	self:RegisterEvent("PLAYER_LOGOUT")
	self:RegisterEvent("UPDATE_INSTANCE_INFO", "UpdateRaidTimers")
	self:RegisterEvent("RAID_INSTANCE_WELCOME", "RequestUpdateRaidInfo")

	self:RegisterEvent("GUILDBANKFRAME_OPENED", Altoholic.GuildBank.OnOpen)
	self:RegisterEvent("AUCTION_HOUSE_SHOW", Altoholic.AuctionHouse.OnShow)
	self:RegisterEvent("PLAYER_TALENT_UPDATE", Altoholic.Talents.OnUpdate);
	
	AltoholicFrameName:SetText("Altoholic |cFFFFFFFF".. Altoholic.Version .. " by |cFF69CCF0Thaoky")

	local realm = GetRealmName()
	local player = UnitName("player")
	local key = format("%s.%s.%s", THIS_ACCOUNT, realm, player)
	self.ThisCharacter = Altoholic.db.global.Characters[key]
	
	Altoholic:SetCurrentCharacter(player, realm, THIS_ACCOUNT)

	self.Tabs.Summary:Init()
	self.Containers:Init()
	self.BagUsage:Init()
	self.TradeSkills.Recipes:Init()
	self.Search:Init()
	self.Currencies:Init()
	
	-- do not move this one into the frame's OnLoad
	UIDropDownMenu_Initialize(AltoholicFrameEquipmentRightClickMenu, Equipment_RightClickMenu_OnLoad, "MENU");
	
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
	
	self:RegisterEvent("BAG_UPDATE", self.Containers.OnBagUpdate)
	self:RegisterEvent("FRIENDLIST_UPDATE", self.UpdateFriends);
	self:RegisterEvent("CHAT_MSG_SYSTEM");
	self:RegisterEvent("CHAT_MSG_LOOT")
	self:RegisterEvent("UNIT_PET", self.Pets.OnChange);
	
	if IsInGuild() then
		self:RegisterEvent("GUILD_ROSTER_UPDATE", self.Guild.Members.OnRosterUpdate);
	end
	
	self.UnsafeItems:BuildList()
	
	-- LinkWrangler supoprt
   if LinkWrangler then
      LinkWrangler.RegisterCallback ("Altoholic",  Hook_LinkWrangler, "refresh")
   end

	-- create an empty frame to manage the timer via its Onupdate
	self.TimerFrame = CreateFrame("Frame", "AltoholicTimerFrame", UIParent)
	local f = self.TimerFrame
	
	f:SetWidth(1)
	f:SetHeight(1)
	f:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 1, 1)
	f:SetScript("OnUpdate", function(self, elapsed) Altoholic.Tasks:OnUpdate(elapsed) end)
	f:Show()
	
	-- clean up old data, thanks AnrDaemon for the suggestion.
	AltoholicDB.global.data = nil
	AltoholicDB.global.reference = nil
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
	SetPortraitTexture(AltoholicFramePortrait, "player");	

	self.Characters:BuildList()
	self.Characters:BuildView()
	
	if not self.Tabs.current then
		self.Tabs.current = 1
		self.Tabs.Summary:MenuItem_OnClick(1)
	elseif self.Tabs.current == 1 then
		self.Tabs.Summary:Refresh()
	end
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
	for account in pairs(DS:GetAccounts()) do
		for realm in pairs(DS:GetRealms(account)) do
			local realmmoney, realmplayed, realmlevels = self:AddRealm(account, realm, realmID)

			if mode == SUMMARY_THISREALM then
				-- if we show only this realm, then counters for other accounts or other realms are at 0
				if (account ~= THIS_ACCOUNT) or (realm ~= GetRealmName()) then
					realmmoney = 0
					realmplayed = 0
					realmlevels = 0
				end
			elseif mode == SUMMARY_ALLREALMS then
				-- All realms, but this account only
				if (account ~= THIS_ACCOUNT) then
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
	--AltoholicFrameTotalGold:SetText(floor( money / 10000 ) .. "|cFFFFD700g")
	AltoholicFrameTotalGold:SetText(format(GOLD_AMOUNT_TEXTURE, floor( money / 10000 ), 13, 13))
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
	
	for characterName, character in pairs(DS:GetCharacters(RealmName, AccountName)) do
		SkillsCache[1].name = ""
		SkillsCache[1].rank = 0
		SkillsCache[1].spellID = nil
		SkillsCache[2].name = ""
		SkillsCache[2].rank = 0
		SkillsCache[2].spellID = nil

		local i = 1
		for SkillName, s in pairs(DS:GetPrimaryProfessions(character)) do
			SkillsCache[i].name = SkillName
			SkillsCache[i].rank = DS:GetSkillInfo(character, SkillName)
			SkillsCache[i].spellID = Altoholic:GetProfessionSpellID(SkillName)
			i = i + 1
			
			if i > 2 then		-- it seems that under certain conditions, the loop continues after 2 professions.., so break
				break
			end
		end
		
		table.insert(self.List, { linetype = INFO_CHARACTER_LINE + (realmID*3),
			name = characterName,
			parentID = parentRealm,
			skillName1 = SkillsCache[1].name,
			skillRank1 = SkillsCache[1].rank,
			spellID1 = SkillsCache[1].spellID,
			skillName2 = SkillsCache[2].name,
			skillRank2 = SkillsCache[2].rank,
			spellID2 = SkillsCache[2].spellID,
			cooking = DS:GetCookingRank(character),
			firstaid = DS:GetFirstAidRank(character),
			fishing = DS:GetFishingRank(character),
			riding = DS:GetRidingRank(character),
		} )

		realmlevels = realmlevels + DS:GetCharacterLevel(character)
		realmmoney = realmmoney + DS:GetMoney(character)
		realmplayed = realmplayed + DS:GetPlayTime(character)
		
		realmBagSlots = realmBagSlots + DS:GetNumBagSlots(character)
		realmFreeBagSlots = realmFreeBagSlots + DS:GetNumFreeBagSlots(character)
		realmBankSlots = realmBankSlots + DS:GetNumBankSlots(character)
		realmFreeBankSlots = realmFreeBankSlots + DS:GetNumFreeBankSlots(character)
	end		-- end char

	table.insert(self.List, { linetype = INFO_TOTAL_LINE + (realmID*3),
		parentID = parentRealm,
		level = WHITE .. realmlevels,
		money = realmmoney,
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
	elseif mode == SUMMARY_ALLREALMS then					-- all realms on this account only
		for realm in pairs(DS:GetRealms()) do
			self:AddRealmView(THIS_ACCOUNT, realm)
		end
	elseif mode == SUMMARY_ALLACCOUNTS then				-- all realms on all accounts
		for account in pairs(DS:GetAccounts()) do
			for realm in pairs(DS:GetRealms(account)) do
				self:AddRealmView(account, realm)
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

local function SortByPrimarySkill(a, b, skillName, ascending)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by field xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end
		
		local charA = DS:GetCharacter(a.name, a.realm, a.account)
		local charB = DS:GetCharacter(b.name, b.realm, b.account)
		local skillA = DS:GetSkillInfo(charA, a[skillName])
		local skillB = DS:GetSkillInfo(charB, b[skillName])
		
		if ascending then
			return skillA < skillB
		else
			return skillA > skillB
		end
	end
end

local function SortByFunction(a, b, func, ascending)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by func xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end

		local charA = DS:GetCharacter(a.name, a.realm, a.account)
		local charB = DS:GetCharacter(b.name, b.realm, b.account)
		
		if ascending then
			return DS[func](self, charA) < DS[func](self, charB)
		else
			return DS[func](self, charA) > DS[func](self, charB)
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

	-- Primary Skill
	if (field == "skillName1") or (field == "skillName2") then
		table.sort(self.List, function(a, b) return SortByPrimarySkill(a, b, field, ascending)
			end)
	else
		table.sort(self.List, function(a, b) return SortByFunction(a, b, field, ascending) end)
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
	local character = self.List[line]
	local parent = self.List[ character.parentID ]
	return character.name, parent.realm, parent.account
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

function Altoholic:UpdateFriends()
	local c = Altoholic.ThisCharacter
	wipe(c.Friends)
	
	for i = 1, GetNumFriends() do
	   local name = GetFriendInfo(i);
	   table.insert(c.Friends, name)
	end
end

function Altoholic:UpdateRaidTimers()	
	local c = Altoholic.ThisCharacter
	
	wipe(c.SavedInstance)
	
	for i=1, GetNumSavedInstances() do
		local instanceName, instanceID, instanceReset, difficulty, _, extended, _, isRaid, maxPlayers, difficultyName = GetSavedInstanceInfo(i)

		if instanceReset > 0 then		-- in 3.2, instances with reset = 0 are also listed (to support raid extensions)
			extended = extended and 0 or 1
			isRaid = isRaid and 0 or 1
			
			if difficulty > 1 then
				instanceName = format("%s %s", instanceName, difficultyName)
			end

			local key = instanceName.. "|" .. instanceID
			c.SavedInstance[key] = format("%s|%s|%s|%s", instanceReset, time(), extended, isRaid )
		end
	end
end

-- *** DB functions ***

function Altoholic:GetCharacterTable(name, realm, account)
	-- Usage: 
	-- 	local c = Altoholic:GetCharacterTable(char, realm, account)
	--	all 3 parameters default to current player, realm or account
	-- use this for features that have to work regardless of an alt's location (any realm, any account)
	name = name or Altoholic.CurrentAlt
	realm = realm or Altoholic.CurrentRealm
	account = account or Altoholic.CurrentAccount
	
	local key = format("%s.%s.%s", account, realm, name)
	
	return Altoholic.db.global.Characters[key]
end

function Altoholic:GetCharacterTableByLine(line)
	-- shortcut to get the right character table based on the line number in the info table.
	return Altoholic:GetCharacterTable( Altoholic.Characters:GetInfo(line) )
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
	return self.CurrentRealm, self.CurrentAccount
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

function Altoholic:GetGuild(name, realm, account)
	name = name or GetGuildInfo("player")
	if not name then return end
	
	realm = realm or GetRealmName()
	account = account or THIS_ACCOUNT
	
	local key = format("%s.%s.%s", account, realm, name)
	return Altoholic.db.global.Guilds[key]
end

function Altoholic:GetGuildFaction(guild)
	assert(type(guild) == "table")
	return guild.faction
end

function Altoholic:GetGuildMembers(guild)
	assert(type(guild) == "table")
	return guild.members
end

function Altoholic:SetLastAccountSharingInfo(name, realm, account)
	local sharing = Altoholic.db.global.Sharing.Domains[format("%s.%s", account, realm)]
	sharing.lastSharingTimestamp = time()
	sharing.lastUpdatedWith = name
end

function Altoholic:GetLastAccountSharingInfo(realm, account)
	local sharing = Altoholic.db.global.Sharing.Domains[format("%s.%s", account, realm)]
	
	if sharing then
		return date("%m/%d/%Y %H:%M", sharing.lastSharingTimestamp), sharing.lastUpdatedWith
	end
end



-- *** Utility functions ***
function Altoholic:ScrollFrameUpdate(desc)
	assert(type(desc) == "table")		-- desc is the table that contains a standardized description of the scrollframe
	
	local frame = desc.Frame
	local entry = frame.."Entry"

	-- hide all lines and set their id to 0, the update function is responsible for showing and setting id's of valid lines	
	for i = 1, desc.NumLines do
		_G[ entry..i ]:SetID(0)
		_G[ entry..i ]:Hide()
	end
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] )
	-- call the update handler
	desc:Update(offset, entry, desc)
	
	local last = (desc:GetSize() < desc.NumLines) and desc.NumLines or desc:GetSize()
	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], last, desc.NumLines, desc.LineHeight);
end

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

function Altoholic:GetMoneyString(copper, color, noTexture)
	color = color or "|cFFFFD700"

	local gold = floor( copper / 10000 );
	copper = mod(copper, 10000)
	local silver = floor( copper / 100 );
	copper = mod(copper, 100)
	
	if noTexture then				-- use noTexture for places where the texture does not fit too well,  ex: tooltips
		copper = format("%s%s%s%s", color, copper, "|cFFEDA55F", COPPER_AMOUNT_SYMBOL)
		silver = format("%s%s%s%s", color, silver, "|cFFC7C7CF", SILVER_AMOUNT_SYMBOL)
		gold = format("%s%s%s%s", color, gold, "|cFFFFD700", GOLD_AMOUNT_SYMBOL)
	else
		copper = color..format(COPPER_AMOUNT_TEXTURE, copper, 13, 13)
		silver = color..format(SILVER_AMOUNT_TEXTURE, silver, 13, 13)
		gold = color..format(GOLD_AMOUNT_TEXTURE, gold, 13, 13)
	end
	return format("%s %s %s", gold, silver, copper)
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

function Altoholic:GetFactionColour(faction)
	if faction == "Alliance" then
		return "|cFF2459FF"
	else
		return "|cFFFF0000"
	end
end

function Altoholic:GetClassColor(class)
	return Altoholic.ClassInfo[class] or WHITE
end

function Altoholic:GetDelayInDays(delay)
	return floor((time() - delay) / 86400)
end

function Altoholic:FormatDelay(timeStamp)
	-- timeStamp = value when time() was last called for a given variable (ex: last time the mailbox was checked)
	if not timeStamp then
		return YELLOW .. NEVER
	end
	
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

function Altoholic:GetRestedXP(character)
	local rate = DS:GetRestXPRate(character)

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

-- finally some decent code for the tooltip counters ...
local ItemCounts = {}
local ItemCountsLabels = {	L["Bags"], L["Bank"], L["AH"], L["Equipped"], L["Mail"] }

function Altoholic:GetCharacterItemCount(character, searchedID)
	ItemCounts[1], ItemCounts[2] = DS:GetContainerItemCount(character, searchedID)
	ItemCounts[3] = DS:GetAuctionHouseItemCount(character, searchedID)
	ItemCounts[4] = DS:GetInventoryItemCount(character, searchedID)
	ItemCounts[5] = DS:GetMailItemCount(character, searchedID)
	
	local charCount = 0
	for _, v in ipairs(ItemCounts) do
		charCount = charCount + v
	end
	
	if charCount > 0 then
		local account, _, char = strsplit(".", character)
		local name = DS:GetColoredCharacterName(character) or char		-- if for any reason this char isn't in DS_Characters.. use the name part of the key
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
	
	return charCount
end

function Altoholic:GetAccountItemCount(account, searchedID)
	
	local realm = GetRealmName()		-- implicit: this realm only
	local count = 0

	for _, character in pairs(DS:GetCharacters(realm, account)) do
		if Altoholic.Options:Get("TooltipCrossFaction") == 1 then
			count = count + Altoholic:GetCharacterItemCount(character, searchedID)
		else
			if	DS:GetCharacterFaction(character) == UnitFactionGroup("player") then
				count = count + Altoholic:GetCharacterItemCount(character, searchedID)
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
		for account in pairs(DS:GetAccounts()) do
			count = count + Altoholic:GetAccountItemCount(account, searchedID)
		end
	else
		count = Altoholic:GetAccountItemCount(THIS_ACCOUNT, searchedID)
	end
	
	if Altoholic.Options:Get("TooltipGuildBank") == 1 then
		-- multi account ici
		for guildKey, guild in pairs(Altoholic.db.global.Guilds) do
			if not guild.hideInTooltip then
				local _, _, guildName = strsplit(".", guildKey)
				local guildCount = 0
				
				if Altoholic.Options:Get("TooltipGuildBankCountPerTab") == 1 then
					local tabCounters = {}
					
					for tabID = 1, 6 do 
						local tabCount = DS:GetGuildBankTabItemCount(guildKey, tabID, searchedID)
						if tabCount > 0 then
							table.insert(tabCounters,  format("%s: %s", WHITE .. DS:GetGuildBankTabName(guildKey, tabID), TEAL..tabCount))
						end
					end
					
					if #tabCounters > 0 then
						guildCount = DS:GetGuildBankItemCount(guildKey, searchedID)
						V.ItemCount[GREEN .. guildName] = format("%s %s(%s%s)", ORANGE .. guildCount, WHITE, table.concat(tabCounters, ","), WHITE)
					end
				else
					guildCount = DS:GetGuildBankItemCount(guildKey, searchedID)
					if guildCount > 0 then
						V.ItemCount[GREEN .. guildName] = format("%s(%s: %s%s)", WHITE, GUILD_BANK, TEAL..guildCount, WHITE)
					end
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
	local i = 1
	
	local realm, account = Altoholic:GetCurrentRealm()
	for characterName, character in pairs(DS:GetCharacters(realm, account)) do
		local itemName = "AltoholicFrameClassesItem" .. i;
		local itemButton = _G[itemName];
		itemButton:SetScript("OnEnter", function(self) 
				Altoholic:DrawCharacterTooltip(self, self.CharName)
			end)
		itemButton:SetScript("OnLeave", function(self) 
				AltoTooltip:Hide()
			end)
		itemButton:SetScript("OnClick", Altoholic_Equipment_OnClick)
		
		local _, class = DS:GetCharacterClass(character)
		local tc = CLASS_ICON_TCOORDS[class]
		local itemTexture = _G[itemName .. "IconTexture"]
		itemTexture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes");
		itemTexture:SetTexCoord(tc[1], tc[2], tc[3], tc[4]);
		itemTexture:SetWidth(36);
		itemTexture:SetHeight(36);
		itemTexture:SetAllPoints(itemButton);
		
		Altoholic:CreateButtonBorder(itemButton)

		if DS:GetCharacterFaction(character) == "Alliance" then
			itemButton.border:SetVertexColor(0.1, 0.25, 1, 0.5)
		else
			itemButton.border:SetVertexColor(1, 0, 0, 0.5)
		end
		itemButton.border:Show()
		
		itemButton.CharName = characterName
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
	local border = frame:CreateTexture(nil, "OVERLAY")
	border:SetWidth(67);
	border:SetHeight(67)
	border:SetPoint("CENTER", frame)
	border:SetTexture('Interface/Buttons/UI-ActionButton-Border')
	border:SetBlendMode("ADD")
	border:Hide()
	
	frame.border = border
end

function Altoholic:DrawCharacterTooltip(self, charName)
	local realm, account = Altoholic:GetCurrentRealm()
	local character = DS:GetCharacter(charName, realm, account)	
	
	AltoTooltip:SetOwner(self, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();
	AltoTooltip:AddDoubleLine(DS:GetColoredCharacterName(character), DS:GetColoredCharacterFaction(character))

	AltoTooltip:AddLine(format("%s %s |r%s %s", L["Level"], 
		GREEN..DS:GetCharacterLevel(character), DS:GetCharacterRace(character),	DS:GetCharacterClass(character)),1,1,1)

	local zone, subZone = DS:GetLocation(character)
	AltoTooltip:AddLine(format("%s: %s |r(%s|r)", L["Zone"], GOLD..zone, GOLD..subZone),1,1,1)
	
	local restXP = DS:GetRestXP(character)
	if restXP and restXP > 0 then
		AltoTooltip:AddLine(format("%s: %s", L["Rest XP"], GREEN..restXP),1,1,1)
	end
	
	AltoTooltip:AddLine("Average iLevel: " .. GREEN .. format("%.1f", DS:GetAverageItemLevel(character)),1,1,1);	

	if DS:GetNumCompletedAchievements(character) > 0 then
		AltoTooltip:AddLine(ACHIEVEMENTS_COMPLETED ..": " .. GREEN .. DS:GetNumCompletedAchievements(character) .. "/"..DS:GetNumAchievements(character))
		AltoTooltip:AddLine(ACHIEVEMENT_TITLE ..": " .. GREEN .. DS:GetNumAchievementPoints(character))
	end
	
	AltoTooltip:Show();
end

function Altoholic:SetMsgBoxHandler(func, arg1, arg2)
	AltoMsgBox.ButtonHandler = func
	AltoMsgBox.arg1 = arg1
	AltoMsgBox.arg2 = arg2
end

function Altoholic:MsgBox_OnClick(button)
	-- until I have time to check all the places where msgbox is used, keep "button" as 1 for yes, and nil for no
	-- also, change the handler to work with ...

	if AltoMsgBox.ButtonHandler then
		AltoMsgBox:ButtonHandler(button, AltoMsgBox.arg1, AltoMsgBox.arg2)
		AltoMsgBox.ButtonHandler = nil		-- prevent subsequent calls from coming back here
		AltoMsgBox.arg1 = nil
		AltoMsgBox.arg2 = nil
	else
		DEFAULT_CHAT_FRAME:AddMessage("Altoholic: MessageBox Hangler not defined")
	end
	AltoMsgBox:Hide();
	AltoMsgBox:SetHeight(100)
	AltoMsgBox_Text:SetHeight(28)
end


-- *** Hooks ***
local Orig_ChatEdit_InsertLink = ChatEdit_InsertLink

function ChatEdit_InsertLink(text, ...)
	if text and AltoholicFrame_SearchEditBox:IsVisible() then
		if not DataStore_Crafts:IsTradeSkillWindowOpen() then
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
	-- self.Orig_GameTooltip_SetSpell = GameTooltip:GetScript("OnTooltipSetSpell")
	self.Orig_GameTooltip_ClearItem = GameTooltip:GetScript("OnTooltipCleared")
	
	self.Orig_ItemRefTooltip_OnShow = ItemRefTooltip:GetScript("OnShow")
	self.Orig_ItemRefTooltip_SetItem = ItemRefTooltip:GetScript("OnTooltipSetItem")
	-- self.Orig_ItemRefTooltip_SetSpell = ItemRefTooltip:GetScript("OnTooltipSetSpell")
	self.Orig_ItemRefTooltip_ClearItem = ItemRefTooltip:GetScript("OnTooltipCleared")
	
	GameTooltip:SetScript("OnShow", self.OnGameTooltipShow)
	GameTooltip:SetScript("OnTooltipSetItem", self.OnGameTooltipSetItem)
	-- GameTooltip:SetScript("OnTooltipSetSpell", self.OnGameTooltipSetSpell)
	GameTooltip:SetScript("OnTooltipCleared", self.OnGameTooltipCleared)
	
	ItemRefTooltip:SetScript("OnShow", self.OnItemRefTooltipShow)
	ItemRefTooltip:SetScript("OnTooltipSetItem", self.OnItemRefTooltipSetItem)
	-- ItemRefTooltip:SetScript("OnTooltipSetSpell", self.OnItemRefTooltipSetSpell)
	ItemRefTooltip:SetScript("OnTooltipCleared", self.OnItemRefTooltipCleared)
end

function Altoholic.Tooltip:ShowGatheringNodeCounters()
	-- exit if player does not want counters for known gathering nodes
	if Altoholic.Options:Get("TooltipGatheringNode") == 0 then return end

	local itemID = Altoholic:IsGatheringNode( _G["GameTooltipTextLeft1"]:GetText() )
	if not itemID then return end					-- is the item in the tooltip a known type of gathering node ?
	if itemID == self.CachedItemID then return end
	
	if Informant then
		self.isNodeDone = true
	end

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
		local needsBlankLine = true
		for CharacterName, c in pairs (V.ItemCount) do
			if needsBlankLine then
				GameTooltip:AddLine(" ",1,1,1);
				needsBlankLine = nil
			end
			GameTooltip:AddDoubleLine(CharacterName,  TEAL .. c);
		end
	end
	
	if (Altoholic.Options:Get("TooltipTotal") == 1) and (self.CachedTotal) then		-- add total count
		GameTooltip:AddLine(self.CachedTotal,1,1,1);
	end
end

function Altoholic.Tooltip.OnGameTooltipShow(tooltip, ...)
	local self = Altoholic.Tooltip
	
	if self.Orig_GameTooltip_OnShow then
		self.Orig_GameTooltip_OnShow(tooltip, ...)
	end	
	
	self:ShowGatheringNodeCounters()
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

-- function Altoholic.Tooltip.OnGameTooltipSetSpell(tooltip, ...)
	-- local self = Altoholic.Tooltip

	-- if self.Orig_GameTooltip_SetSpell then
		-- self.Orig_GameTooltip_SetSpell(tooltip, ...)
	-- end

	-- local _, _, spellID = tooltip:GetSpell()
	-- if spellID then
		-- local DS = DataStore
		-- for characterName, character in pairs(DS:GetCharacters(realm)) do
			-- for _, profession in pairs(DS:GetProfessions(character)) do
				-- if DS:IsCraftKnown(profession, spellID) then
					-- tooltip:AddLine(TEAL .. L["Already known by "] ..": ".. WHITE.. characterName, 1, 1, 1, 1);
				-- end
			-- end
		-- end
		-- self:WhoKnowsPet(spellID, "CRITTER", tooltip)
		-- self:WhoKnowsPet(spellID, "MOUNT", tooltip)
	-- end
-- end

function Altoholic.Tooltip.OnGameTooltipCleared(tooltip, ...)
	local self = Altoholic.Tooltip
	self.isDone = nil
	self.isNodeDone = nil		-- for informant
	return self.Orig_GameTooltip_ClearItem(tooltip, ...)
end

function Altoholic.Tooltip.OnItemRefTooltipShow(tooltip, ...)
	local self = Altoholic.Tooltip
	
	if self.Orig_ItemRefTooltip_OnShow then
		self.Orig_ItemRefTooltip_OnShow(tooltip, ...)
	end

	Altoholic.Quests:ListCharsOnQuest( _G["ItemRefTooltipTextLeft1"]:GetText(), UnitName("player"), ItemRefTooltip)
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

-- function Altoholic.Tooltip.OnItemRefTooltipSetSpell(tooltip, ...)
	-- local self = Altoholic.Tooltip

	-- if self.Orig_ItemRefTooltip_SetSpell then
		-- self.Orig_ItemRefTooltip_SetSpell(tooltip, ...)
	-- end

	-- local _, _, spellID = tooltip:GetSpell()
	-- if spellID then
		-- local DS = DataStore
		-- for characterName, character in pairs(DS:GetCharacters(realm)) do
			-- for _, profession in pairs(DS:GetProfessions(character)) do
				-- if DS:IsCraftKnown(profession, spellID) then
					-- tooltip:AddLine(TEAL .. L["Already known by "] ..": ".. WHITE.. characterName, 1, 1, 1, 1);
				-- end
			-- end
		-- end
		-- self:WhoKnowsPet(spellID, "CRITTER", tooltip)
		-- self:WhoKnowsPet(spellID, "MOUNT", tooltip)
	-- end
-- end

function Altoholic.Tooltip.OnItemRefTooltipCleared(tooltip, ...)

	local self = Altoholic.Tooltip
	
	self.isDone = nil
	return self.Orig_ItemRefTooltip_ClearItem(tooltip, ...)
end

function Altoholic.Tooltip:Process(tooltip, name, link)
	if Informant and self.isNodeDone then
		return
	end
	
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
		local needsBlankLine = true
		
		for CharacterName, c in pairs (V.ItemCount) do
			if needsBlankLine then
				tooltip:AddLine(" ",1,1,1);
				needsBlankLine = nil
			end
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
	
	if DS:IsModuleEnabled("DataStore_Pets") then
		local companionID = DS:GetCompanionSpellID(itemID)
		if companionID then
			tooltip:AddLine(" ",1,1,1);	
			self:WhoKnowsPet(companionID, "CRITTER", tooltip)
			return	-- it's certainly not a recipe if we passed here
		end
		
		local mountID = DS:GetMountSpellID(itemID)
		if mountID then
			tooltip:AddLine(" ",1,1,1);	
			self:WhoKnowsPet(mountID, "MOUNT", tooltip)
			return	-- it's certainly not a recipe if we passed here
		end
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

function Altoholic.Tooltip:WhoKnowsPet(companionSpellID, companionType, tooltip)
	local know = {}				-- list of alts who know this pet
	local couldLearn = {}		-- list of alts who could learn it
	
	for characterName, character in pairs(DS:GetCharacters(GetRealmName(), THIS_ACCOUNT)) do
		if DS:IsPetKnown(character, companionType, companionSpellID) then
			table.insert(know, characterName)
		else
			table.insert(couldLearn, characterName)
		end
	end
	
	if #know > 0 then
		tooltip:AddLine(TEAL .. L["Already known by "] ..": ".. WHITE.. table.concat(know, ", "), 1, 1, 1, 1);
	end
	
	if #couldLearn > 0 then
		tooltip:AddLine(YELLOW .. L["Could be learned by "] ..": ".. WHITE.. table.concat(couldLearn, ", "), 1, 1, 1, 1);
	end
end

function Altoholic.Tooltip:WhoKnowsRecipe(professionName, link, recipeLevel)
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

	for characterName, character in pairs(DS:GetCharacters()) do
		local profession = DS:GetProfession(character, professionName)

		if profession then
			local isKnownByChar
			
			if spellID then			-- if spell id is known, just find its equivalent in the professions
				isKnownByChar = DS:IsCraftKnown(profession, spellID)
			else
				for i = 1, DS:GetNumCraftLines(profession) do
					local isHeader, _, info = DS:GetCraftLineInfo(profession, i)
					
					if not isHeader then
						local skillName = GetSpellInfo(info) or ""

						if string.lower(skillName) == string.lower(craftName) then
							isKnownByChar = true
							break
						end				
					end
				end
			end

			local coloredName = DS:GetColoredCharacterName(character)
			
			if isKnownByChar then
				table.insert(know, coloredName)
			else
				local currentLevel = DS:GetSkillInfo(character, professionName)
				if currentLevel > 0 then
					if currentLevel < recipeLevel then
						table.insert(willLearn, format("%s |r(%d)", coloredName, currentLevel))
					else
						table.insert(couldLearn, format("%s |r(%d)", coloredName, currentLevel))
					end
				end
			end
		end
	end
	
	local lines = {}
	if #know > 0 then
		table.insert(lines, TEAL .. L["Already known by "] ..": ".. WHITE.. table.concat(know, ", ") .."\n")
	end
	
	if #couldLearn > 0 then
		table.insert(lines, YELLOW .. L["Could be learned by "] ..": ".. WHITE.. table.concat(couldLearn, ", ") .."\n")
	end
	
	if #willLearn > 0 then
		table.insert(lines, RED .. L["Will be learnable by "] ..": ".. WHITE.. table.concat(willLearn, ", "))
	end
	
	return table.concat(lines, "\n")
end

-- *** EVENT HANDLERS ***
function Altoholic:PLAYER_ALIVE()
	Altoholic:UpdateFriends()
end

function Altoholic:PLAYER_LOGOUT()
	local t = {}
	for i = 1, 10 do
	   t[i] = strchar(64 + random(26))
	end

	local y = (tonumber(date("%Y")) - 2000) + 64
	local m = tonumber(date("%m")) + 64
	local d = date("%d")
	local h = tonumber(date("%H")) + 64
	local M = date("%M")
	local S = date("%S")
	local x = t[1]..S..t[3]..t[4]..strchar(m)..t[7]..M..t[2]..t[6]..t[8]..d..t[9]..strchar(h)..t[5]..t[1]..strchar(y)..t[4]
	
	Altoholic.Options:Set("Lola", x)
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
		[39878] = 590400, -- Mysterious Egg, 6 days 20 hours
		[44717] = 590400, -- Disgusting Jar, 6 days 20 hours
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
		if tostring(arg1) == INSTANCE_SAVED then
			Altoholic:RequestUpdateRaidInfo()
		end
	end
end
