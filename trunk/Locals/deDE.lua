local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "deDE" )

if not L then return end

--@localization(locale="deDE", format="lua_additive_table", handle-unlocalized="ignore", escape-non-ascii=false, same-key-is-true=true)@

L["Location"] = true
L["Left-click to |cFF00FF00open"] = "Links-Klick zum |cFF00FF00öffnen"
L["Right-click to |cFF00FF00drag"] = "Rechts-Klick zum |cFF00FF00bewegen"
L["Enter an account name that will be\nused for |cFF00FF00display|r purposes only."] = true
L["This name can be anything you like,\nit does |cFF00FF00NOT|r have to be the real account name."] = true
L["This field |cFF00FF00cannot|r be left empty."] = true

L["Summary"] = "Zusammenfassung"
L["Characters"] = "Charaktere"

L["Account Summary"] = "Account Übersicht"
L["Bag Usage"] = "Taschennutzung"
L["Activity"] = true
L["Guild Members"] = true
L["Guild Skills"] = true
L["Guild Bank Tabs"] = true
L["Calendar"] = true

L["Account Sharing Request"] = true
L["Click this button to ask a player\nto share his entire Altoholic Database\nand add it to your own"] = true
L["Both parties must enable account sharing\nbefore using this feature (see options)"] = true
L["Account Sharing"] = true

L["Realm"] = "Realm"
L["Character"] = "Charakter"
L["View"] = "Anzeigen"

L["Item / Location"] = true

L["Hide this guild in the tooltip"] = true

L["Not started"] = true
L["Started"] = true

L["General"] = "Allgemein"
L["Tooltip"] = "Tooltip"

L["Totals"] = "Gesamt"
L["Search Containers"] = "Suche"
L["Equipment Slot"] = "Ausrüstungsplatz"
L["Reset"] = "Zurücksetzen"

L["Account Name"] = true
L["Send account sharing request to:"] = true

--TabOptions.lua

-- ** Frame 1 : General **
L["Max rest XP displayed as 150%"] = "Maximale Erholt-XP wird angezeigt als 150%"
L["Show FuBar icon"] = true
L["Show FuBar text"] = true
L["Account Sharing Enabled"] = true
L["Guild Communication Enabled"] = true

L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto send you account sharing requests.\n"] = true
L["Your confirmation will still be required any time someone requests your information.\n\n"] = true
L["When |cFFFF0000disabled|cFFFFFFFF, all requests will be automatically rejected.\n\n"] = true
L["Security hint: Only enable this when you actually need to transfer data,\ndisable otherwise"] = true

L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow your guildmates\nto see your alts and their professions.\n\n"] = true
L["When |cFFFF0000disabled|cFFFFFFFF, there will be no communication with the guild."] = true

L["Automatically authorize guild bank updates"] = true

L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto update their guild bank information with yours automatically.\n\n"] = true
L["When |cFFFF0000disabled|cFFFFFFFF, your confirmation will be\nrequired before sending any information.\n\n"] = true
L["Security hint: disable this if you have officer rights\non guild bank tabs that may not be viewed by everyone,\nand authorize requests manually"] = true
L["Transparency"] = true

-- ** Frame 2 : Search **
L["AutoQuery server |cFFFF0000(disconnection risk)"] = "AutoAbfrage vom Server |cFFFF0000(disconnection risiko)"
L["|cFFFFFFFFIf an item not in the local item cache\nis encountered while searching loot tables,\nAltoholic will attempt to query the server for 5 new items.\n\n"] = "|cFFFFFFFFWenn ein Item, dass nicht im lokalen Item Cache\nist, gefunden wird, während die Loot Tabellen durchsucht werden,\nwird Altoholic versuchen den Server nach 5 neuen Items abzufragen.\n\n"
L["This will gradually improve the consistency of the searches,\nas more items are available in the item cache.\n\n"] = "Dieses verbessert stufenweise die Übereinstimmung der Suchen,\nda mehr Einzelteile im Item Cache vorhanden sind.\n\n"
L["There is a risk of disconnection if the queried item\nis a loot from a high level dungeon.\n\n"] = "Es gibt ein Disconnect Risiko, wenn das gefragte Item\neine Beute von einem High Level Dungeon ist.\n\n"
L["|cFF00FF00Disable|r to avoid this risk"] = "|cFF00FF00Deaktivieren|r um das Risiko zu vermeiden"
L["Sort loots in descending order"] = "Loot in absteigender Reihenfolge sortieren"
L["Include items without level requirement"] = "Items ohne Levelbegrenzung hinzufügen"
L["Include mailboxes"] = "Postfach hinzufügen"
L["Include guild bank(s)"] = "Gildenbank hinzufügen"
L["Include known recipes"] = "Bekannte Rezepte hinzufügen"

-- ** Frame 3 : Mail **
L["Warn when mail expires in less days than this value"] = "Warnen, wenn Post abläuft in weniger Tagen als"
L["Mail Expiry Warning"] = "Mail Ablauf Warnung"
L["Scan mail body (marks it as read)"] = "Inhalt der Briefe scannen (markiert als gelesen)"
L["New mail notification"] = true
L["Be informed when a guildmate sends a mail to one of my alts.\n\nMail content is directly visible without having to reconnect the character"] = true

-- ** Frame 4 : Minimap **
L["Move to change the angle of the minimap icon"] = "Bewegen um den Winkel an der Minimap zu ändern"
L["Minimap Icon Angle"] = "Minimap Icon Winkel"
L["Move to change the radius of the minimap icon"] = "Bewegen um den Radius an der Minimap zu ändern"
L["Minimap Icon Radius"] = "Minimap Icon Radius"
L["Show Minimap Icon"] = "Minimap Icon zeigen"

-- ** Frame 5 : Tooltip **
L["Show item source"] = "Item Quelle anzeigen"
L["Show item count per character"] = "Anzahl der Items pro Charakter anzeigen"
L["Show total item count"] = "Anzahl der Gesamtzahl der Items anzeigen"
L["Show guild bank count"] = "Gildenbank miteinbeziehen"
L["Show already known/learnable by"] = "Bereits bekannt/Erlernbar durch miteinbeziehen"
L["Show item ID and item level"] = true
L["Show counters on gathering nodes"] = true
L["Show counters for both factions"] = true
L["Show counters for all accounts"] = true
L["Include guild bank count in the total count"] = true

-- ** Frame 6 : Calendar **
L["Week starts on Monday"] = true
L["Warn %d minutes before an event starts"] = true
