local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()

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
	
	local c = Altoholic:GetCharacterTable()
	
	if not c then
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
	if #c.auctions > 0 then
		AltoholicTabCharacters_AuctionsCount:SetText(#c.auctions)
		AltoholicTabCharacters_AuctionsCount:Show()
	else
		AltoholicTabCharacters_AuctionsCount:Hide()
	end
	AltoholicTabCharacters_Auctions.text = format(L["Auctions %s(%d)"], GREEN, #c.auctions)
	AltoholicTabCharacters_Auctions:Show()
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Bids", ICON_VIEW_BIDS, size, size)
	if #c.bids > 0 then
		AltoholicTabCharacters_BidsCount:SetText(#c.bids)
		AltoholicTabCharacters_BidsCount:Show()
	else
		AltoholicTabCharacters_BidsCount:Hide()
	end
	AltoholicTabCharacters_Bids.text = format(L["Bids %s(%d)"], GREEN, #c.bids)
	AltoholicTabCharacters_Bids:Show()
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Mails", ICON_VIEW_MAILS, size, size)
	local numMails = #c.mail + #c.mailCache
	if numMails > 0 then
		AltoholicTabCharacters_MailsCount:SetText(numMails)
		AltoholicTabCharacters_MailsCount:Show()
	else
		AltoholicTabCharacters_MailsCount:Hide()
	end
	AltoholicTabCharacters_Mails.text = format(L["Mails %s(%d)"], GREEN, numMails)
	AltoholicTabCharacters_Mails:Show()
	
	-- ** Pets / Mounts / Reputations **
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Pets", ICON_VIEW_COMPANIONS, size, size)
	if c.pets["CRITTER"] then
		AltoholicTabCharacters_PetsCount:SetText(#c.pets["CRITTER"])
		AltoholicTabCharacters_PetsCount:Show()
		AltoholicTabCharacters_Pets.text = format(COMPANIONS .. " %s(%d)", GREEN, #c.pets["CRITTER"])
	else
		AltoholicTabCharacters_PetsCount:Hide()
		AltoholicTabCharacters_Pets.text = format(COMPANIONS .. " %s(%d)", GREEN, 0)
	end
	AltoholicTabCharacters_Pets:Show()
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Mounts", ICON_VIEW_MOUNTS, size, size)
	if c.pets["MOUNT"] then
		AltoholicTabCharacters_MountsCount:SetText(#c.pets["MOUNT"])
		AltoholicTabCharacters_MountsCount:Show()
		AltoholicTabCharacters_Mounts.text = format(MOUNTS .. " %s(%d)", GREEN, #c.pets["MOUNT"])
	else
		AltoholicTabCharacters_MountsCount:Hide()
		AltoholicTabCharacters_Mounts.text = format(MOUNTS .. " %s(%d)", GREEN, 0)
	end
	AltoholicTabCharacters_Mounts:Show()
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Factions", ICON_VIEW_REP, size, size)
	AltoholicTabCharacters_Factions.text = L["Reputations"]
	AltoholicTabCharacters_Factions:Show()
	
	-- ** Professions **
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Cooking", Altoholic:GetSpellIcon(Altoholic.ProfessionSpellID[BI["Cooking"]]), size, size)
	AltoholicTabCharacters_Cooking.text = BI["Cooking"]
	AltoholicTabCharacters_Cooking:Show()
	
	Altoholic:SetItemButtonTexture("AltoholicTabCharacters_FirstAid", Altoholic:GetSpellIcon(Altoholic.ProfessionSpellID[BI["First Aid"]]), size, size)
	AltoholicTabCharacters_FirstAid.text = BI["First Aid"]
	AltoholicTabCharacters_FirstAid:Show()
	
	local prof1, prof2 = Altoholic:GetProfessions()

	if prof1 and Altoholic.ProfessionSpellID[prof1] then
		Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Prof1", Altoholic:GetSpellIcon(Altoholic.ProfessionSpellID[prof1]), size, size)
		AltoholicTabCharacters_Prof1.text = prof1
		AltoholicTabCharacters_Prof1:Show()
	else
		AltoholicTabCharacters_Prof1.text = nil
		AltoholicTabCharacters_Prof1:Hide()
	end
	
	if prof2 and Altoholic.ProfessionSpellID[prof2] then
		Altoholic:SetItemButtonTexture("AltoholicTabCharacters_Prof2", Altoholic:GetSpellIcon(Altoholic.ProfessionSpellID[prof2]), size, size)
		AltoholicTabCharacters_Prof2.text = prof2
		AltoholicTabCharacters_Prof2:Show()
	else
		AltoholicTabCharacters_Prof2.text = nil
		AltoholicTabCharacters_Prof2:Hide()
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

	local self = Altoholic.Tabs.Characters
	-- this account first ..
	for RealmName, _ in pairs(Altoholic.db.global.data[THIS_ACCOUNT]) do
		self:AddRealm(RealmName, THIS_ACCOUNT)
	end

	-- .. then all other accounts
	for AccountName, a in pairs(Altoholic.db.global.data) do
		if AccountName ~= THIS_ACCOUNT then
			for RealmName, _ in pairs(a) do
				self:AddRealm(RealmName, AccountName)
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
	local r = Altoholic:GetRealmTable()
	
	for CharacterName, c in pairs(r.char) do
		info.text = CharacterName
		info.value = CharacterName
		info.func = Altoholic.Tabs.Characters.ChangeAlt
		info.checked = nil; 
		UIDropDownMenu_AddButton(info, 1); 
	end
end

function Altoholic.Tabs.Characters:ChangeAlt()
	local OldAlt = Altoholic:GetCurrentCharacter()
	local NewAlt = self.value
	
	UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectChar, NewAlt);
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
	local c = Altoholic:GetCharacterTable()

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
		Altoholic.Quests:Update();
	elseif infoType == VIEW_AUCTIONS then
		local ah = Altoholic.AuctionHouse
		ah.AuctionType = "auctions"
		ah.Update = ah.UpdateAuctions
		AltoholicFrameAuctions:Show()
		ah:Update();
	elseif infoType == VIEW_BIDS then
		local ah = Altoholic.AuctionHouse
		ah.AuctionType = "bids"
		ah.Update = ah.UpdateBids
		AltoholicFrameAuctions:Show()
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
		Columns:Add(HELPFRAME_ITEM_TITLE, 220, function(self) Altoholic.AuctionHouse:SortAuctions(self, "name") end)
		Columns:Add(HIGH_BIDDER, 160, function(self) Altoholic.AuctionHouse:SortAuctions(self, "highBidder") end)
		Columns:Add(CURRENT_BID, 170, function(self) Altoholic.AuctionHouse:SortAuctions(self, "buyoutPrice")	end)
	
	elseif mode == VIEW_BIDS then
		Columns:Add(HELPFRAME_ITEM_TITLE, 220, function(self) Altoholic.AuctionHouse:SortBids(self, "name") end)
		Columns:Add(NAME, 160, function(self) Altoholic.AuctionHouse:SortBids(self, "owner") end)
		Columns:Add(CURRENT_BID, 170, function(self) Altoholic.AuctionHouse:SortBids(self, "buyoutPrice") end)
	end
end
