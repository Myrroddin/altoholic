local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "deDE" )

if not L then return end

--@localization(locale="deDE", format="lua_additive_table", handle-unlocalized="ignore", escape-non-ascii=false, same-key-is-true=true)@

if GetLocale() == "deDE" then

-- This is a global string from wow, for some reason the original is causing problem. DO NOT copy this line in other languages !!!
ITEM_MOD_SPELL_POWER = "Erh\195\182ht die Zaubermacht um %d."; 

-- Altoholic.xml local
LEFT_HINT = "Links-Klick zum |cFF00FF00öffnen";
RIGHT_HINT = "Rechts-Klick zum |cFF00FF00bewegen";

XML_ALTO_SHARING_HINT1 = "Enter an account name that will be\nused for |cFF00FF00display|r purposes only.\n"
				.. "This name can be anything you like,\nit does |cFF00FF00NOT|r have to be the real account name.\n\n"
XML_ALTO_SHARING_HINT2 = "This field |cFF00FF00cannot|r be left empty."

XML_ALTO_TAB1 = "Zusammenfassung"
XML_ALTO_TAB2 = "Charaktere"
XML_ALTO_TAB3 = "Suche"
-- XML_ALTO_TAB4 = GUILD_BANK
XML_ALTO_TABOPTIONS = "Optionen"

XML_ALTO_SUMMARY_MENU1 = "Account Übersicht"
XML_ALTO_SUMMARY_MENU2 = "Taschennutzung"
-- XML_ALTO_SUMMARY_MENU3 = SKILLS
XML_ALTO_SUMMARY_MENU4 = "Activity"
XML_ALTO_SUMMARY_MENU5 = "Guild Members"
XML_ALTO_SUMMARY_MENU6 = "Guild Skills"
XML_ALTO_SUMMARY_MENU7 = "Guild Bank Tabs"

XML_ALTO_SUMMARY_TEXT1 = "Account Sharing Request"
XML_ALTO_SUMMARY_TEXT2 = "Click this button to ask a player\n"
				.. "to share his entire Altoholic Database\n"
				.. "and add it to your own"
XML_ALTO_SUMMARY_TEXT3 = "Both parties must enable account sharing\nbefore using this feature (see options)"
XML_ALTO_SUMMARY_TEXT4 = "Account Sharing"


XML_ALTO_CHAR_DD1 = "Realm"
XML_ALTO_CHAR_DD2 = "Charakter"
XML_ALTO_CHAR_DD3 = "Anzeigen"

XML_ALTO_SEARCH_COL1 = "Item / Location"

XML_ALTO_GUILD_TEXT1 = "Hide this guild in the tooltip"

XML_ALTO_ACH_NOTSTARTED = "Not started"
XML_ALTO_ACH_STARTED = "Started"

XML_ALTO_OPT_MENU1 = "Allgemein"
XML_ALTO_OPT_MENU2 = "Suche"
XML_ALTO_OPT_MENU3 = "Postfach"
XML_ALTO_OPT_MENU4 = "Minimap"
XML_ALTO_OPT_MENU5 = "Tooltip"

XML_TEXT_1 = "Gesamt";
XML_TEXT_2 = "Suche";
XML_TEXT_3 = "Level Bereich";
XML_TEXT_4 = "Seltenheit";
XML_TEXT_5 = "Ausrüstungsplatz";
XML_TEXT_6 = "Zurücksetzen";
XML_TEXT_7 = "Suche";

XML_ALTO_TEXT10 = "Account Name"
XML_ALTO_TEXT11 = "Send account sharing request to:"

--Options.xml
XML_ALTO_OPT_GENERAL1 = "Maximale Erholt-XP wird angezeigt als 150%";
XML_ALTO_OPT_GENERAL2 = "Show FuBar icon";
XML_ALTO_OPT_GENERAL3 = "Show FuBar text";
XML_ALTO_OPT_GENERAL4 = "Account Sharing Enabled";
XML_ALTO_OPT_GENERAL5 = "Guild Communication Enabled";
XML_ALTO_OPT_GENERAL6 = "|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\n"
				.. "to send you account sharing requests.\n"
				.. "Your confirmation will still be required any time someone requests your information.\n\n"
				.. "When |cFFFF0000disabled|cFFFFFFFF, all requests will be automatically rejected.\n\n"
				.. "Security hint: Only enable this when you actually need to transfer data,\ndisable otherwise"
XML_ALTO_OPT_GENERAL7 = "|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow your guildmates\n"
				.. "to see your alts and their professions.\n\n"
				.. "When |cFFFF0000disabled|cFFFFFFFF, there will be no communication with the guild."
XML_ALTO_OPT_GENERAL8 = "Automatically authorize guild bank updates"
XML_ALTO_OPT_GENERAL9 = "|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\n"
				.. "to update their guild bank information with yours automatically.\n\n"
				.. "When |cFFFF0000disabled|cFFFFFFFF, your confirmation will be\n"
				.. "required before sending any information.\n\n"
				.. "Security hint: disable this if you have officer rights\n"
				.. "on guild bank tabs that may not be viewed by everyone,\n"
				.. "and authorize requests manually"

XML_ALTO_OPT_SEARCH1 = "AutoAbfrage vom Server |cFFFF0000(disconnection risiko)";
XML_ALTO_OPT_SEARCH2 = "|cFFFFFFFFWenn ein Item, dass nicht im lokalen Item Cache\n"
				.. "ist, gefunden wird, während die Loot Tabellen durchsucht werden,\n"
				.. "wird Altoholic versuchen den Server nach 5 neuen Items abzufragen.\n\n"
				.. "Dieses verbessert stufenweise die Übereinstimmung der Suchen,\n"
				.. "da mehr Einzelteile im Item Cache vorhanden sind\n\n"
				.. "Es gibt ein Disconnect Risiko, wenn das gefragte Item\n"
				.. "eine Beute von einem High Level Dungeon ist.\n\n"
				.. "|cFF00FF00Deaktivieren|r um das Risiko zu vermeiden";
XML_ALTO_OPT_SEARCH3 = "Loot in absteigender Reihenfolge sortieren";
XML_ALTO_OPT_SEARCH4 = "Items ohne Levelbegrenzung hinzufügen";
XML_ALTO_OPT_SEARCH5 = "Postfach hinzufügen";
XML_ALTO_OPT_SEARCH6 = "Gildenbank hinzufügen";
XML_ALTO_OPT_SEARCH7 = "Bekannte Rezepte hinzufügen";

XML_ALTO_OPT_MAIL1 = "Warnen, wenn Post abläuft in weniger Tagen als";
XML_ALTO_OPT_MAIL2 = "Mail Ablauf Warnung";
XML_ALTO_OPT_MAIL3 = "Inhalt der Briefe scannen (markiert als gelesen)";
XML_ALTO_OPT_MAIL4 = "New mail notification";
XML_ALTO_OPT_MAIL5 = "Be informed when a guildmate sends a mail to one of my alts.\n\n"
				.. "Mail content is directly visible without having to reconnect the character";

XML_ALTO_OPT_MINIMAP1 = "Bewegen um den Winkel an der Minimap zu ändern";
XML_ALTO_OPT_MINIMAP2 = "Minimap Icon Winkel";
XML_ALTO_OPT_MINIMAP3 = "Bewegen um den Radius an der Minimap zu ändern";
XML_ALTO_OPT_MINIMAP4 = "Minimap Icon Radius";
XML_ALTO_OPT_MINIMAP5 = "Minimap Icon zeigen";

XML_ALTO_OPT_TOOLTIP1 = "Item Quelle anzeigen"; 
XML_ALTO_OPT_TOOLTIP2 = "Anzahl der Items pro Charakter anzeigen";
XML_ALTO_OPT_TOOLTIP3 = "Anzahl der Gesamtzahl der Items anzeigen";
XML_ALTO_OPT_TOOLTIP4 = "Gildenbank miteinbeziehen";
XML_ALTO_OPT_TOOLTIP5 = "Bereits bekannt/Erlernbar durch miteinbeziehen";
XML_ALTO_OPT_TOOLTIP6 = "Show item ID and item Level";
XML_ALTO_OPT_TOOLTIP7 = "Show counters on gathering nodes";
XML_ALTO_OPT_TOOLTIP8 = "Show counters for both factions";
XML_ALTO_OPT_TOOLTIP9 = "Show counters for all accounts";
XML_ALTO_OPT_TOOLTIP10 = "Include guild bank count in the total count";
end
