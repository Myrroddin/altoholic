local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local THIS_ACCOUNT = "Default"
local WHITE		= "|cFFFFFFFF"
local TEAL		= "|cFF00FF9A"
local ORANGE	= "|cFFFF7F00"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"

-- These match the id's of the buttons in TabCharacters.xml
local VIEW_BAGS = 1
local VIEW_TALENTS = 2
local VIEW_MAILS = 3
local VIEW_QUESTS = 4
local VIEW_AUCTIONS = 5
local VIEW_BIDS = 6
local VIEW_COMPANIONS = 7
local VIEW_MOUNTS = 8
local VIEW_REP = 9
local VIEW_EQUIP = 10

local ICON_VIEW_BAGS = "Interface\\Buttons\\Button-Backpack-Up"
local ICON_VIEW_MAILS = "Interface\\Icons\\INV_Misc_Note_01"
local ICON_VIEW_QUESTS = "Interface\\Icons\\INV_Misc_Book_07"
local ICON_VIEW_AUCTIONS = "Interface\\Icons\\INV_Misc_Coin_01"
local ICON_VIEW_BIDS = "Interface\\Icons\\INV_Misc_Coin_03"
local ICON_VIEW_COMPANIONS = "Interface\\Icons\\INV_Box_Birdcage_01"
local ICON_VIEW_MOUNTS = "Interface\\Icons\\Ability_Mount_RidingHorse"
local ICON_VIEW_REP = "Interface\\Icons\\INV_BannerPVP_02"
local ICON_VIEW_EQUIP = "Interface\\Icons\\INV_Chest_Plate04"
local ICON_VIEW_TALENTS = "Interface\\Icons\\Spell_Nature_NatureGuardian"

Altoholic.Tabs.Characters = {}

local CharInfoButtons = {
	"AltoholicTabCharacters_Bags",
	"AltoholicTabCharacters_Talents",
	"AltoholicTabCharacters_Mails",
	"AltoholicTabCharacters_Quests",
	"AltoholicTabCharacters_Auctions",
	"AltoholicTabCharacters_Bids",
	"AltoholicTabCharacters_Pets",
	"AltoholicTabCharacters_Mounts",
	"AltoholicTabCharacters_Factions",
	"AltoholicTabCharacters_Equipment",
}

function Altoholic.Tabs.Characters:UpdateViewIcons()
	
	local DS = DataStore
	local character = Altoholic.Tabs.Characters:GetCurrent()
	
	if not character then
		for k, v in pairs(CharInfoButtons) do
			_G[v]:Hide()
		end
		AltoholicTabCharacters_Cooking:Hide()
		AltoholicTabCharacters_FirstAid:Hide()
		AltoholicTabCharacters_Prof1:Hide()
		AltoholicTabCharacters_Prof2:Hide()
		return
	end
	
	local size = 30
	
	-- ** Bags / Equipment / Quests **
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Bags", ICON_VIEW_BAGS, size, size)
	AltoholicTabCharacters_Bags.text = L["Containers"]
	AltoholicTabCharacters_Bags:Show()
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Equipment", ICON_VIEW_EQUIP, size, size)
	AltoholicTabCharacters_Equipment.text = L["Equipment"]
	AltoholicTabCharacters_Equipment:Show()
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Quests", ICON_VIEW_QUESTS, size, size)
	AltoholicTabCharacters_Quests.text = L["Quests"]
	AltoholicTabCharacters_Quests:Show()
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Talents", ICON_VIEW_TALENTS, size, size)
	AltoholicTabCharacters_Talents.text = TALENTS .. " & " .. GLYPHS
	AltoholicTabCharacters_Talents:Show()
	
	-- ** Auctions / Bids / Mails **
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Auctions", ICON_VIEW_AUCTIONS, size, size)
	local num = DS:GetNumAuctions(character)
	if num > 0 then
		AltoholicTabCharacters_AuctionsCount:SetText(num)
		AltoholicTabCharacters_AuctionsCount:Show()
	else
		AltoholicTabCharacters_AuctionsCount:Hide()
	end
	AltoholicTabCharacters_Auctions.text = format(L["Auctions %s(%d)"], GREEN, num)
	AltoholicTabCharacters_Auctions:Show()
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Bids", ICON_VIEW_BIDS, size, size)
	num = DS:GetNumBids(character)
	if num > 0 then
		AltoholicTabCharacters_BidsCount:SetText(num)
		AltoholicTabCharacters_BidsCount:Show()
	else
		AltoholicTabCharacters_BidsCount:Hide()
	end
	AltoholicTabCharacters_Bids.text = format(L["Bids %s(%d)"], GREEN, num)
	AltoholicTabCharacters_Bids:Show()
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Mails", ICON_VIEW_MAILS, size, size)
	num = DS:GetNumMails(character)
	if num > 0 then
		AltoholicTabCharacters_MailsCount:SetText(num)
		AltoholicTabCharacters_MailsCount:Show()
	else
		AltoholicTabCharacters_MailsCount:Hide()
	end
	AltoholicTabCharacters_Mails.text = format(L["Mails %s(%d)"], GREEN, num)
	AltoholicTabCharacters_Mails:Show()
	
	-- ** Pets / Mounts / Reputations **
	local pets = DS:GetPets(character, "CRITTER")
	num = DS:GetNumPets(pets)

	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Pets", ICON_VIEW_COMPANIONS, size, size)
	if num > 0 then
		AltoholicTabCharacters_PetsCount:SetText(num)
		AltoholicTabCharacters_PetsCount:Show()
	else
		AltoholicTabCharacters_PetsCount:Hide()
	end
	AltoholicTabCharacters_Pets.text = format(COMPANIONS .. " %s(%d)", GREEN, num)
	AltoholicTabCharacters_Pets:Show()

	pets = DS:GetPets(character, "MOUNT")
	num = DS:GetNumPets(pets)

	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Mounts", ICON_VIEW_MOUNTS, size, size)
	if num > 0 then
		AltoholicTabCharacters_MountsCount:SetText(num)
		AltoholicTabCharacters_MountsCount:Show()
	else
		AltoholicTabCharacters_MountsCount:Hide()
	end
	AltoholicTabCharacters_Mounts.text = format(MOUNTS .. " %s(%d)", GREEN, num)
	AltoholicTabCharacters_Mounts:Show()
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Factions", ICON_VIEW_REP, size, size)
	AltoholicTabCharacters_Factions.text = L["Reputations"]
	AltoholicTabCharacters_Factions:Show()
	
	-- ** Professions **
	local professionName = GetSpellInfo(2550)		-- cooking
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Cooking", Altoholic:GetSpellIcon(Altoholic.ProfessionSpellID[professionName]), size, size)
	AltoholicTabCharacters_Cooking.text = professionName
	AltoholicTabCharacters_Cooking:Show()
	
	professionName = GetSpellInfo(3273)		-- First Aid
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_FirstAid", Altoholic:GetSpellIcon(Altoholic.ProfessionSpellID[professionName]), size, size)
	AltoholicTabCharacters_FirstAid.text = professionName
	AltoholicTabCharacters_FirstAid:Show()
	
	local i = 1
	for skillName, skill in pairs(DS:GetPrimaryProfessions(character)) do
		local itemName = "AltoholicTabCharacters_Prof" .. i
		local item = _G[itemName]
	
		if Altoholic.ProfessionSpellID[skillName] then
			Altoholic:SetItemButtonTexture(itemName, Altoholic:GetSpellIcon(Altoholic.ProfessionSpellID[skillName]), size, size)
			item.text = skillName
			item:Show()
		else
			item.text = nil
			item:Hide()		
		end
		i = i + 1
	end
end

function Altoholic.Tabs.Characters:MenuItem_OnClick(frame, button)
	local self = Altoholic.Tabs.Characters
	self:StopAutoCastShine()
	self:StartAutoCastShine(frame)
	
	local id = frame:GetID()
	if id > 0 then
		self:ViewCharInfo(id, true)
		return
	end
	
	if frame.text then		-- profession button
		self:ViewRecipes(frame.text)
	end
end

function Altoholic.Tabs.Characters:StartAutoCastShine(button)
	local item = button:GetName()
	AutoCastShine_AutoCastStart(_G[ item .. "Shine" ]);
	self.LastButton = item
end

function Altoholic.Tabs.Characters:StopAutoCastShine()
	-- stop autocast shine on the last button that was clicked
	if self.LastButton then
		AutoCastShine_AutoCastStop(_G[ self.LastButton .. "Shine" ]);
	end
end

function Altoholic.Tabs.Characters:DropDownRealm_Initialize()
	if not Altoholic:GetCurrentAccount() or 
		not Altoholic:GetCurrentRealm() then return end

	local DS = DataStore
	local self = Altoholic.Tabs.Characters
	-- this account first ..
	for realm in pairs(DS:GetRealms()) do
		self:AddRealm(realm, THIS_ACCOUNT)
	end

	-- .. then all other accounts
	for account in pairs(DS:GetAccounts()) do
		if account ~= THIS_ACCOUNT then
			for realm in pairs(DS:GetRealms(account)) do
				self:AddRealm(realm, account)
			end
		end
	end
end

function Altoholic.Tabs.Characters:AddRealm(realm, account)
	local info = UIDropDownMenu_CreateInfo(); 

	info.text = GREEN .. account .. ": " .. WHITE.. realm
	info.value = account .."|" .. realm
	info.checked = nil
	info.func = self.ChangeRealm
	info.arg1 = account
	info.arg2 = realm
	UIDropDownMenu_AddButton(info, 1); 
end

function Altoholic.Tabs.Characters:ChangeRealm(account, realm, checked)
	local self = Altoholic.Tabs.Characters
	local OldAccount = Altoholic:GetCurrentAccount()
	local OldRealm = Altoholic:GetCurrentRealm()

	Altoholic:SetCurrentAccount(account)
	Altoholic:SetCurrentRealm(realm)
	
	UIDropDownMenu_ClearAll(AltoholicTabCharacters_SelectRealm);
	UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectRealm, account .."|".. realm)
	UIDropDownMenu_SetText(AltoholicTabCharacters_SelectRealm, GREEN .. account .. ": " .. WHITE.. realm)
	
	if OldRealm and OldAccount then	-- clear the "select char" drop down if realm or account has changed
		if (OldRealm ~= realm) or (OldAccount ~= account) then
			UIDropDownMenu_ClearAll(AltoholicTabCharacters_SelectChar);
			AltoholicTabCharactersStatus:SetText("")
			Altoholic:SetCurrentCharacter(nil)
			Altoholic.TradeSkills.CurrentProfession = nil
			Altoholic.Reputations:BuildView()
			
			self:HideAll()
			self:StopAutoCastShine()
			AltoholicFrameAchievements:Hide()
			self:UpdateViewIcons()
		end
	end
end

function Altoholic.Tabs.Characters:DropDownChar_Initialize()
	if not Altoholic:GetCurrentAccount() or 
		not Altoholic:GetCurrentRealm() then return end
	
	local info = UIDropDownMenu_CreateInfo(); 
	local realm, account = Altoholic:GetCurrentRealm()
	
	local DS = DataStore
	for characterName, character in pairs(DS:GetCharacters(realm, account)) do
		info.text = characterName
		info.value = character
		info.func = Altoholic.Tabs.Characters.ChangeAlt
		info.checked = nil; 
		UIDropDownMenu_AddButton(info, 1); 
	end
end

function Altoholic.Tabs.Characters:ChangeAlt()
	local OldAlt = Altoholic:GetCurrentCharacter()
	local _, _, NewAlt = strsplit(".", self.value)
	
	UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectChar, self.value);
	Altoholic:SetCurrentCharacter(NewAlt)
	
	local self = Altoholic.Tabs.Characters
	self:UpdateViewIcons()
	if (not OldAlt) or (OldAlt == NewAlt) then return end

	if (type(self.InfoType) == "string") or
		((type(self.InfoType) == "number") and (self.InfoType > VIEW_MOUNTS)) then		-- true if we're dealing with a profession
		Altoholic.TradeSkills.CurrentProfession = nil
		self:HideAll()
		self:StopAutoCastShine()
	else
		self:ShowCharInfo(self.InfoType)		-- self will show the same info from another alt (ex: containers/mail/ ..)
	end
end

function Altoholic.Tabs.Characters:SetCurrent(name, realm, account)
	-- this function sets both drop down menu to the right values
	self:DropDownRealm_Initialize()
	UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectRealm, account .."|".. realm)

	self:DropDownChar_Initialize()
	
	local character = DataStore:GetCharacter(name, realm, account)
	UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectChar, character)
end

function Altoholic.Tabs.Characters:GetCurrent()
	-- the right character key is in this widget, use it to avoid querying DataStore all the time
	return UIDropDownMenu_GetSelectedValue(AltoholicTabCharacters_SelectChar)
end




function Altoholic.Tabs.Characters:ViewCharInfo(index, autoCastDone)
	index = index or self.value
	local self = Altoholic.Tabs.Characters
	
	if not autoCastDone then
		self:StopAutoCastShine()
		self:StartAutoCastShine(_G[ CharInfoButtons[index] ] )
	end
	
	self.InfoType = index
	self:HideAll()
	self:SetMode(index)
	self:ShowCharInfo(index)
end

function Altoholic.Tabs.Characters:ViewRecipes(profession)
	local self = Altoholic.Tabs.Characters
	local ts = Altoholic.TradeSkills
	ts.CurrentProfession = profession
	
	self.InfoType = profession
	self:HideAll()
	self:SetMode()
	
	ts.Recipes:ResetDropDownMenus()
	AltoholicFrameRecipes:Show()
	ts.Recipes:BuildView()
	ts.Recipes:Update()
end

function Altoholic.Tabs.Characters:ShowCharInfo(infoType)
	if infoType == VIEW_BAGS then
		Altoholic:ClearScrollFrame(_G[ "AltoholicFrameContainersScrollFrame" ], "AltoholicFrameContainersEntry", 7, 41)
		
		Altoholic.Containers:SetView(Altoholic.Options:Get("lastContainerView"))
		AltoholicFrameContainers:Show()
		Altoholic.Containers:Update()
		
	elseif infoType == VIEW_TALENTS then
		AltoholicFrameTalents:Show()
		Altoholic.Talents:Update();
		
	elseif infoType == VIEW_MAILS then
		AltoholicFrameMail:Show()
		Altoholic.Mail:BuildView()
		Altoholic.Mail:Update()
	elseif infoType == VIEW_QUESTS then
		AltoholicFrameQuests:Show()
		Altoholic.Quests:InvalidateView()
		Altoholic.Quests:Update();
	elseif infoType == VIEW_AUCTIONS then
		local ah = Altoholic.AuctionHouse
		local ahType = "Auctions"
		ah.AuctionType = ahType
		ah.Update = ah.UpdateAuctions
		AltoholicFrameAuctions:Show()
		ah:BuildView(ahType)
		ah:Update();
	elseif infoType == VIEW_BIDS then
		local ah = Altoholic.AuctionHouse
		local ahType = "Bids"
		ah.AuctionType = ahType
		ah.Update = ah.UpdateBids
		AltoholicFrameAuctions:Show()
		ah:BuildView(ahType)
		ah:Update();
	elseif infoType == VIEW_COMPANIONS then
		UIDropDownMenu_SetSelectedValue(AltoholicFramePets_SelectPetView, 1);
		UIDropDownMenu_SetText(AltoholicFramePets_SelectPetView, COMPANIONS)
		Altoholic.Pets:SetType("CRITTER")
		AltoholicFramePetsNormal:Show()
		AltoholicFramePetsAllInOne:Hide()
		AltoholicFramePets:Show()
	elseif infoType == VIEW_MOUNTS then
		UIDropDownMenu_SetSelectedValue(AltoholicFramePets_SelectPetView, 3);
		UIDropDownMenu_SetText(AltoholicFramePets_SelectPetView, MOUNTS)
		Altoholic.Pets:SetType("MOUNT")
		AltoholicFramePetsNormal:Show()
		AltoholicFramePetsAllInOne:Hide()
		AltoholicFramePets:Show()
	elseif infoType == VIEW_REP then
		AltoholicFrameClasses:Show()
		AltoholicFrameReputations:Show()
		Altoholic.Reputations:Update();	
	elseif infoType == VIEW_EQUIP then
		AltoholicFrameClasses:Show()
		AltoholicFrameEquipment:Show()
		Altoholic.Equipment:Update()	
	end
end

function Altoholic.Tabs.Characters:HideAll()
	AltoholicFrameContainers:Hide()
	AltoholicFrameTalents:Hide()
	AltoholicFrameMail:Hide()
	AltoholicFrameQuests:Hide()
	AltoholicFrameAuctions:Hide()
	AltoholicFramePets:Hide()
	AltoholicFrameRecipes:Hide()
	AltoholicFrameReputations:Hide()
	AltoholicFrameEquipment:Hide()
	AltoholicFrameClasses:Hide()
end

function Altoholic.Tabs.Characters:SetMode(mode)
	self.mode = mode
	
	local Columns = Altoholic.Tabs.Columns
	Columns:Init()
	
	if not mode then return end		-- called without parameter for professions

	if mode == VIEW_MAILS then
		Columns:Add(MAIL_SUBJECT_LABEL, 220, function(self) Altoholic.Mail:Sort(self, "name") end)
		Columns:Add(FROM, 140, function(self) Altoholic.Mail:Sort(self, "from") end)
		Columns:Add(L["Expiry:"], 130, function(self) Altoholic.Mail:Sort(self, "expiry") end)

	elseif mode == VIEW_AUCTIONS then
		Columns:Add(HELPFRAME_ITEM_TITLE, 220, function(self) Altoholic.AuctionHouse:Sort(self, "name", "Auctions") end)
		Columns:Add(HIGH_BIDDER, 160, function(self) Altoholic.AuctionHouse:Sort(self, "highBidder", "Auctions") end)
		Columns:Add(CURRENT_BID, 170, function(self) Altoholic.AuctionHouse:Sort(self, "buyoutPrice", "Auctions") end)
	
	elseif mode == VIEW_BIDS then
		Columns:Add(HELPFRAME_ITEM_TITLE, 220, function(self) Altoholic.AuctionHouse:Sort(self, "name", "Bids") end)
		Columns:Add(NAME, 160, function(self) Altoholic.AuctionHouse:Sort(self, "owner", "Bids") end)
		Columns:Add(CURRENT_BID, 170, function(self) Altoholic.AuctionHouse:Sort(self, "buyoutPrice", "Bids") end)
	end
end
