local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local TEAL		= "|cFF00FF9A"
local ORANGE   = "|cFFFF8400"

local helpText
local url1 = "http://wow.curse.com/downloads/wow-addons/details/altoholic.aspx"
local url2 = "http://www.wowinterface.com/downloads/info8533-Altoholic.html"
local url3 = "http://wow.curseforge.com/addons/altoholic/localization/"

local help = {
	{	name = "General",
		questions = {
			"How do I remove a character that has been renamed/transfered/deleted?",
			"Does Altoholic support command line options?",
			"My minimap icon is gone, how do I get it back?",
			"What are the official homepages?",
			"What is this 'DataStore' thing? Why so many directories?",
			"I am developper, I want to know more about DataStore",
			"Does the add-on support FuBar?",
			"What is the add-on's memory footprint?",
			"Where have my suggestions gone?",
		},
		answers = {
			"Go into the 'Account Summary', mouse over the character, right-click it to get the contextual menu, and select 'Delete this Alt'.",
			"Type /alto or /altoholic to get the list of command line options.",
			"Go into Altoholic's main option panel, and check 'Show Minimap Icon'.\nYou can also type /alto show.",
			format("%s%s\n%s\n%s", "The add-on is only released on these two sites, it is recommended NOT TO get it through other means:", GREEN, url1, url2 ),
			"DataStore and its modules take care of storing data for client add-ons; Altoholic itself now only stores very little information. The main purpose of the numerous directories is to offer split databases, instead of one massive database containing all the information required by the add-on.",
			"Refer to DataStore's own help topic for more information.",
			"Not anymore. Instead, it supports LibDataBroker (aka LDB), if you really want FuBar, use Broker2FuBar.",
			"For 10 characters and 1 guild bank, the add-on takes around 4-5mb on my machine. Note that due to its name, the add-on is one of the first in the alphabet, and often gets credited of the memory/cpu usage of its libraries.",
			"Development is an iterative process, and I review parts of the add-on constantly. Depending on my spare time, some suggestions might take longer than others to make it into the add-on. Be patient, the add-on is still far from being complete.",
		}
	},
	{	name = "Containers",
		questions = {
			"Do I have to open all my bags to let the add-on know about their content?",
			"What about my bank? .. and my guild bank?",
			"Will the content of my bags be visible in the tooltip? Can I configure that?",
		},
		answers = {
			"No. This happens silently and does not require any action from your part.",
			"You have to open your bank in order to let the add-on read its content. Same goes for the guild bank, except that the add-on can only read it tab per tab, so make sure to open them all.",
			"Yes. There are several tooltip options that can be set to specify what you want to see or not."
		}
	},
	{	name = "Professions",
		questions = {
			"Do I have to open all professions manually?",
		},
		answers = {
			"Yes. Some advanced features require that you open the tradeskill pane once per profession.",
		}
	},
	{	name = "Mails",
		questions = {
			"Can Altoholic read my mails without being at the mailbox?",
			"Altoholic marks all my mails as read, how can I avoid that?",
			"My mailbox is full, can Altoholic read beyond the list of visible mails?",
		},
		answers = {
			"No. This is a restriction imposed by Blizzard. Your character must physically be at a mailbox to retrieve your mails.",
			"Go into the 'Mail Options' and disable 'Scan mail body'.",
			"No. You will have to clear your mailbox to release mails that are queued server-side.",
		}
	},
	{	name = "Localization",
		questions = {
			"I found a bad translation, how can I help fixing it?",
		},
		answers = {
			format("Use the CurseForge localization tool, at %s|r.", GREEN..url3),
		}
	},
	{	name = "Reporting Bugs",
		questions = {
			"I found an error, how/where do I report it?",
			"What should I do before reporting?",
			"I just upgraded to the latest version, and there are so many Lua errors, what the..??",
			"I have multiple Lua errors at login, should I report them all?",
			"Thaoky you're so cool, can I hire you?",
		},
		answers = {
			"Both Curse and WoWInterface have a ticket section, I also read comments and respond as often as I materially can, so feel free to report in one of these places.",
			format("%s\n\n%s\n%s\n%s\n%s\n%s\n", 
				"A few things:",
				"1) Make sure you have the latest version of the add-on.",
				"2) If you suspect a conflict with another add-on, try to reproduce the issue with only Altoholic enabled. As the add-on deals with a lot of things, a conflict is always possible.",
				"3) Make sure your issue has not been reported by someone else.",
				"4) Never, ever, report that 'it does not work', this is the most useless sentence in the world! Be specific about what does not work.",
				"5) DO NOT copy the entire add-on list from Swatter. While conflicts are possible, they are the exception rather than the rule."
			),
			"I'm just human, I make mistakes. But because I'm human, I fix them too, so be patient. This is a project that I develop in my spare time, and it fluctuates a lot.",
			"No. Only the first error you will get is relevant, it means that something failed during the initialization process of the add-on, or of a library, and this is likely to cause several subsequent errors that are more often than not irrelevant.",
			format("%s\n%s|r\n%s\n%s",
				"That would be a very good idea! :)\nFull resume is available on demand, send serious job proposals by mail:",
				GREEN.."thaoky.altoholic@yahoo.com",
				"Age: 33\nSector: IT\nReady to relocate about anywhere in the EU & the US.",
				"Positions sought include (but are not limited to): Project Management, Solutions Architect, Software Development."
			)
		}
	},
	{	name = "Live support",
		questions = {
			"Is there an IRC channel where I could get live support?",
		},
		answers = {
			format("Yes. Join the %s#altoholic|r IRC channel on Freenode : %sirc://irc.freenode.net:6667/|r", WHITE, GREEN),
		}
	},
}

-- this content will be subject to frequent changes, do not bother translating it !!
local whatsnew = {
	{	name = "3.3.001 Changes",
		bulletedList = {
			"Added two new options in DataStore_Mails to check mail expiries for all accounts and/or all realms.",
			"Slightly modified the options panels to better fit all resolutions/UI scales.",
			"The 'Shared Content' scroll frame now has its own panel, right under 'Account Sharing'.",
			"Added an option to automatically clear expired auctions and bids (DataStore_Auctions).",
			"Fixed a bug where mail counters were not always displayed in the tooltip. (Thanks Quagm1re !)",
			"Added currencies count to the tooltip.",
			"Added 4 missing pets.",
			"Added mandatory dependencies on DataStore_Characters & DataStore_Containers.",
			"Manually updated the loot tables of Onyxia's Lair & ToC.",
		},
	},
	{	name = "3.2.003b Changes",
		bulletedList = {
			"The options tab has been removed, all options are now available in the Blizzard Options panel. A button has been added at the top of the summary tab, for faster access.",
			"Added an help topic in the options panel.",
			"Added a 'What's new' topic in the options panel.",
			"Fixed a few Lua errors.",
			"Added an option to turn off the broadcast of profession links to the guild channel into DataStore_Crafts. This is what consumes the most bandwidth, so disable it if you/your guild considers this as critical.",
		},
	},
	{	name = "3.2.003 Changes",
		bulletedList = {
			"Fixed a compatibility issue with MrTrader (DataStore_Crafts).",
			"Added the character skill level in the recipe tooltip.",
			"Fixed a Lua error in when trying to get the item count of a missing character.",
			"Fixed invalid reporting of the number of free bank slots.",
			"Added a counter in the achievements tooltip to show the amount of completed criterias.",
			"Some achievement categories are now sorted in a custom fashion, rather than alphabetically, in order to show progressive achievements side by side.",
			"Achievements can now be linked into chat frames. You will need to relog your alts at least once for this to work.",
			"Moved the option that manages the mail expiry threshold to DataStore_Mails. It is thus reset to 5 days for everyone, make sure to change it back to whatever you like in the options pane.",
			"Guild communication has been entirely rewritten.", 
			"Brought a few improvements to the Guild Bank Tabs pane.",
			"Improved return mail support. If a guildmate returns a mail to one of your alts, you will be notified immediately.",
			"Mail expiries are now checked 5 seconds after login.",
			"Your alts' professions are now sent 5 seconds after login at a pace of 1 per 0.5 seconds.",
			"Guild member professions will now automatically be cleaned after a patch, to make sure your database only contains usable links.",
			"Most money amounts are now displayed using money icons.",
			"DataStore_Talents now scans talent tree reference only once per game patch.",
			"Fixed several Lua errors in various places.",
		},
	},
	{	name = "Earlier changes",
		textLines = {
			"Refer to |cFF00FF00changelog.txt",
		},
	},
}

Altoholic.Options = {}

function Altoholic.Options:Init()
	-- create categories in Blizzard's options panel
	local addonName = "Altoholic"
	
	DataStore:AddOptionCategory(AltoholicGeneralOptions, addonName)
	LibStub("LibAboutPanel").new(addonName, addonName);
	DataStore:AddOptionCategory(AltoholicHelp, HELP_LABEL, addonName)
	DataStore:AddOptionCategory(AltoholicWhatsNew, "What's new?", addonName)
	DataStore:AddOptionCategory(AltoholicSearchOptions, SEARCH, addonName)
	DataStore:AddOptionCategory(AltoholicMailOptions, MAIL_LABEL, addonName)
	DataStore:AddOptionCategory(AltoholicAccountSharingOptions, L["Account Sharing"], addonName)
	DataStore:AddOptionCategory(AltoholicSharedContent, "Shared Content", addonName)
	DataStore:AddOptionCategory(AltoholicTooltipOptions, L["Tooltip"], addonName)
	DataStore:AddOptionCategory(AltoholicCalendarOptions, L["Calendar"], addonName)

	DataStore:SetupInfoPanel(help, AltoholicHelp_Text)
	DataStore:SetupInfoPanel(whatsnew, AltoholicWhatsNew_Text)
	
	local value
	
	-- ** General **
	AltoholicGeneralOptions_Title:SetText(TEAL..format("Altoholic %s", Altoholic.Version))
	AltoholicGeneralOptions_RestXPModeText:SetText(L["Max rest XP displayed as 150%"])
	AltoholicGeneralOptions_GuildBankAutoUpdateText:SetText(L["Automatically authorize guild bank updates"])
	AltoholicGeneralOptions_GuildBankAutoUpdate.tooltip = format("%s%s%s",
		L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto update their guild bank information with yours automatically.\n\n"],
		L["When |cFFFF0000disabled|cFFFFFFFF, your confirmation will be\nrequired before sending any information.\n\n"],
		L["Security hint: disable this if you have officer rights\non guild bank tabs that may not be viewed by everyone,\nand authorize requests manually"])
	
	L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto update their guild bank information with yours automatically.\n\n"] = nil
	L["When |cFFFF0000disabled|cFFFFFFFF, your confirmation will be\nrequired before sending any information.\n\n"] = nil
	L["Security hint: disable this if you have officer rights\non guild bank tabs that may not be viewed by everyone,\nand authorize requests manually"] = nil
	L["Max rest XP displayed as 150%"] = nil
	L["Automatically authorize guild bank updates"] = nil
	
	value = AltoholicGeneralOptions_SliderAngle:GetValue()
	AltoholicGeneralOptions_SliderAngle.tooltipText = L["Move to change the angle of the minimap icon"]
	AltoholicGeneralOptions_SliderAngleLow:SetText("1");
	AltoholicGeneralOptions_SliderAngleHigh:SetText("360"); 
	AltoholicGeneralOptions_SliderAngleText:SetText(format("%s (%s)", L["Minimap Icon Angle"], value))
	L["Move to change the angle of the minimap icon"] = nil
	
	value = AltoholicGeneralOptions_SliderRadius:GetValue()
	AltoholicGeneralOptions_SliderRadius.tooltipText = L["Move to change the radius of the minimap icon"]; 
	AltoholicGeneralOptions_SliderRadiusLow:SetText("1");
	AltoholicGeneralOptions_SliderRadiusHigh:SetText("200"); 
	AltoholicGeneralOptions_SliderRadiusText:SetText(format("%s (%s)", L["Minimap Icon Radius"], value))
	L["Move to change the radius of the minimap icon"] = nil
	
	AltoholicGeneralOptions_ShowMinimapText:SetText(L["Show Minimap Icon"])
	L["Show Minimap Icon"] = nil
	
	value = AltoholicGeneralOptions_SliderAlpha:GetValue()
	AltoholicGeneralOptions_SliderAlphaLow:SetText("0.1");
	AltoholicGeneralOptions_SliderAlphaHigh:SetText("1.0"); 
	AltoholicGeneralOptions_SliderAlphaText:SetText(format("%s (%1.2f)", L["Transparency"], value));
	
	-- ** Search **
	AltoholicSearchOptions_SearchAutoQueryText:SetText(L["AutoQuery server |cFFFF0000(disconnection risk)"])
	AltoholicSearchOptions_SearchAutoQuery.tooltip = format("%s%s%s%s",
		L["|cFFFFFFFFIf an item not in the local item cache\nis encountered while searching loot tables,\nAltoholic will attempt to query the server for 5 new items.\n\n"],
		L["This will gradually improve the consistency of the searches,\nas more items are available in the item cache.\n\n"],
		L["There is a risk of disconnection if the queried item\nis a loot from a high level dungeon.\n\n"],
		L["|cFF00FF00Disable|r to avoid this risk"])	
	
	AltoholicSearchOptions_SortDescendingText:SetText(L["Sort loots in descending order"])
	AltoholicSearchOptions_IncludeNoMinLevelText:SetText(L["Include items without level requirement"])
	AltoholicSearchOptions_IncludeMailboxText:SetText(L["Include mailboxes"])
	AltoholicSearchOptions_IncludeGuildBankText:SetText(L["Include guild bank(s)"])
	AltoholicSearchOptions_IncludeRecipesText:SetText(L["Include known recipes"])
	AltoholicSearchOptions_IncludeGuildSkillsText:SetText(L["Include guild members' professions"])
	L["AutoQuery server |cFFFF0000(disconnection risk)"] = nil
	L["Sort loots in descending order"] = nil
	L["Include items without level requirement"] = nil
	L["Include mailboxes"] = nil
	L["Include guild bank(s)"] = nil
	L["Include known recipes"] = nil
	L["Include guild members' professions"] = nil
	
	-- ** Mail **
	AltoholicMailOptions_GuildMailWarningText:SetText(L["New mail notification"])
	L["New mail notification"] = nil
		
	AltoholicMailOptions_GuildMailWarning.tooltip = format("%s",
		L["Be informed when a guildmate sends a mail to one of my alts.\n\nMail content is directly visible without having to reconnect the character"])

	AltoholicMailOptions_NameAutoCompleteText:SetText("Auto-complete recipient name" )
		
	-- ** Account Sharing **
	AltoholicAccountSharingOptions_AccSharingCommText:SetText(L["Account Sharing Enabled"])
	AltoholicAccountSharingOptions_AccSharingComm.tooltip = format("%s%s%s%s",
		L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto send you account sharing requests.\n"],
		L["Your confirmation will still be required any time someone requests your information.\n\n"],
		L["When |cFFFF0000disabled|cFFFFFFFF, all requests will be automatically rejected.\n\n"],
		L["Security hint: Only enable this when you actually need to transfer data,\ndisable otherwise"])

	L["Account Sharing Enabled"] = nil
	L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto send you account sharing requests.\n"] = nil
	L["Your confirmation will still be required any time someone requests your information.\n\n"] = nil
	L["When |cFFFF0000disabled|cFFFFFFFF, all requests will be automatically rejected.\n\n"] = nil
	L["Security hint: Only enable this when you actually need to transfer data,\ndisable otherwise"] = nil

	AltoholicAccountSharingOptionsText1:SetText(WHITE.."Authorizations")
	AltoholicAccountSharingOptionsText2:SetText(WHITE..L["Character"])
	AltoholicAccountSharingOptions_InfoButton.tooltip = format("%s\n%s\n\n%s", 
	
	WHITE.."This list allows you to automate responses to account sharing requests.",
	"You can choose to automatically accept or reject requests, or be asked when a request comes in.",
	"If account sharing is totally disabled, this list will be ignored, and all requests will be rejected." )
	
	AltoholicAccountSharingOptionsIconNever:SetText("\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t")
	AltoholicAccountSharingOptionsIconAsk:SetText("\124TInterface\\RaidFrame\\ReadyCheck-Waiting:14\124t")
	AltoholicAccountSharingOptionsIconAuto:SetText("\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t")
	
	-- ** Shared Content **
	AltoholicSharedContentText1:SetText(WHITE.."Shared Content")
	AltoholicSharedContent_SharedContentInfoButton.tooltip = format("%s\n%s", 
		WHITE.."Select the content that will be visible to players who send you",
		"account sharing requests.")
	
	
	-- ** Tooltip **
	AltoholicTooltipOptionsSourceText:SetText(L["Show item source"])
	AltoholicTooltipOptionsCountText:SetText(L["Show item count per character"])
	AltoholicTooltipOptionsTotalText:SetText(L["Show total item count"])
	AltoholicTooltipOptionsRecipeInfoText:SetText(L["Show already known/learnable by"])
	AltoholicTooltipOptionsItemIDText:SetText(L["Show item ID and item level"])
	AltoholicTooltipOptionsGatheringNodeText:SetText(L["Show counters on gathering nodes"])
	AltoholicTooltipOptionsCrossFactionText:SetText(L["Show counters for both factions"])
	AltoholicTooltipOptionsMultiAccountText:SetText(L["Show counters for all accounts"])
	AltoholicTooltipOptionsGuildBankText:SetText(L["Show guild bank count"])
	AltoholicTooltipOptionsGuildBankCountText:SetText(L["Include guild bank count in the total count"])
	AltoholicTooltipOptionsGuildBankCountPerTabText:SetText(L["Detailed guild bank count"])
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
	
	-- ** Calendar **
	AltoholicCalendarOptionsFirstDayText:SetText(L["Week starts on Monday"])
	AltoholicCalendarOptionsDialogBoxText:SetText(L["Display warnings in a dialog box"])
	AltoholicCalendarOptionsDisableWarningsText:SetText(L["Disable warnings"])
	L["Week starts on Monday"] = nil
	L["Warn %d minutes before an event starts"] = nil
	L["Display warnings in a dialog box"] = nil
	
	for i = 1, 4 do 
		UIDropDownMenu_Initialize(_G["AltoholicCalendarOptions_WarningType"..i], Altoholic.Calendar.WarningType_Initialize)
	end
	UIDropDownMenu_SetText(AltoholicCalendarOptions_WarningType1, "Profession Cooldowns")
	UIDropDownMenu_SetText(AltoholicCalendarOptions_WarningType2, "Dungeon Resets")
	UIDropDownMenu_SetText(AltoholicCalendarOptions_WarningType3, "Calendar Events")
	UIDropDownMenu_SetText(AltoholicCalendarOptions_WarningType4, "Item Timers")
end

function Altoholic.Options:RestoreToUI()
	local O = Altoholic.db.global.options
	
	AltoholicGeneralOptions_RestXPMode:SetChecked(O.RestXPMode)
	AltoholicGeneralOptions_GuildBankAutoUpdate:SetChecked(O.GuildBankAutoUpdate)

	AltoholicGeneralOptions_SliderAngle:SetValue(O.MinimapIconAngle)
	AltoholicGeneralOptions_SliderRadius:SetValue(O.MinimapIconRadius)
	AltoholicGeneralOptions_ShowMinimap:SetChecked(O.ShowMinimap)
	AltoholicGeneralOptions_SliderScale:SetValue(O.UIScale)
	AltoholicFrame:SetScale(O.UIScale)
	AltoholicGeneralOptions_SliderAlpha:SetValue(O.UITransparency)

	-- set communication handlers according to user settings.
	if O.AccSharingHandlerEnabled == 1 then
		Altoholic.Comm.Sharing:SetMessageHandler("ActiveHandler")
	else
		Altoholic.Comm.Sharing:SetMessageHandler("EmptyHandler")
	end
	
	AltoholicSearchOptions_SearchAutoQuery:SetChecked(O.SearchAutoQuery)
	AltoholicSearchOptions_SortDescending:SetChecked(O.SortDescending)
	AltoholicSearchOptions_IncludeNoMinLevel:SetChecked(O.IncludeNoMinLevel)
	AltoholicSearchOptions_IncludeMailbox:SetChecked(O.IncludeMailbox)
	AltoholicSearchOptions_IncludeGuildBank:SetChecked(O.IncludeGuildBank)
	AltoholicSearchOptions_IncludeRecipes:SetChecked(O.IncludeRecipes)
	AltoholicSearchOptions_IncludeGuildSkills:SetChecked(O.IncludeGuildSkills)
	AltoholicSearchOptionsLootInfo:SetText(GREEN .. O.TotalLoots .. "|r " .. L["Loots"] .. " / "
										.. GREEN .. O.UnknownLoots .. "|r " .. L["Unknown"])

	AltoholicMailOptions_GuildMailWarning:SetChecked(O.GuildMailWarning)
	AltoholicMailOptions_NameAutoComplete:SetChecked(O.NameAutoComplete)

	AltoholicAccountSharingOptions_AccSharingComm:SetChecked(O.AccSharingHandlerEnabled)
	
	AltoholicTooltipOptionsSource:SetChecked(O.TooltipSource)
	AltoholicTooltipOptionsCount:SetChecked(O.TooltipCount)
	AltoholicTooltipOptionsTotal:SetChecked(O.TooltipTotal)
	AltoholicTooltipOptionsGuildBank:SetChecked(O.TooltipGuildBank)
	AltoholicTooltipOptionsGuildBankCount:SetChecked(O.TooltipGuildBankCount)
	AltoholicTooltipOptionsGuildBankCountPerTab:SetChecked(O.TooltipGuildBankCountPerTab)
	AltoholicTooltipOptionsRecipeInfo:SetChecked(O.TooltipRecipeInfo)
	AltoholicTooltipOptionsItemID:SetChecked(O.TooltipItemID)
	AltoholicTooltipOptionsGatheringNode:SetChecked(O.TooltipGatheringNode)
	AltoholicTooltipOptionsCrossFaction:SetChecked(O.TooltipCrossFaction)
	AltoholicTooltipOptionsMultiAccount:SetChecked(O.TooltipMultiAccount)
	
	AltoholicCalendarOptionsFirstDay:SetChecked(O.WeekStartsMonday)
	AltoholicCalendarOptionsDialogBox:SetChecked(O.WarningDialogBox)
	AltoholicCalendarOptionsDisableWarnings:SetChecked(O.DisableWarnings)
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
	AltoholicGeneralOptions_SliderAngle:SetValue(O.MinimapIconAngle)
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

local function ResizeScrollFrame(frame, width, height)
	-- just a small wrapper, nothing generic in here.
	
	local name = frame:GetName()
	_G[name]:SetWidth(width-45)
	_G[name.."_ScrollFrame"]:SetWidth(width-45)
	_G[name]:SetHeight(height-30)
	_G[name.."_ScrollFrame"]:SetHeight(height-30)
	_G[name.."_Text"]:SetWidth(width-80)
end

local OnSizeUpdate = {	-- custom resize functions
	AltoholicHelp = ResizeScrollFrame,
	AltoholicWhatsNew = ResizeScrollFrame,

	-- AltoholicWhatsNew = function(self, width, height)
			-- AltoholicWhatsNew:SetWidth(width-45)
			-- AltoholicWhatsNew_ScrollFrame:SetWidth(width-45)
			-- AltoholicWhatsNew:SetHeight(height-30)
			-- AltoholicWhatsNew_ScrollFrame:SetHeight(height-30)
			-- AltoholicWhatsNew_Text:SetWidth(width-80)
		-- end,
}

local OptionsPanelWidth, OptionsPanelHeight
local lastOptionsPanelWidth = 0
local lastOptionsPanelHeight = 0

function Altoholic.Options:OnUpdate(self, mandatoryResize)
	OptionsPanelWidth = InterfaceOptionsFramePanelContainer:GetWidth()
	OptionsPanelHeight = InterfaceOptionsFramePanelContainer:GetHeight()
	
	if not mandatoryResize then -- if resize is not mandatory, allow exit
		if OptionsPanelWidth == lastOptionsPanelWidth and OptionsPanelHeight == lastOptionsPanelHeight then return end		-- no size change ? exit
	end
		
	lastOptionsPanelWidth = OptionsPanelWidth
	lastOptionsPanelHeight = OptionsPanelHeight
	
	local frameName = self:GetName()
	if frameName and OnSizeUpdate[frameName] then
		OnSizeUpdate[frameName](self, OptionsPanelWidth, OptionsPanelHeight)
	end
end
