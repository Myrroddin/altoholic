local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"

Altoholic.Options = {}

function Altoholic.Options:Init()
	local value			
	
	-- ** Frame 1 : General **
	AltoholicTabOptionsFrame1_RestXPModeText:SetText(L["Max rest XP displayed as 150%"])
	AltoholicTabOptionsFrame1_GuildBankAutoUpdateText:SetText(L["Automatically authorize guild bank updates"])
	AltoholicTabOptionsFrame1_GuildBankAutoUpdate.tooltip = format("%s%s%s",
		L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto update their guild bank information with yours automatically.\n\n"],
		L["When |cFFFF0000disabled|cFFFFFFFF, your confirmation will be\nrequired before sending any information.\n\n"],
		L["Security hint: disable this if you have officer rights\non guild bank tabs that may not be viewed by everyone,\nand authorize requests manually"])
	
	L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto update their guild bank information with yours automatically.\n\n"] = nil
	L["When |cFFFF0000disabled|cFFFFFFFF, your confirmation will be\nrequired before sending any information.\n\n"] = nil
	L["Security hint: disable this if you have officer rights\non guild bank tabs that may not be viewed by everyone,\nand authorize requests manually"] = nil

	AltoholicTabOptionsFrame1_GuildCommText:SetText(L["Guild Communication Enabled"])
	
	L["Max rest XP displayed as 150%"] = nil
	L["Account Sharing Enabled"] = nil
	L["Guild Communication Enabled"] = nil
	L["Automatically authorize guild bank updates"] = nil
	
	value = AltoholicTabOptionsFrame1_SliderAngle:GetValue()
	AltoholicTabOptionsFrame1_SliderAngle.tooltipText = L["Move to change the angle of the minimap icon"]
	AltoholicTabOptionsFrame1_SliderAngleLow:SetText("1");
	AltoholicTabOptionsFrame1_SliderAngleHigh:SetText("360"); 
	AltoholicTabOptionsFrame1_SliderAngleText:SetText(format("%s (%s)", L["Minimap Icon Angle"], value))
	L["Move to change the angle of the minimap icon"] = nil
	
	value = AltoholicTabOptionsFrame1_SliderRadius:GetValue()
	AltoholicTabOptionsFrame1_SliderRadius.tooltipText = L["Move to change the radius of the minimap icon"]; 
	AltoholicTabOptionsFrame1_SliderRadiusLow:SetText("1");
	AltoholicTabOptionsFrame1_SliderRadiusHigh:SetText("200"); 
	AltoholicTabOptionsFrame1_SliderRadiusText:SetText(format("%s (%s)", L["Minimap Icon Radius"], value))
	L["Move to change the radius of the minimap icon"] = nil
	
	AltoholicTabOptionsFrame1_ShowMinimapText:SetText(L["Show Minimap Icon"])
	L["Show Minimap Icon"] = nil
	
	value = AltoholicTabOptionsFrame1_SliderAlpha:GetValue()
	AltoholicTabOptionsFrame1_SliderAlphaLow:SetText("0.1");
	AltoholicTabOptionsFrame1_SliderAlphaHigh:SetText("1.0"); 
	AltoholicTabOptionsFrame1_SliderAlphaText:SetText(format("%s (%1.2f)", L["Transparency"], value));
	
	-- ** Frame 2 : Search **
	AltoholicTabOptionsFrame2_SearchAutoQueryText:SetText(L["AutoQuery server |cFFFF0000(disconnection risk)"])
	AltoholicTabOptionsFrame2_SearchAutoQuery.tooltip = format("%s%s%s%s",
		L["|cFFFFFFFFIf an item not in the local item cache\nis encountered while searching loot tables,\nAltoholic will attempt to query the server for 5 new items.\n\n"],
		L["This will gradually improve the consistency of the searches,\nas more items are available in the item cache.\n\n"],
		L["There is a risk of disconnection if the queried item\nis a loot from a high level dungeon.\n\n"],
		L["|cFF00FF00Disable|r to avoid this risk"])	
	
	AltoholicTabOptionsFrame2_SortDescendingText:SetText(L["Sort loots in descending order"])
	AltoholicTabOptionsFrame2_IncludeNoMinLevelText:SetText(L["Include items without level requirement"])
	AltoholicTabOptionsFrame2_IncludeMailboxText:SetText(L["Include mailboxes"])
	AltoholicTabOptionsFrame2_IncludeGuildBankText:SetText(L["Include guild bank(s)"])
	AltoholicTabOptionsFrame2_IncludeRecipesText:SetText(L["Include known recipes"])
	AltoholicTabOptionsFrame2_IncludeGuildSkillsText:SetText(L["Include guild members' professions"])
	L["AutoQuery server |cFFFF0000(disconnection risk)"] = nil
	L["Sort loots in descending order"] = nil
	L["Include items without level requirement"] = nil
	L["Include mailboxes"] = nil
	L["Include guild bank(s)"] = nil
	L["Include known recipes"] = nil
	L["Include guild members' professions"] = nil
	
	-- ** Frame 3 : Mail **
	value = AltoholicTabOptionsFrame3_SliderMailExpiry:GetValue()
	AltoholicTabOptionsFrame3_SliderMailExpiry.tooltipText = L["Warn when mail expires in less days than this value"]; 
	AltoholicTabOptionsFrame3_SliderMailExpiryLow:SetText("1");
	AltoholicTabOptionsFrame3_SliderMailExpiryHigh:SetText("15"); 
	AltoholicTabOptionsFrame3_SliderMailExpiryText:SetText(format("%s (%s)", L["Mail Expiry Warning"], value))
	L["Warn when mail expires in less days than this value"] = nil
	
	AltoholicTabOptionsFrame3_CheckMailExpiryText:SetText(L["Mail Expiry Warning"])
	AltoholicTabOptionsFrame3_ScanMailBodyText:SetText(L["Scan mail body (marks it as read)"])
	L["Scan mail body (marks it as read)"] = nil
	
	AltoholicTabOptionsFrame3_GuildMailWarningText:SetText(L["New mail notification"])
	L["New mail notification"] = nil
		
	AltoholicTabOptionsFrame3_GuildMailWarning.tooltip = format("%s",
		L["Be informed when a guildmate sends a mail to one of my alts.\n\nMail content is directly visible without having to reconnect the character"])

	-- ** Frame 4 : Account Sharing **
	AltoholicTabOptionsFrame4_AccSharingCommText:SetText(L["Account Sharing Enabled"])
	AltoholicTabOptionsFrame4_AccSharingComm.tooltip = format("%s%s%s%s",
		L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto send you account sharing requests.\n"],
		L["Your confirmation will still be required any time someone requests your information.\n\n"],
		L["When |cFFFF0000disabled|cFFFFFFFF, all requests will be automatically rejected.\n\n"],
		L["Security hint: Only enable this when you actually need to transfer data,\ndisable otherwise"])

	L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto send you account sharing requests.\n"] = nil
	L["Your confirmation will still be required any time someone requests your information.\n\n"] = nil
	L["When |cFFFF0000disabled|cFFFFFFFF, all requests will be automatically rejected.\n\n"] = nil
	L["Security hint: Only enable this when you actually need to transfer data,\ndisable otherwise"] = nil

	AltoholicTabOptionsFrame4Text1:SetText(WHITE.."Authorizations")
	AltoholicTabOptionsFrame4Text2:SetText(WHITE..L["Character"])
	AltoholicTabOptionsFrame4Text3:SetText(WHITE.."Shared Content")
	AltoholicTabOptionsFrame4_InfoButton.tooltip = format("%s\n%s\n\n%s", 
	
	WHITE.."This list allows you to automate responses to account sharing requests.",
	"You can choose to automatically accept or reject requests, or be asked when a request comes in.",
	"If account sharing is totally disabled, this list will be ignored, and all requests will be rejected." )
	
	AltoholicTabOptionsFrame4IconNever:SetText("\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t")
	AltoholicTabOptionsFrame4IconAsk:SetText("\124TInterface\\RaidFrame\\ReadyCheck-Waiting:14\124t")
	AltoholicTabOptionsFrame4IconAuto:SetText("\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t")
	
	AltoholicTabOptionsFrame4_SharedContentInfoButton.tooltip = format("%s\n%s", 
		WHITE.."Select the content that will be visible to players who send you",
		"account sharing requests.")
	
	
	-- ** Frame 5 : Tooltip **
	AltoholicTabOptionsFrame5SourceText:SetText(L["Show item source"])
	AltoholicTabOptionsFrame5CountText:SetText(L["Show item count per character"])
	AltoholicTabOptionsFrame5TotalText:SetText(L["Show total item count"])
	AltoholicTabOptionsFrame5RecipeInfoText:SetText(L["Show already known/learnable by"])
	AltoholicTabOptionsFrame5ItemIDText:SetText(L["Show item ID and item level"])
	AltoholicTabOptionsFrame5GatheringNodeText:SetText(L["Show counters on gathering nodes"])
	AltoholicTabOptionsFrame5CrossFactionText:SetText(L["Show counters for both factions"])
	AltoholicTabOptionsFrame5MultiAccountText:SetText(L["Show counters for all accounts"])
	AltoholicTabOptionsFrame5GuildBankText:SetText(L["Show guild bank count"])
	AltoholicTabOptionsFrame5GuildBankCountText:SetText(L["Include guild bank count in the total count"])
	L["Show item source"] = nil
	L["Show item count per character"] = nil
	L["Show total item count"] = nil
	L["Show guild bank count"] = nil
	L["Show already known/learnable by"] = nil
	L["Show item ID and item level"] = nil
	L["Show counters on gathering nodes"] = nil
	L["Show counters for both factions"] = nil
	L["Show counters for all accounts"] = nil
	L["Include guild bank count in the total count"] = nil
	
	-- ** Frame 6 : Calendar **
	AltoholicTabOptionsFrame6FirstDayText:SetText(L["Week starts on Monday"])
	AltoholicTabOptionsFrame6Warning15Text:SetText(format(L["Warn %d minutes before an event starts"], 15))
	AltoholicTabOptionsFrame6Warning10Text:SetText(format(L["Warn %d minutes before an event starts"], 10))
	AltoholicTabOptionsFrame6Warning5Text:SetText(format(L["Warn %d minutes before an event starts"], 5))
	AltoholicTabOptionsFrame6Warning4Text:SetText(format(L["Warn %d minutes before an event starts"], 4))
	AltoholicTabOptionsFrame6Warning3Text:SetText(format(L["Warn %d minutes before an event starts"], 3))
	AltoholicTabOptionsFrame6Warning2Text:SetText(format(L["Warn %d minutes before an event starts"], 2))
	AltoholicTabOptionsFrame6Warning1Text:SetText(format(L["Warn %d minutes before an event starts"], 1))
	AltoholicTabOptionsFrame6DialogBoxText:SetText(L["Display warnings in a dialog box"])
	AltoholicTabOptionsFrame6DisableWarningsText:SetText(L["Disable warnings"])
	L["Week starts on Monday"] = nil
	L["Warn %d minutes before an event starts"] = nil
	L["Display warnings in a dialog box"] = nil
end

function Altoholic.Options:RestoreToUI()
	local O = Altoholic.db.global.options
	
	AltoholicTabOptionsFrame1_RestXPMode:SetChecked(O.RestXPMode)
	AltoholicTabOptionsFrame1_GuildBankAutoUpdate:SetChecked(O.GuildBankAutoUpdate)

	AltoholicTabOptionsFrame1_GuildComm:SetChecked(O.GuildHandlerEnabled)
	AltoholicTabOptionsFrame1_SliderAngle:SetValue(O.MinimapIconAngle)
	AltoholicTabOptionsFrame1_SliderRadius:SetValue(O.MinimapIconRadius)
	AltoholicTabOptionsFrame1_ShowMinimap:SetChecked(O.ShowMinimap)
	AltoholicTabOptionsFrame1_SliderScale:SetValue(O.UIScale)
	AltoholicFrame:SetScale(O.UIScale)
	AltoholicTabOptionsFrame1_SliderAlpha:SetValue(O.UITransparency)

	-- set communication handlers according to user settings.
	if O.AccSharingHandlerEnabled == 1 then
		Altoholic.Comm.Sharing:SetMessageHandler("ActiveHandler")
	else
		Altoholic.Comm.Sharing:SetMessageHandler("EmptyHandler")
	end
	
	if O.GuildHandlerEnabled == 1 then
		Altoholic.Comm.Guild:SetMessageHandler("ActiveHandler")
	else
		Altoholic.Comm.Guild:SetMessageHandler("EmptyHandler")
	end
	
	AltoholicTabOptionsFrame2_SearchAutoQuery:SetChecked(O.SearchAutoQuery)
	AltoholicTabOptionsFrame2_SortDescending:SetChecked(O.SortDescending)
	AltoholicTabOptionsFrame2_IncludeNoMinLevel:SetChecked(O.IncludeNoMinLevel)
	AltoholicTabOptionsFrame2_IncludeMailbox:SetChecked(O.IncludeMailbox)
	AltoholicTabOptionsFrame2_IncludeGuildBank:SetChecked(O.IncludeGuildBank)
	AltoholicTabOptionsFrame2_IncludeRecipes:SetChecked(O.IncludeRecipes)
	AltoholicTabOptionsFrame2_IncludeGuildSkills:SetChecked(O.IncludeGuildSkills)
	AltoholicTabOptionsFrame2LootInfo:SetText(GREEN .. O.TotalLoots .. "|r " .. L["Loots"] .. " / "
										.. GREEN .. O.UnknownLoots .. "|r " .. L["Unknown"])

	AltoholicTabOptionsFrame3_SliderMailExpiry:SetValue(O.MailWarningThreshold)
	AltoholicTabOptionsFrame3_CheckMailExpiry:SetChecked(O.CheckMailExpiry)
	
	AltoholicTabOptionsFrame3_ScanMailBody:SetChecked(DataStore:GetOption("DataStore_Mails", "ScanMailBody"))
	AltoholicTabOptionsFrame3_GuildMailWarning:SetChecked(O.GuildMailWarning)

	AltoholicTabOptionsFrame4_AccSharingComm:SetChecked(O.AccSharingHandlerEnabled)
	
	AltoholicTabOptionsFrame5Source:SetChecked(O.TooltipSource)
	AltoholicTabOptionsFrame5Count:SetChecked(O.TooltipCount)
	AltoholicTabOptionsFrame5Total:SetChecked(O.TooltipTotal)
	AltoholicTabOptionsFrame5GuildBank:SetChecked(O.TooltipGuildBank)
	AltoholicTabOptionsFrame5GuildBankCount:SetChecked(O.TooltipGuildBankCount)
	AltoholicTabOptionsFrame5RecipeInfo:SetChecked(O.TooltipRecipeInfo)
	AltoholicTabOptionsFrame5ItemID:SetChecked(O.TooltipItemID)
	AltoholicTabOptionsFrame5GatheringNode:SetChecked(O.TooltipGatheringNode)
	AltoholicTabOptionsFrame5CrossFaction:SetChecked(O.TooltipCrossFaction)
	AltoholicTabOptionsFrame5MultiAccount:SetChecked(O.TooltipMultiAccount)
	
	AltoholicTabOptionsFrame6FirstDay:SetChecked(O.WeekStartsMonday)
	AltoholicTabOptionsFrame6Warning15:SetChecked(O.Warning15Min)
	AltoholicTabOptionsFrame6Warning10:SetChecked(O.Warning10Min)
	AltoholicTabOptionsFrame6Warning5:SetChecked(O.Warning5Min)
	AltoholicTabOptionsFrame6Warning4:SetChecked(O.Warning4Min)
	AltoholicTabOptionsFrame6Warning3:SetChecked(O.Warning3Min)
	AltoholicTabOptionsFrame6Warning2:SetChecked(O.Warning2Min)
	AltoholicTabOptionsFrame6Warning1:SetChecked(O.Warning1Min)
	AltoholicTabOptionsFrame6DialogBox:SetChecked(O.WarningDialogBox)
	AltoholicTabOptionsFrame6DisableWarnings:SetChecked(O.DisableWarnings)
end

function Altoholic:UpdateMinimapIconCoords()
	-- Thanks to Atlas for this code, modified to fit this addon's requirements though
	local xPos, yPos = GetCursorPosition() 
	local left, bottom = Minimap:GetLeft(), Minimap:GetBottom() 

	xPos = left - xPos/UIParent:GetScale() + 70 
	yPos = yPos/UIParent:GetScale() - bottom - 70 

	local O = self.db.global.options
	O.MinimapIconAngle = math.deg(math.atan2(yPos, xPos))

	if(O.MinimapIconAngle < 0) then
		O.MinimapIconAngle = O.MinimapIconAngle + 360
	end
	AltoholicTabOptionsFrame1_SliderAngle:SetValue(O.MinimapIconAngle)
end

function Altoholic:MoveMinimapIcon()
	local O = self.db.global.options
	
	AltoholicMinimapButton:SetPoint(	"TOPLEFT", "Minimap", "TOPLEFT",
		54 - (O.MinimapIconRadius * cos(O.MinimapIconAngle)),
		(O.MinimapIconRadius * sin(O.MinimapIconAngle)) - 55	);
end

function Altoholic.Options:Get(name)
	return Altoholic.db.global.options[name]
end

function Altoholic.Options:Set(name, value)
	if Altoholic.db == nil then return end
	Altoholic.db.global.options[name] = value
end

function Altoholic.Options:Toggle(self, option)
	if self:GetChecked() then 
		Altoholic.Options:Set(option, 1)
	else
		Altoholic.Options:Set(option, 0)
	end
end
