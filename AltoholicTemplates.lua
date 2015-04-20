--[[ ** widget extensions **
The purpose of widget extensions to add methods to any widgets.
This can technically be done in the XML file, as part of the XML template's OnLoad.
Like this:

self.Draw = function(self, option)
		... do whatever
	end

The problem is that if the object is instantiated multiple times, and it will since we're using a template, 
then the function is actually created multiple times in memory too. A simple print proves it.

print(self.Draw)

.. this will show that the same function in each instance of the object actually has a different address in memory.

Thus to stay proper, instantiate each function once here as a local function, then expose it so that widgets can reference it. 
A print with this technique proves we're using the single copy in memory of each function.

Naturally, it would also work if my local functions were all global.. but let's avoid polluting the global namespace.

--]]

local addonName = "Altoholic"
local addon = _G[addonName]

-- *** Frames ***
local function _ShowChildFrames(self)
	for _, child in ipairs( {self} ) do
		child:Show()
	end
end

local function _HideChildFrames(self)
	for _, child in ipairs( {self} ) do
		child:Hide()
	end
end

local frameMethods = {
	ShowChildFrames = _ShowChildFrames,
	HideChildFrames = _HideChildFrames,
}

addon:RegisterClassExtensions("AltoFrame", frameMethods)


-- *** AltoSortButtonTemplate ***
local function _DrawArrow(self, ascending)
	if ascending then
		self:SetTexCoord(0, 0.5625, 1.0, 0)		-- arrow pointing up
	else
		self:SetTexCoord(0, 0.5625, 0, 1.0)		-- arrow pointing down
	end
	self:Show()
end

local sortButtonMethods = {
	Draw = _DrawArrow,
}

addon:RegisterClassExtensions("AltoSortButton", sortButtonMethods)


-- *** AltoSortButtonsContainerTemplate ***
local function _SetSortButton(self, id, title, width, func)
	local button = self["Sort"..id]

	if not title then		-- no title ? hide the button
		button:Hide()
		return
	end
	
	button:SetText(title)
	button:SetWidth(width)
	button.func = func
	button:Show()	
end

local sortButtonsContainerMethods = {
	SetButton = _SetSortButton,
}

addon:RegisterClassExtensions("AltoSortButtonsContainer", sortButtonsContainerMethods)


-- *** AltoClassIconTemplate ***
local ICON_PARTIAL = "Interface\\RaidFrame\\ReadyCheck-Waiting"

local function _SetClassIcon(self, class, faction)
	local icon = self.Icon
	local border = self.IconBorder
	
	if class and faction then
		local tc = CLASS_ICON_TCOORDS[class]
	
		icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
		icon:SetTexCoord(tc[1], tc[2], tc[3], tc[4])

		if faction == "Alliance" then
			border:SetVertexColor(0.1, 0.25, 1, 0.5)
		else
			border:SetVertexColor(1, 0, 0, 0.5)
		end
	else	-- no key ? display a question mark icon
		icon:SetTexture(ICON_PARTIAL)
		icon:SetTexCoord(0, 1, 0, 1)
		
		border:SetVertexColor(0, 1, 0, 0.5)
	end
	
	icon:SetWidth(33)
	icon:SetHeight(33)
	icon:SetAllPoints(self)
	
	border:Show()
	self:SetWidth(34)
	self:SetHeight(34)
	self:Show()
end

local classIconMethods = {
	SetClass = _SetClassIcon
}

addon:RegisterClassExtensions("AltoClassIcon", classIconMethods)


-- *** AltoClassIconsContainerTemplate ***
local function _UpdateClassIcons(self, account, realm)
	local tabName = self.tabName
	local numIcons = self.numIcons
	
	local key = addon:GetOption(format("Tabs.%s.%s.%s.Column1", tabName, account, realm))
	if not key then	-- first time this realm is displayed, or reset by player
	
		local index = 1

		-- add the first 11 keys found on this realm
		for characterName, characterKey in pairs(DataStore:GetCharacters(realm, account)) do	
			-- ex: : ["Tabs.Grids.Default.MyRealm.Column4"] = "Account.realm.alt7"

			addon:SetOption(format("Tabs.%s.%s.%s.Column%d", tabName, account, realm, index), characterKey)
			
			index = index + 1
			if index > numIcons then
				break
			end
		end
		
		while index <= numIcons do
			addon:SetOption(format("Tabs.%s.%s.%s.Column%d", tabName, account, realm, index), nil)
			index = index + 1
		end
	end

	-- Set each class/icon
	for i = 1, numIcons do
		local class, faction, _
		
		key = addon:GetOption(format("Tabs.%s.%s.%s.Column%d", tabName, account, realm, i))
		if key then
			_, class = DataStore:GetCharacterClass(key)
			faction = DataStore:GetCharacterFaction(key)
		end
		
		self[self.iconPrefix..i]:SetClass(class, faction)
	end
end

local classIconsContainerMethods = {
	Update = _UpdateClassIcons
}

addon:RegisterClassExtensions("AltoClassIconsContainer", classIconsContainerMethods)








