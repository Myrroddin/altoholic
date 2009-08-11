local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local PETS_PER_PAGE = 12

Altoholic.Pets = {}

function Altoholic.Pets:OnEnter(self)
	if not self.spellID then return end
	
	AltoTooltip:SetOwner(self, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();
	AltoTooltip:SetHyperlink("spell:" ..self.spellID);
	AltoTooltip:Show();
end

function Altoholic.Pets:OnClick(self)
	self:SetChecked(true);
	
	local p = Altoholic.Pets
	local offset = (p.CurrentPage-1) * PETS_PER_PAGE
	p.selectedID = offset + self:GetID()
	p:UpdatePets()
end

function Altoholic.Pets:DropDownPets_Initialize()
	local self = Altoholic.Pets
	local info = UIDropDownMenu_CreateInfo(); 
	
	info.text =  COMPANIONS
	info.value = 1
	info.func = self.ChangePetView
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 
	
	info.text =  COMPANIONS .. GREEN .. " (" .. L["All-in-one"] .. ")"
	info.value = 2
	info.func = self.ChangePetView
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 
	
	info.text =  MOUNTS
	info.value = 3
	info.func = self.ChangePetView
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 
	
	info.text =  MOUNTS .. GREEN .. " (" .. L["All-in-one"] .. ")"
	info.value = 4
	info.func = self.ChangePetView
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 
end

function Altoholic.Pets:ChangePetView()
	local value = self.value
	local self = Altoholic.Pets
	
	UIDropDownMenu_SetSelectedValue(AltoholicFramePets_SelectPetView, value);
	
	if value == 1 or value == 3 then
		AltoholicFrameClasses:Hide()
		AltoholicFramePetsNormal:Show()
		AltoholicFramePetsAllInOne:Hide()
	else
		AltoholicFrameClasses:Show()
		AltoholicFramePetsNormal:Hide()
		AltoholicFramePetsAllInOne:Show()
	end
	
	AltoholicFramePets:Show()
	local DS = DataStore
	
	if value == 1 then
		self:SetType("CRITTER")
	elseif value == 2 then
		table.sort(DS:GetCompanionList(), function(a, b)
					local textA = GetSpellInfo(a) or ""
					local textB = GetSpellInfo(b) or ""
					return textA < textB
				end)
		self:UpdatePetsAllInOne()
	elseif value == 3 then
		self:SetType("MOUNT")
	elseif value == 4 then
		table.sort(DS:GetMountList(), function(a, b)
					local textA = GetSpellInfo(a) or ""
					local textB = GetSpellInfo(b) or ""
					return textA < textB
				end)
		self:UpdatePetsAllInOne()
	end
end

function Altoholic.Pets:SetType(petType)
	self.selectedID = 1
	self.PetType = petType
	self:SetPage(1)
end

function Altoholic.Pets:SetPage(pageNum)
	self.CurrentPage = pageNum
	
	local DS = DataStore
	local character = Altoholic.Tabs.Characters:GetCurrent()
	local pets = DS:GetPets(character, self.PetType)
	
	if self.CurrentPage == 1 then
		AltoholicFramePetsNormalPrevPage:Disable()
	else
		AltoholicFramePetsNormalPrevPage:Enable()
	end
	
	local maxPages
	if pets then
		maxPages = ceil(DS:GetNumPets(pets) / PETS_PER_PAGE)
		if maxPages == 0 then
			maxPages = 1
		end
	else
		maxPages = 1
	end
	
	if self.CurrentPage == maxPages then
		AltoholicFramePetsNormalNextPage:Disable()
	else
		AltoholicFramePetsNormalNextPage:Enable()
	end
	
	AltoholicFramePetsNormal_PageNumber:SetText(format(MERCHANT_PAGE_NUMBER, self.CurrentPage, maxPages ))
	self:UpdatePets()
end

function Altoholic.Pets:UpdatePets()
	local DS = DataStore
	local character = Altoholic.Tabs.Characters:GetCurrent()
	local pets = DS:GetPets(character, self.PetType)
	
	if not pets or (DS:GetNumPets(pets) == 0) then		-- added this test as simply addressing the table seems to make it grow, I'd assume this is due to AceDB magic value ['*'].
		for i = 1, PETS_PER_PAGE do
			local button = _G["AltoholicFramePetsNormal_Button" .. i];
		
			if self.PetType == "MOUNT" then
				button:SetDisabledTexture([[Interface\PetPaperDollFrame\UI-PetFrame-Slots-Mounts]])
			else
				button:SetDisabledTexture([[Interface\PetPaperDollFrame\UI-PetFrame-Slots-Companions]])
			end
			button:Disable();
			button:SetChecked(false);
		end
		return
	end
	
	local offset = (self.CurrentPage-1) * PETS_PER_PAGE
	
	for i = 1, PETS_PER_PAGE do
		local index = offset + i
		local button = _G["AltoholicFramePetsNormal_Button" .. i];
		
		local modelID, name, spellID, icon = DS:GetPetInfo(pets, index)
		
		if icon and spellID then						-- if there's a pet  .. texture & enable it
			button:SetNormalTexture(icon);	
			button:Enable()
			button.spellID = spellID 
		else
			button.spellID = nil
			if self.PetType == "MOUNT" then
				button:SetDisabledTexture([[Interface\PetPaperDollFrame\UI-PetFrame-Slots-Mounts]])
			else
				button:SetDisabledTexture([[Interface\PetPaperDollFrame\UI-PetFrame-Slots-Companions]])
			end
			button:Disable();
		end

		modelID = tonumber(modelID)
		if self.selectedID and (index == self.selectedID) and modelID then
			button:SetChecked(true);		-- check only if it's the selected button and it has a model id
			AltoholicFramePetsNormal_PetName:SetText(name)
			AltoholicFramePetsNormal_ModelFrame:SetCreature(modelID);
		else
			button:SetChecked(false);
		end
	end
end

function Altoholic.Pets:UpdatePetsAllInOne()
	local VisibleLines = 8
	local frame = "AltoholicFramePetsAllInOne"
	local entry = frame.."Entry"
		
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	
	local mode = UIDropDownMenu_GetSelectedValue(AltoholicFramePets_SelectPetView);
	local petList, petType
	
	local DS = DataStore
	if mode == 2 then
		petList = DS:GetCompanionList()
		petType = "CRITTER"
	elseif mode == 4 then
		petList = DS:GetMountList()
		petType = "MOUNT"
	end
	
	local realm, account = Altoholic:GetCurrentRealm()
	local character
	
	for i=1, VisibleLines do
		local line = i + offset
		if line <= #petList then	-- if the line is visible
			local spellID

			spellID = petList[line]
			
			local petName, _, petTexture = GetSpellInfo(spellID)
			
			if petName then
				_G[entry..i.."Name"]:SetText(WHITE .. petName)
				_G[entry..i.."Name"]:SetJustifyH("LEFT")
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
			end
			
			for j = 1, 10 do
				local itemName = entry.. i .. "Item" .. j;
				local itemButton = _G[itemName]
				local itemTexture = _G[itemName .. "_Background"]
				
				local classButton = _G["AltoholicFrameClassesItem" .. j]
				if classButton.CharName then
					character = DS:GetCharacter(classButton.CharName, realm, account)				
					
					itemButton:SetScript("OnEnter", function(self) Altoholic.Pets:OnEnter(self) end)
					itemTexture:SetTexture(petTexture)
					
					if DS:IsPetKnown(character, petType, spellID) then
						itemTexture:SetVertexColor(1.0, 1.0, 1.0);
						_G[itemName .. "Name"]:SetText("\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t")
					else
						itemTexture:SetVertexColor(0.4, 0.4, 0.4);
						_G[itemName .. "Name"]:SetText("\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t")
					end
					itemButton.spellID = spellID
					itemButton:Show()
				else
					itemButton.spellID = nil
					itemButton:Hide()
				end
			end
						
			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end

	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], #petList, VisibleLines, 41);
end

function Altoholic.Pets:OnChange()
	-- this event is triggered too often for our needs, some filtering is required  to avoid scanning pet data too often
	if arg1 ~= "player" then return end
	
	local name = UnitName("pet")
	if not name or name == UNKNOWN then	return end		-- if there's a usable pet name ..
	
	local self = Altoholic.Pets
	if not self.CurrentPetName then		-- not set ? initial scan
		self.CurrentPetName = name
		self:ScanHunter()
	elseif self.CurrentPetName ~= name then	-- already set, has it changed ? re-scan
		self.CurrentPetName = name
		self:ScanHunter()
	end
end

function Altoholic.Pets:ScanHunter()
	-- this is a specific function to scan hunter pet talents
--	DEFAULT_CHAT_FRAME:AddMessage("Scanning Pet " .. self.CurrentPetName)
end
