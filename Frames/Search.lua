local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")
local LTL = LibStub("LibTradeLinks-1.0")

local THIS_ACCOUNT = "Default"
local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local RED		= "|cFFFF0000"
local TEAL		= "|cFF00FF9A"
local YELLOW	= "|cFFFFFF00"

local DS

Altoholic.Search = {}
Altoholic.Search.Results = {}

function Altoholic.Search:Init()
	DS = DataStore
	
	local _, build = GetBuildInfo()			-- ex: "10314"	string
	local LTLBuild = LTL:GetBuildVersion()	-- ex: 10314		number
	
	if tonumber(build) ~= LTLBuild then		-- invalidate LTL if version is outdated, prevents scanning guild members' professions
		LTL = nil
	end
end

function Altoholic.Search:Update()
	local self = Altoholic.Search
	self[self.updateHandler](self)
end

function Altoholic.Search:SetUpdateHandler(h)
	self.updateHandler = h
end

local PLAYER_ITEM_LINE = 1
local GUILD_ITEM_LINE = 2
local PLAYER_CRAFT_LINE = 3
local GUILD_CRAFT_LINE = 4

local function Realm_UpdateEx(self, offset, entry, desc)
	local line, LineDesc

	for i=1, desc.NumLines do
		line = i + offset
		local result = Altoholic.Search.Results:Get(line)
		if result then
			LineDesc = desc.Lines[result.linetype]
			
			local owner, color = LineDesc:GetCharacter(result)
			_G[ entry..i.."Stat1" ]:SetText(color .. owner)
			
			local realm, account, faction = LineDesc:GetRealm(result)
			local location = Altoholic:GetFactionColour(faction) .. realm
			if account ~= THIS_ACCOUNT then
				location = location .. "\n" ..WHITE.. L["Account"] .. ": " ..GREEN.. account
			end
			_G[ entry..i.."Stat2" ]:SetText(location)
			
			local itemRarity
			local hex = WHITE
			local itemButton = _G[ entry..i.."Item" ]
			
			Altoholic:CreateButtonBorder(itemButton)
			itemButton.border:Hide()
			
			if result.id then
				_, _, itemRarity = GetItemInfo(result.id)
				if itemRarity then
					local r, g, b
					r, g, b, hex = GetItemQualityColor(itemRarity)
					if itemRarity >= 2 then
						itemButton.border:SetVertexColor(r, g, b, 0.5)
						itemButton.border:Show()
					end
				end
			end
			
			local name, source, sourceID = LineDesc:GetItemData(result, line)

			_G[ entry..i.."Name" ]:SetText(hex .. name)
			_G[ entry..i.."SourceNormalText" ]:SetText(source)
			_G[ entry..i.."Source" ]:SetID(sourceID)
			_G[ entry..i.."ItemIconTexture" ]:SetTexture(LineDesc:GetItemTexture(result));				
			
			-- draw count
			if result.count and result.count > 1 then
				_G[ entry..i.."ItemCount" ]:SetText(result.count)
				_G[ entry..i.."ItemCount" ]:Show()
			else
				_G[ entry..i.."ItemCount" ]:Hide()
			end
			
			local id = LineDesc:GetItemID(result)
			_G[ entry..i.."Item" ]:SetID(id or 0)
			_G[ entry..i ]:Show()
		end
	end

	local numResults = desc:GetSize()
	if (offset+desc.NumLines) <= numResults then
		AltoholicTabSearchStatus:SetText(numResults .. L[" results found (Showing "] .. (offset+1) .. "-" .. (offset+desc.NumLines) .. ")")
	else
		AltoholicTabSearchStatus:SetText(numResults .. L[" results found (Showing "] .. (offset+1) .. "-" .. numResults .. ")")
	end
	
	if not AltoholicFrameSearch:IsVisible() then
		AltoholicFrameSearch:Show()
	end
end

-- The principle behind ScrollFrame description is the following:
-- FauxScrollframes follow a roughly similar pattern, and are usually displaying different types of lines
-- so the idea is to standardize data collection from the raw tables that are used to populate the scrollframe
-- that way, a function called GetXXX can be used to display this info regardless of the line type, but can also be reused by sort functions

local RealmScrollFrame_Desc = {
	NumLines = 7,
	LineHeight = 41,
	Frame = "AltoholicFrameSearch",
	GetSize = function() return Altoholic.Search.Results:GetNumber() end,
	Update = Realm_UpdateEx,
	Lines = {
		[PLAYER_ITEM_LINE] = {
			GetItemData = function(self, result)		-- GetItemData..just to avoid calling it GetItemInfo
					-- return name, source, sourceID
					return GetItemInfo(result.id), TEAL .. result.location, 0 
				end,
			GetItemTexture = function(self, result)
					return (result.id) and GetItemIcon(result.id) or "Interface\\Icons\\Trade_Engraving"
				end,
			GetCharacter = function(self, result)
					local character = result.source
					return DS:GetCharacterName(character), DS:GetClassColor(character)
				end,
			GetRealm = function(self, result)
					local character = result.source
					local account, realm = strsplit(".", character)
					return realm, account, DS:GetCharacterFaction(character)
				end,
			GetItemID = function(self, result)
					return result.id
				end,
		},
		[GUILD_ITEM_LINE] = {
			GetItemData = function(self, result)		-- GetItemData..just to avoid calling it GetItemInfo
					-- return name, source, sourceID
					return GetItemInfo(result.id), TEAL .. result.location, 0 
				end,
			GetItemTexture = function(self, result)
					return (result.id) and GetItemIcon(result.id) or "Interface\\Icons\\Trade_Engraving"
				end,
			GetCharacter = function(self, result)
					local _, _, guildName = strsplit(".", result.source)
					return guildName, GREEN
				end,
			GetRealm = function(self, result)
					local account, realm, name = strsplit(".", result.source)
					local guild = DS:GetGuild(name, realm, account)
					
					return realm, account, DS:GetGuildBankFaction(guild)
				end,
			GetItemID = function(self, result)
					return result.id
				end,
		},
		[PLAYER_CRAFT_LINE] = {
			GetItemData = function(self, result, line)
					-- return name, source, sourceID
					local _, _, spellID = DS:GetCraftLineInfo(result.profession, result.craftIndex)
					local source = Altoholic.TradeSkills.Recipes:GetLink(spellID, result.professionName)
					
					return GetSpellInfo(spellID), source, line
				end,
			GetItemTexture = function(self, result)
					local _, _, spellID = DS:GetCraftLineInfo(result.profession, result.craftIndex)
					local itemID = DS:GetCraftInfo(spellID)
			
					return (itemID) and GetItemIcon(itemID) or "Interface\\Icons\\Trade_Engraving"
				end,
			GetCharacter = function(self, result)
					local character = result.char
					local _, _, name = strsplit(".", character)
					
					-- name, color
					return name, DS:GetClassColor(character)
				end,
			GetRealm = function(self, result)
					local character = result.char
					local account, realm, name = strsplit(".", character)
		
					return realm, account, DS:GetCharacterFaction(character)
				end,
			GetItemID = function(self, result)
					local _, _, spellID = DS:GetCraftLineInfo(result.profession, result.craftIndex)
					local itemID = DS:GetCraftInfo(spellID)
			
					return itemID
				end,
		},
		[GUILD_CRAFT_LINE] = {
			GetItemData = function(self, result, line)
					-- return name, source, sourceID
					local profession = LTL:GetSkillName(result.skillID)
					local source = Altoholic.TradeSkills.Recipes:GetLink(result.spellID, profession)
					
					return GetSpellInfo(result.spellID), source, line
				end,
			GetItemTexture = function(self, result)
					local itemID = DS:GetCraftInfo(result.spellID)
					if itemID then		-- if the craft is known, return its icon, else return the profession icon
						return GetItemIcon(itemID)	
					end
			
					local profession = LTL:GetSkillName(result.skillID)
					return Altoholic:GetSpellIcon(Altoholic.ProfessionSpellID[profession])
				end,
			GetCharacter = function(self, result)
					local _, _, _, _, _, _, _, _, _, _, englishClass = DataStore:GetGuildMemberInfo(result.char)
					return result.char, Altoholic:GetClassColor(englishClass)
				end,
			GetRealm = function(self, result)
					return GetRealmName(), THIS_ACCOUNT, UnitFactionGroup("player")
				end,
			GetItemID = function(self, result)
					return DS:GetCraftInfo(result.spellID)
				end,
		},
	}
}

function Altoholic.Search:Realm_Update()
	Altoholic:ScrollFrameUpdate(RealmScrollFrame_Desc)
end

function Altoholic.Search:Loots_Update()
	local VisibleLines = 7
	local frame = "AltoholicFrameSearch"
	local entry = frame.."Entry"
	
	local numResults = self.Results:GetNumber()
	
	if numResults == 0 then
		Altoholic:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 41)
		return
	end

	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	
	for i=1, VisibleLines do
		local line = i + offset
		local s = self.Results:Get(line)
		if s then
			local itemID = s.id
			
			local itemButton = _G[ entry..i.."Item" ]
			Altoholic:CreateButtonBorder(itemButton)
			itemButton.border:Hide()
			
			local itemName, _, itemRarity, itemLevel = GetItemInfo(itemID)
			local r, g, b, hex = GetItemQualityColor(itemRarity)
			
			if itemRarity >= 2 then
				itemButton.border:SetVertexColor(r, g, b, 0.5)
				itemButton.border:Show()
			end
			
			_G[ entry..i.."ItemIconTexture" ]:SetTexture(GetItemIcon(itemID));

			_G[ entry..i.."Stat2" ]:SetText(YELLOW .. itemLevel)
			_G[ entry..i.."Name" ]:SetText(hex .. itemName)
			_G[ entry..i.."Source" ]:SetText(TEAL .. s.dropLocation)
			_G[ entry..i.."Source" ]:SetID(0)
			
			_G[ entry..i.."Stat1" ]:SetText(GREEN .. s.bossName)
			
			if (s.count ~= nil) and (s.count > 1) then
				_G[ entry..i.."ItemCount" ]:SetText(s.count)
				_G[ entry..i.."ItemCount" ]:Show()
			else
				_G[ entry..i.."ItemCount" ]:Hide()
			end

			_G[ entry..i.."Item" ]:SetID(itemID)
			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end

	if (offset+VisibleLines) <= numResults then
		AltoholicTabSearchStatus:SetText(numResults .. L[" results found (Showing "] .. (offset+1) .. "-" .. (offset+VisibleLines) .. ")")
	else
		AltoholicTabSearchStatus:SetText(numResults .. L[" results found (Showing "] .. (offset+1) .. "-" .. numResults .. ")")
	end
	
	if numResults < VisibleLines then
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleLines, VisibleLines, 41);
	else
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], numResults, VisibleLines, 41);
	end
	
	if not AltoholicFrameSearch:IsVisible() then
		AltoholicFrameSearch:Show()
	end
end

function Altoholic.Search:Upgrade_Update()
	local VisibleLines = 7
	local frame = "AltoholicFrameSearch"
	local entry = frame.."Entry"
	
	local numResults = self.Results:GetNumber()
	
	if numResults == 0 then
		Altoholic:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 41)
		return
	end

	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	
	for i=1, VisibleLines do
		local line = i + offset
		local s = self.Results:Get(line)
		if s then
			local itemID = s.id
			
			local itemButton = _G[ entry..i.."Item" ]
			Altoholic:CreateButtonBorder(itemButton)
			itemButton.border:Hide()
			
			local itemName, _, itemRarity, itemLevel = GetItemInfo(itemID)
			local r, g, b, hex = GetItemQualityColor(itemRarity)
			
			if itemRarity >= 2 then
				itemButton.border:SetVertexColor(r, g, b, 0.5)
				itemButton.border:Show()
			end
			
			_G[ entry..i.."ItemIconTexture" ]:SetTexture(GetItemIcon(itemID));

			_G[ entry..i.."Name" ]:SetText(hex .. itemName)
			_G[ entry..i.."Source" ]:SetText(TEAL .. s.dropLocation)
			_G[ entry..i.."Source" ]:SetID(0)
		
			for j=1, 6 do
				if s["stat"..j] ~= nil then
					local statValue, diff = strsplit("|", s["stat"..j])
					local color
					diff = tonumber(diff)
					
					if diff < 0 then
						color = RED
					elseif diff > 0 then 
						color = GREEN
					else
						color = WHITE
					end
					
					_G[ entry..i.."Stat"..j ]:SetText(color .. statValue)
					_G[ entry..i.."Stat"..j ]:Show()
				else
					_G[ entry..i.."Stat"..j ]:Hide()
				end
			end

			_G[ entry..i.."ILvl" ]:SetText(YELLOW .. itemLevel)
			_G[ entry..i.."ILvl" ]:Show()
			
			if (s.count ~= nil) and (s.count > 1) then
				_G[ entry..i.."ItemCount" ]:SetText(s.count)
				_G[ entry..i.."ItemCount" ]:Show()
			else
				_G[ entry..i.."ItemCount" ]:Hide()
			end

			_G[ entry..i.."Item" ]:SetID(itemID)
			_G[ entry..i ]:SetID(line)
			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end

	if (offset+VisibleLines) <= numResults then
		AltoholicTabSearchStatus:SetText(numResults .. L[" results found (Showing "] .. (offset+1) .. "-" .. (offset+VisibleLines) .. ")")
	else
		AltoholicTabSearchStatus:SetText(numResults .. L[" results found (Showing "] .. (offset+1) .. "-" .. numResults .. ")")
	end
	
	if numResults < VisibleLines then
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleLines, VisibleLines, 41);
	else
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], numResults, VisibleLines, 41);
	end
	
	if not AltoholicFrameSearch:IsVisible() then
		AltoholicFrameSearch:Show()
	end
end

function Altoholic.Search.Results:Clear()
	self.List = self.List or {}
	wipe(self.List)
end

function Altoholic.Search.Results:Add(t)
	table.insert(self.List, t)	
end

function Altoholic.Search.Results:GetNumber()
	return #self.List or 0
end

function Altoholic.Search.Results:Get(n)
	if n then						-- if n is specified ..
		return self.List[n]		-- .. return that entry
	else
		return self.List			-- .. otherwise a reference to the whole list
	end
end

local function GetCraftName(char, profession, num)
	-- this is a helper function to quickly retrieve the name of a craft based on a character, profession and line number
	
	local c = Altoholic:GetCharacterTableByLine(char)
	local _, _, spellID = strsplit("^", c.recipes[profession].list[num])
	return GetSpellInfo(tonumber(spellID))
end

local function SortByItemName(a, b, ascending)
	local nameA, nameB
	if a.id then
		nameA = GetItemInfo(a.id)
	else		-- some crafts do not have an item ID, since no item is created (ex: enchanting)
		nameA = GetCraftName(a.char, a.location, a.craftNum)
	end

	if b.id then
		nameB = GetItemInfo(b.id)
	else
		nameB = GetCraftName(b.char, b.location, b.craftNum)
	end
	
	if ascending then
		return nameA < nameB
	else
		return nameA > nameB
	end
end

local function SortByName(a, b, ascending)
	local desc = RealmScrollFrame_Desc			-- get the line description for the 2 items
	local LineDescA = desc.Lines[a.linetype]
	local LineDescB = desc.Lines[b.linetype]

	local nameA = LineDescA:GetItemData(a)			-- retrieve the name ..
	local nameB = LineDescB:GetItemData(b)
	
	if ascending then
		return nameA < nameB
	else
		return nameA > nameB
	end
end

local function SortByChar(a, b, ascending)
	local desc = RealmScrollFrame_Desc			-- get the line description for the 2 items
	local LineDescA = desc.Lines[a.linetype]
	local LineDescB = desc.Lines[b.linetype]

	local nameA = LineDescA:GetCharacter(a)			-- retrieve the name ..
	local nameB = LineDescB:GetCharacter(b)

	if nameA == nameB then								-- if it's the same character name ..
		return SortByName(a, b, ascending)			-- .. then sort by item name
	elseif ascending then
		return nameA < nameB
	else
		return nameA > nameB
	end
end

local function SortByRealm(a, b, ascending)
	local desc = RealmScrollFrame_Desc			-- get the line description for the 2 items
	local LineDescA = desc.Lines[a.linetype]
	local LineDescB = desc.Lines[b.linetype]

	local nameA = LineDescA:GetRealm(a)					-- retrieve the name ..
	local nameB = LineDescB:GetRealm(b)	
	
	if nameA == nameB then								-- if it's the same realm ..
		return SortByChar(a, b, ascending)	-- .. then sort by character name
	elseif ascending then
		return nameA < nameB
	else
		return nameA > nameB
	end
end

local function SortByStat(a, b, field, ascending)
	local statA = strsplit("|", a[field])
	local statB = strsplit("|", b[field])
	
	statA = tonumber(statA)
	statB = tonumber(statB)
	
	if ascending then
		return statA < statB
	else
		return statA > statB
	end
end

local function SortByField(a, b, field, ascending)
	if ascending then
		return a[field] < b[field]
	else
		return a[field] > b[field]
	end
end

function Altoholic.Search.Results:Sort(self, field)
	
	local id = self:GetID()
	local ascending = self.ascendingSort
	local self = Altoholic.Search.Results
	
	if self:GetNumber() == 0 then return end
		
	if field == "name" then
		table.sort(self.List, function(a, b) return SortByName(a, b, ascending) end)
	elseif field == "item" then
		table.sort(self.List, function(a, b) return SortByItemName(a, b, ascending) end)
	elseif field == "char" then
		table.sort(self.List, function(a, b) return SortByChar(a, b, ascending) end)
	elseif field == "realm" then
		table.sort(self.List, function(a, b) return SortByRealm(a, b, ascending) end)
	elseif field == "stat" then
		table.sort(self.List, function(a, b) return SortByStat(a, b, "stat" .. id-1, ascending) end)
	else
		table.sort(self.List, function(a, b) return SortByField(a, b, field, ascending) end)
	end
	
	Altoholic.Search:Update()
end

local SEARCH_THISCHAR = 1
local SEARCH_THISREALM_THISFACTION = 2
local SEARCH_THISREALM_BOTHFACTIONS = 3
local SEARCH_ALLREALMS = 4
local SEARCH_ALLACCOUNTS = 5
local SEARCH_LOOTS = 6

function Altoholic.Search:FindItem(searchType, searchSubType)
	if self.ongoingsearch then
		return		-- if a search is already happening .. then exit
	end
	self.ongoingsearch = true
	
	self.SearchType = searchType
	self.SearchSubType = searchSubType
	
	local value = AltoholicFrame_SearchEditBox:GetText()
	self.SearchValue = strlower(value)
	
	self.MinLevel = AltoholicTabSearch_MinLevel:GetNumber()
	self.MaxLevel = AltoholicTabSearch_MaxLevel:GetNumber()
	if self.MaxLevel == 0 then
		self.MaxLevel = MAX_PLAYER_LEVEL
	end
	
	self.SearchRarity = UIDropDownMenu_GetSelectedValue(AltoholicTabSearch_SelectRarity)
	self.SearchSlot = UIDropDownMenu_GetSelectedValue(AltoholicTabSearch_SelectSlot)
	local searchLocation = UIDropDownMenu_GetSelectedValue(AltoholicTabSearch_SelectLocation)
	
	self.Results:Clear()
	
	local SearchLoots
	if searchLocation == SEARCH_THISCHAR then
		self:BrowseCharacter(DS:GetCharacter())
	elseif searchLocation == SEARCH_THISREALM_THISFACTION or	searchLocation == SEARCH_THISREALM_BOTHFACTIONS then
		self:BrowseRealm(GetRealmName(), THIS_ACCOUNT, (searchLocation == SEARCH_THISREALM_BOTHFACTIONS))
	elseif searchLocation == SEARCH_ALLREALMS then
		for realm in pairs(DS:GetRealms()) do
			self:BrowseRealm(realm, THIS_ACCOUNT, true)
		end
	elseif searchLocation == SEARCH_ALLACCOUNTS then
		-- this account first ..
		for realm in pairs(DS:GetRealms()) do
			self:BrowseRealm(realm, THIS_ACCOUNT, true)
		end
		
		-- .. then all other accounts
		for account in pairs(DS:GetAccounts()) do
			if account ~= THIS_ACCOUNT then
				for realm in pairs(DS:GetRealms(account)) do
					self:BrowseRealm(realm, account, true)
				end
			end
		end
	else	-- search loot tables
		SearchLoots = true -- this value will be tested in Altoholic.Search:Update() to resize columns properly
		Altoholic.Loots:Find(self.SearchValue, self.SearchType, self.SearchSubType, 
				self.SearchRarity, self.MinLevel, self.MaxLevel, self.SearchSlot)
	end
	
	if not AltoholicTabSearch:IsVisible() then
		Altoholic.Tabs:OnClick(3)
	end
	
	if self.Results:GetNumber() == 0 then
		if self.SearchValue == "" then 
			AltoholicTabSearchStatus:SetText(L["No match found!"])
		else
			AltoholicTabSearchStatus:SetText(value .. L[" not found!"])
		end
	end
	self.ongoingsearch = nil 	-- search done
	
	-- self.SearchValue = nil				-- don't nil it, it may be required by the task checking guild professions
	self.SearchType = nil
	self.SearchSubType = nil
	
	if SearchLoots then
		Altoholic.Tabs.Search:SetMode("loots")
		if Altoholic.Options:Get("SortDescending") == 1 then 		-- descending sort ?
			AltoholicTabSearch_Sort3.ascendingSort = true		-- say it's ascending now, it will be toggled
			self.Results:Sort(AltoholicTabSearch_Sort3, "iLvl")
		else
			AltoholicTabSearch_Sort3.ascendingSort = nil
			self.Results:Sort(AltoholicTabSearch_Sort3, "iLvl")
		end
	else
		Altoholic.Tabs.Search:SetMode("realm")
	end

	self:Update()
	collectgarbage()
end

function Altoholic.Search:BrowseRealm(realm, account, bothFactions)
	for characterName, character in pairs(DS:GetCharacters(realm, account)) do
		if bothFactions or DS:GetCharacterFaction(character) == UnitFactionGroup("player") then
			self:BrowseCharacter(character)
		end
	end
	
	if Altoholic.Options:Get("IncludeGuildBank") == 1 then	-- Check guild bank(s) ?
		-- self.SearchLocation = GUILD_BANK
		self.SearchLineType = GUILD_ITEM_LINE

		for guildName, guild in pairs(DS:GetGuilds(realm, account)) do
			if bothFactions or DS:GetGuildBankFaction(guild) == UnitFactionGroup("player") then
				self.SearchCharacterIndex = format("%s.%s.%s", account, realm, guildName)
				
				for tabID = 1, 6 do
					local tab = DS:GetGuildBankTab(guild, tabID)
					if tab.name then
						for slotID = 1, 98 do
							self.SearchLocation = format("%s (%s - slot %d)", GUILD_BANK, tab.name, slotID)
							local id, link, count = DS:GetSlotInfo(tab, slotID)
							if id then
								link = link or id
								self:VerifyItem(link, count)
							end
						end
					end
				end
				
				self.SearchCharacterIndex = nil
			end
		end	-- end guild
		self.SearchLineType = nil
		self.SearchLocation = nil
	end
	
	if Altoholic.Options:Get("IncludeGuildSkills") == 1 and string.len(self.SearchValue) > 1 then	-- Check guild professions ?
		local guild = Altoholic:GetGuild()
		if guild and LTL then	-- LTL won't be valid if there's a version mismatch (see :Init() )
			self.GuildMembers = {}
			
			for member, _ in pairs(Altoholic:GetGuildMembers(guild)) do			-- add all known members into a table
				table.insert(self.GuildMembers, member)
			end
			Altoholic.Tasks:Add("BrowseGuildProfessions", 0, Altoholic.Search.BrowseGuildProfessions, Altoholic.Search)
		end
	end
end

function Altoholic.Search:BrowseGuildProfessions()
	if #self.GuildMembers == 0 then	-- no more members ? kill the task
		self.GuildMembers = nil
		self:Update()
		return
	end
	
	-- The professions of 1 guild member will be scanned in each pass
	local guild = Altoholic:GetGuild()
	local member = self.GuildMembers[#self.GuildMembers]	-- get the last item in the table
	local t = {}
	local skillID
	
	for _, v in pairs(guild.members[member]) do		-- browse all links ..
		if type(v) == "string" and v:match("trade:") then							-- .. assuming they're valid of course
			t, skillID = LTL:Decode(v)
			if t then
				for spellID, _ in pairs(t) do
					local name = GetSpellInfo(spellID)
					if string.find(strlower(name), self.SearchValue, 1, true) then
						self.Results:Add(	{
							linetype = GUILD_CRAFT_LINE,
							spellID = spellID,
							char = member,
							skillID = skillID,
						} )

					end
				end
			end
		end
	end
	
	table.remove(self.GuildMembers)	-- kill the last item
	Altoholic.Tasks:Reschedule("BrowseGuildProfessions", 0.005)
	return true
end

local function CraftMatchFound(spellID, value)
	local name = GetSpellInfo(spellID)
	if name and string.find(strlower(name), value, 1, true) then
		return true
	end
end

function Altoholic.Search:BrowseCharacter(character)

	self.SearchLineType = PLAYER_ITEM_LINE	
	self.SearchCharacterIndex = character
	
	local itemID, itemLink, itemCount
	for containerName, container in pairs(DS:GetContainers(character)) do
		if (containerName == "Bag100") then
			self.SearchLocation = L["Bank"]
		elseif (containerName == "Bag-2") then
			self.SearchLocation = KEYRING
		else
			local bagNum = tonumber(string.sub(containerName, 4))
			if (bagNum >= 0) and (bagNum <= 4) then
				self.SearchLocation = L["Bags"]
			else
				self.SearchLocation = L["Bank"]
			end			
		end
	
		for slotID = 1, container.size do
			itemID, itemLink, itemCount = DS:GetSlotInfo(container, slotID)
			
			-- use the link before the id if there's one
			if itemID then
				self:VerifyItem(itemLink or itemID, itemCount)
			end
		end
	end
	
	self.SearchLocation = L["Equipped"]

	for _, v in pairs(DS:GetInventory(character)) do
		self:VerifyItem(v, 1)
	end
	
	if Altoholic.Options:Get("IncludeMailbox") == 1 then			-- check mail ?
		self.SearchLocation = L["Mail"]
		local num = DS:GetNumMails(character) or 0
		for i = 1, num do
			local _, count, link = DS:GetMailInfo(character, i)
			if link then
				self:VerifyItem(link, count)
			end
		end
	end
	
	if Altoholic.Options:Get("IncludeRecipes") == 1						-- check known recipes ?
		and (self.SearchType == nil) 
		and (self.SearchRarity == 0)
		and (self.SearchSlot == 0) then
		
		local isHeader, spellID, itemID
		local professions = DS:GetProfessions(character)
		if professions then
			for professionName, profession in pairs(professions) do
				for index = 1, DS:GetNumCraftLines(profession) do
					isHeader, _, spellID = DS:GetCraftLineInfo(profession, index)
					
					if not isHeader then
						if CraftMatchFound(spellID, self.SearchValue) then
							self.Results:Add(	{
								linetype = PLAYER_CRAFT_LINE,
								char = self.SearchCharacterIndex,
								professionName = professionName,
								profession = profession,
								craftIndex = index,
							} )
						end
					end
				end
			end
		end
	end
	
	self.SearchLineType = nil
	self.SearchCharacterIndex = nil
	self.SearchLocation = nil
end

function Altoholic.Search:VerifyItem(item, itemCount)

	local itemName, _, itemRarity, _, itemMinLevel, itemType, itemSubType, _, itemEquipLoc = GetItemInfo(item)
	
	if (itemName == nil) and (itemRarity == nil) then
		-- with these 2 being nil, the item isn't in the item cache, so its link would be invalid: don't list it
		-- This should never happen here, since this function deals only with alts inventories, therefore all items are supposed to be known
		return
	end
	
	if (self.SearchType ~= nil) and (self.SearchType ~= itemType) then
		return		-- if there's a type and it's invalid .. Exit
	end

	if (self.SearchSubType ~= nil) and (self.SearchSubType ~= itemSubType) then
		return		-- if there's a subtype and it's invalid .. Exit
	end	

	if (itemRarity < self.SearchRarity) then
		return		-- if rarity is too low .. exit
	end
	
	if (itemMinLevel == 0) then
		if (Altoholic.Options:Get("IncludeNoMinLevel") == 0) then
			return		-- no minimum requireement & should not be included ? .. exit
		end
	else
		if (itemMinLevel < self.MinLevel) or (itemMinLevel > self.MaxLevel) then
			return		-- not within the right level boundaries ? .. exit
		end
	end
	
	if self.SearchSlot ~= 0 then	-- if a specific equipment slot is specified ..
		if Altoholic.Equipment:GetInventoryTypeIndex(itemEquipLoc) ~= self.SearchSlot then
			return		-- not the right slot ? .. exit
		end
	end

	if string.find(strlower(itemName), self.SearchValue, 1, true) == nil then
		return		-- item name does not match search value ? .. exit
	end

	if type(item) == "string" then		-- convert a link to its item id, only data saved
		item = tonumber(item:match("item:(%d+)"))
	end
	
	-- All conditions ok ? save it
	self.Results:Add( {
		linetype = self.SearchLineType,			-- PLAYER_ITEM_LINE or GUILD_ITEM_LINE 
		id = item,
		source = self.SearchCharacterIndex,		-- character or guild key in DataStore
		count = itemCount,
		location = self.SearchLocation
	} )
end

function Altoholic.Search:SetClass(class)
	self.CharacterClass = class
end

function Altoholic.Search:GetClass()
	return self.CharacterClass
end

function Altoholic.Search:GetRealmsLineDesc(line)
	return RealmScrollFrame_Desc.Lines[line]
end

function Altoholic.Search:FindEquipmentUpgrade()
	
	local upgradeType = self.value
	local self = Altoholic.Search
	
	-- debugprofilestart()
	-- Altoholic.Profiler:Begin("FindEquipmentUpgrade")
	
	local _, itemLink, _, itemLevel, _, itemType, itemSubType, _, itemEquipLoc = GetItemInfo(self.UpgradeItemID)

	self.Results:Clear()
	
	if upgradeType ~= -1 then	-- not an item level upgrade
		self:SetClass(upgradeType)
		Altoholic.Loots:FindUpgradeByStats( 
			self.UpgradeItemID, upgradeType, itemLevel, itemType, itemSubType, 
			Altoholic.Equipment:GetInventoryTypeIndex(itemEquipLoc))

	else	-- simple search, point to simple VerifyUpgrade method
		Altoholic.Loots:FindUpgrade( itemLevel, itemType, itemSubType,
			Altoholic.Equipment:GetInventoryTypeIndex(itemEquipLoc))
		AltoholicSearchOptionsLootInfo:SetText(
				GREEN .. Altoholic.Options:Get("TotalLoots") .. "|r " .. L["Loots"] .. " / "
				.. GREEN .. Altoholic.Options:Get("UnknownLoots") .. "|r " .. L["Unknown"])
	end
	self.UpgradeItemID = nil

	AltoTooltip:Hide();	-- mandatory hide after processing	
	
	if not AltoholicTabSearch:IsVisible() then
		Altoholic.Tabs:OnClick(3)
	end
	
	if upgradeType ~= -1 then	-- not an item level upgrade
		Altoholic.Tabs.Search:SetMode("upgrade")
	else
		Altoholic.Tabs.Search:SetMode("loots")
	end
	
	if Altoholic.Options:Get("SortDescending") == 1 then 		-- descending sort ?
		AltoholicTabSearch_Sort8.ascendingSort = true		-- say it's ascending now, it will be toggled
		Altoholic.Search.Results:Sort(AltoholicTabSearch_Sort8, "iLvl")
	else
		AltoholicTabSearch_Sort8.ascendingSort = nil
		Altoholic.Search.Results:Sort(AltoholicTabSearch_Sort8, "iLvl")
	end
	

	
	-- DEFAULT_CHAT_FRAME:AddMessage(debugprofilestop())
	-- Altoholic.Profiler:End("FindEquipmentUpgrade") 
	-- DEFAULT_CHAT_FRAME:AddMessage(Altoholic.Profiler:GetSampleDuration("FindEquipmentUpgrade"))
	self:Update()
end

Altoholic.UnsafeItems = {}

function Altoholic.UnsafeItems:Save(itemID)
	if self:IsItemKnown(itemID) then			-- if the unsafe item has already been saved .. exit
		return
	end
	
	-- if not, save it
	table.insert(Altoholic.db.global.unsafeItems, itemID)
end

function Altoholic.UnsafeItems:IsItemKnown(itemID)
	for k, v in pairs(Altoholic.db.global.unsafeItems) do 	-- browse current realm's unsafe item list
		if v == itemID then		-- if the itemID passed as parameter is a known unsafe item .. return true to skip it
			return true
		end
	end
	return false			-- false if unknown
end

function Altoholic.UnsafeItems:BuildList()
	-- This method will clean the unsafe item list currently in the DB. 
	-- In the previous game session, the list has been populated with items id's that were originally unsafe and for which a query was sent to the server.
	-- In this session, a getiteminfo on these id's will keep returning a nil if the item is really unsafe, so this method will get rid of the id's that are now valid.
	local TmpUnsafe = {}		-- create a temporary table with confirmed unsafe id's
	local unsafeItems = Altoholic.db.global.unsafeItems
	
	for k, v in pairs(unsafeItems) do
		local itemName = GetItemInfo(v)
		if not itemName then							-- if the item is really unsafe .. save it
			table.insert(TmpUnsafe, v)
		end
	end
	
	wipe(unsafeItems)	-- clear the DB table
	
	for k, v in pairs(TmpUnsafe) do
		table.insert(unsafeItems, v)	-- save the confirmed unsafe ids back in the db
	end
end

