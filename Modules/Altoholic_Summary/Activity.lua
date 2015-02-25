local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local INFO_REALM_LINE = 0
local INFO_CHARACTER_LINE = 1
local INFO_TOTAL_LINE = 2

local ICON_FACTION_HORDE = "Interface\\Icons\\INV_BannerPVP_01"
local ICON_FACTION_ALLIANCE = "Interface\\Icons\\INV_BannerPVP_02"

addon.Activity = {}

local ns = addon.Activity		-- ns = namespace
local Characters = addon.Characters

function ns:Update()
	local VisibleLines = 14
	local frame = "AltoholicFrameActivity"
	local entry = frame.."Entry"
	
	local DS = DataStore
	
	local offset = addon.ScrollFrames:GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawRealm
	local i=1
	
	for _, line in pairs(Characters:GetView()) do
		local lineType = Characters:GetLineType(line)
		
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if lineType == INFO_REALM_LINE then								-- then keep track of counters
				if Characters:GetField(line, "isCollapsed") == false then
					DrawRealm = true
				else
					DrawRealm = false
				end
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			elseif DrawRealm then
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			end
		else		-- line will be displayed
			if lineType== INFO_REALM_LINE then
				local _, realm, account = Characters:GetInfo(line)
				
				if Characters:GetField(line, "isCollapsed") == false then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawRealm = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawRealm = false
				end
				_G[entry..i.."Collapse"]:Show()
				_G[entry..i.."Name"]:SetWidth(300)
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 25, 0)
				_G[entry..i.."NameNormalText"]:SetWidth(300)
				if account == "Default" then	-- saved as default, display as localized.
					_G[entry..i.."NameNormalText"]:SetText(format("%s (%s".. L["Account"]..": %s%s|r)", realm, colors.white, colors.green, L["Default"]))
				else
					local last = addon:GetLastAccountSharingInfo(realm, account)
					_G[entry..i.."NameNormalText"]:SetText(format("%s (%s".. L["Account"]..": %s%s %s%s|r)", realm, colors.white, colors.green, account, colors.yellow, last or ""))
				end				
				_G[entry..i.."Level"]:SetText("")
				_G[entry..i.."MailsNormalText"]:SetText("")
				_G[entry..i.."LastMailCheckNormalText"]:SetText("")
				_G[entry..i.."AuctionsNormalText"]:SetText("")
				_G[entry..i.."BidsNormalText"]:SetText("")
				_G[entry..i.."LastAHCheckNormalText"]:SetText("")
				_G[entry..i.."LastLogoutNormalText"]:SetText("")
				
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			elseif DrawRealm then
				if (lineType == INFO_CHARACTER_LINE) then
					local character = DS:GetCharacter( Characters:GetInfo(line) )
					
					local icon
					if DS:GetCharacterFaction(character) == "Alliance" then
						icon = addon:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18) .. " "
					else
						icon = addon:TextureToFontstring(ICON_FACTION_HORDE, 18, 18) .. " "
					end
					
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(170)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 10, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(170)
					_G[entry..i.."NameNormalText"]:SetText(icon .. format("%s (%s)", DS:GetColoredCharacterName(character), DS:GetCharacterClass(character)))
					_G[entry..i.."Level"]:SetText(colors.green .. DS:GetCharacterLevel(character))
				
					local color
					local num = DS:GetNumMails(character) or 0
					if num == 0 then
						color = colors.grey
						_G[entry..i.."MailsNormalText"]:SetText(colors.grey .. "0")
					else
						color = colors.green		-- green by default, red if at least one mail is about to expire
						
						local threshold = DataStore:GetOption("DataStore_Mails", "MailWarningThreshold")
						if DS:GetNumExpiredMails(character, threshold) > 0 then
							color = colors.red
						end
					end
					_G[entry..i.."MailsNormalText"]:SetText(color .. num)
					
					local lastVisit = DS:GetMailboxLastVisit(character)
					_G[entry..i.."LastMailCheckNormalText"]:SetText(colors.white .. addon:FormatDelay(lastVisit))
					
					num = DS:GetNumAuctions(character) or 0
					_G[entry..i.."AuctionsNormalText"]:SetText(((num == 0) and colors.grey or colors.green) .. num)

					num = DS:GetNumBids(character) or 0
					_G[entry..i.."BidsNormalText"]:SetText(((num == 0) and colors.grey or colors.green) .. num)
					
					lastVisit = DS:GetAuctionHouseLastVisit(character)
					_G[entry..i.."LastAHCheckNormalText"]:SetText(colors.white .. addon:FormatDelay(lastVisit))

					local player, realm, account = Characters:GetInfo(line)
					if (player == UnitName("player")) and (realm == GetRealmName()) and (account == "Default") then
						_G[entry..i.."LastLogoutNormalText"]:SetText(colors.green .. GUILD_ONLINE_LABEL)
					else
						_G[entry..i.."LastLogoutNormalText"]:SetText(colors.white .. addon:FormatDelay(DS:GetLastLogout(character)))
					end
				elseif (lineType == INFO_TOTAL_LINE) then
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(200)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(200)
					_G[entry..i.."NameNormalText"]:SetText(L["Totals"])
					_G[entry..i.."Level"]:SetText(Characters:GetField(line, "level"))
					_G[entry..i.."MailsNormalText"]:SetText("")
					_G[entry..i.."LastMailCheckNormalText"]:SetText("")
					_G[entry..i.."AuctionsNormalText"]:SetText("")
					_G[entry..i.."BidsNormalText"]:SetText("")
					_G[entry..i.."LastAHCheckNormalText"]:SetText("")
					_G[entry..i.."LastLogoutNormalText"]:SetText("")
				end
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			end
		end
	end
	
	while i <= VisibleLines do
		_G[ entry..i ]:SetID(0)
		_G[ entry..i ]:Hide()
		i = i + 1
	end

	addon.ScrollFrames:Update( AltoholicFrameActivity.ScrollFrame, VisibleCount, VisibleLines, 18)
end	

function ns:OnEnter(self)
	local line = self:GetParent():GetID()
	local lineType = Characters:GetLineType(line)
	if lineType ~= INFO_CHARACTER_LINE then		
		return
	end
	
	local DS = DataStore
	local character = DS:GetCharacter(Characters:GetInfo(line))
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT");
	
	AltoTooltip:AddDoubleLine(DS:GetColoredCharacterName(character), DS:GetColoredCharacterFaction(character))
	AltoTooltip:AddLine(format("%s %s |r%s %s", L["Level"], 
		colors.green..DS:GetCharacterLevel(character), DS:GetCharacterRace(character),	DS:GetCharacterClass(character)),1,1,1)

	local zone, subZone = DS:GetLocation(character)
	AltoTooltip:AddLine(format("%s: %s |r(%s|r)", L["Zone"], colors.gold..zone, colors.gold..subZone),1,1,1)
	
	AltoTooltip:AddLine(EXPERIENCE_COLON .. " " 
				.. colors.green .. DS:GetXP(character) .. colors.white .. "/" 
				.. colors.green .. DS:GetXPMax(character) .. colors.white .. " (" 
				.. colors.green .. DS:GetXPRate(character) .. "%"
				.. colors.white .. ")",1,1,1);	
	
	local restXP = DS:GetRestXP(character)
	if restXP and restXP > 0 then
		AltoTooltip:AddLine(format("%s: %s", L["Rest XP"], colors.green..restXP),1,1,1)
	end

	AltoTooltip:AddLine(" ",1,1,1);
	AltoTooltip:AddLine(colors.gold..CURRENCY..":",1,1,1);
	
	local num = DS:GetNumCurrencies(character) or 0
	for i = 1, num do
		local isHeader, name, count = DS:GetCurrencyInfo(character, i)
		name = name or ""
		
		if isHeader then
			AltoTooltip:AddLine(colors.yellow..name)
		else
			AltoTooltip:AddLine(format("  %s: %s", name, colors.green..count),1,1,1);
		end
	end
	
	if num == 0 then
		AltoTooltip:AddLine(colors.white..NONE,1,1,1);
	end
	
	AltoTooltip:Show();
end

local VIEW_AUCTIONS = 5
local VIEW_BIDS = 6
local VIEW_MAILS = 7

function ns:OnClick(self)
	local line = self:GetParent():GetID()
	local lineType = Characters:GetLineType(line)
	
	if lineType ~= INFO_CHARACTER_LINE then		
		return
	end
	
	local id = self:GetID()
	if (id == 2) or (id >= 5) then	-- exit if it's not the right column
		return
	end
	
	local DS = DataStore
	local character = DS:GetCharacter(Characters:GetInfo(line))
	
	local action, num
	
	if id == 1 then			-- mails
		num = DS:GetNumMails(character) or 0
		if num > 0 then				-- only set the action if there are data to show
			action = VIEW_MAILS
		end
	elseif id == 3 then		-- auctions
		num = DS:GetNumAuctions(character) or 0
		if num > 0 then
			action = VIEW_AUCTIONS
		end
	elseif id == 4 then		-- bids
		num = DS:GetNumBids(character) or 0
		if num > 0 then
			action = VIEW_BIDS
		end
	end
	
	if action then
		addon.Tabs:OnClick("Characters")
		addon.Tabs.Characters:SetAlt( Characters:GetInfo(line) )
		addon.Tabs.Characters:MenuItem_OnClick(AltoholicTabCharacters.Characters, "LeftButton")
		addon.Tabs.Characters:ViewCharInfo(action)	
	end
end

function ns:Mails_OnEnter(self)
	local line = self:GetParent():GetID()
	local lineType = Characters:GetLineType(line)
	
	if lineType ~= INFO_CHARACTER_LINE then		
		return
	end
	
	local DS = DataStore
	local character = DS:GetCharacter(Characters:GetInfo(line))
	local num = DS:GetNumMails(character)
	if not num or num == 0 then return end
	
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT");
	
	AltoTooltip:AddDoubleLine(DS:GetColoredCharacterName(character), format("%sMails found: %s%d", colors.white, colors.green, num))
	
	local numReturned, numDeleted, numExpired = 0, 0, 0
	local closestReturn
	local closestDelete
	
	for index = 1, num do
		local _, _, _, _, _, isReturned = DS:GetMailInfo(character, index)
		local _, seconds = DS:GetMailExpiry(character, index)
		
		if seconds < 0 then		-- mail has already expired
			if isReturned then	-- .. and it was a returned mail
				numExpired = numExpired + 1
			end
		else
			if isReturned then
				numDeleted = numDeleted + 1
				
				if not closestDelete then
					closestDelete = seconds
				else
					if seconds < closestDelete then
						closestDelete = seconds
					end
				end
			else
				numReturned = numReturned + 1
				
				if not closestReturn then
					closestReturn = seconds
				else
					if seconds < closestReturn then
						closestReturn = seconds
					end
				end
			end
		end
	end

	AltoTooltip:AddLine(" ");
	AltoTooltip:AddLine(format("%s%d %swill be returned upon expiry", colors.green, numReturned, colors.white))
	if closestReturn then
		AltoTooltip:AddLine(format("%sClosest return in %s%s", colors.white, colors.green, SecondsToTime(closestReturn)))
	end
	
	if numDeleted > 0 then
		AltoTooltip:AddLine(" ");
		AltoTooltip:AddLine(format("%s%d %swill be %sdeleted%s upon expiry", colors.green, numDeleted, colors.white, colors.red, colors.white))
		if closestDelete then
			AltoTooltip:AddLine(format("%sClosest deletion in %s%s", colors.white, colors.green, SecondsToTime(closestDelete)))
		end
	end
	
	if numExpired > 0 then
		AltoTooltip:AddLine(" ");
		AltoTooltip:AddLine(format("%s%d %shave expired !", colors.red, numExpired, colors.white))
	end
	
	AltoTooltip:Show();
end
