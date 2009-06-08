-- 
-- Russian localization made by Hellbot & Interim @ EU Realms 
-- Перевод выполнен Хэлла и Интерим @ Азурегос 
--

local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "ruRU" )

if not L then return end

--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="ignore", escape-non-ascii=false, same-key-is-true=true)@

L["Location"] = true
L["Left-click to |cFF00FF00open"] = "Щелкните левой кнопкой мыши чтобы |cFF00FF00открыть"
L["Right-click to |cFF00FF00drag"] = "Щелкните правой кнопкой мыши чтобы  |cFF00FF00перетащить"
L["Enter an account name that will be\nused for |cFF00FF00display|r purposes only."] = true
L["This name can be anything you like,\nit does |cFF00FF00NOT|r have to be the real account name."] = true
L["This field |cFF00FF00cannot|r be left empty."] = true

L["Summary"] = "Сводная информация"
L["Characters"] = "Персонажи"

L["Account Summary"] = "Отчет"
L["Bag Usage"] = "Сумки"
L["Activity"] = true
L["Guild Members"] = true
L["Guild Skills"] = true
L["Guild Bank Tabs"] = true
L["Calendar"] = true

L["Account Sharing Request"] = true
L["Click this button to ask a player\nto share his entire Altoholic Database\nand add it to your own"] = true
L["Both parties must enable account sharing\nbefore using this feature (see options)"] = true
L["Account Sharing"] = true

L["Realm"] = "Игровой мир"
L["Character"] = "Персонаж"
L["View"] = "Просмотр"

L["Item / Location"] = "Предметы / Нахождение"

L["Hide this guild in the tooltip"] = true

L["Not started"] = true
L["Started"] = true

L["General"] = "Общее"
L["Tooltip"] = "Подсказка"

L["Totals"] = "Всего"
L["Search Containers"] = "Поиск по сумкам"
L["Equipment Slot"] = "Ячейка снаряжения"
L["Reset"] = "Сброс"

L["Account Name"] = true
L["Send account sharing request to:"] = true

--TabOptions.lua

-- ** Frame 1 : General **
L["Max rest XP displayed as 150%"] = "Максимальную бодрость показывать как 150%"
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
L["AutoQuery server |cFFFF0000(disconnection risk)"] = "Запрашивать информацию о предмете у сервера |cFFFF0000(риск отключения от сервера)"
L["|cFFFFFFFFIf an item not in the local item cache\nis encountered while searching loot tables,\nAltoholic will attempt to query the server for 5 new items.\n\n"] = "|cFFFFFFFFЕсли предмет не найден в локальном кэше клиента, но обнаружен во время поиска,\nAltoholic попытается запросить информацию о предмете у сервера (не более 5 за раз).\n\n"
L["This will gradually improve the consistency of the searches,\nas more items are available in the item cache.\n\n"] = "Это значительно улучшает эффективность работы, поскольку больше количество предметов\nбудет включено в кэш клиента. Однако существует риск отключения от сервера, если запрощеный\n"
L["There is a risk of disconnection if the queried item\nis a loot from a high level dungeon.\n\n"] = "предмет является добычей из инстанса слишком высогого уровня, недоступного этому серверу.\n\n"
L["|cFF00FF00Disable|r to avoid this risk"] = "|cFF00FF00Не включайте|r если не хотите рисковать."

L["Sort loots in descending order"] = "Сортировать предметы в порядке убывания"
L["Include items without level requirement"] = "Включая предметы без требований к уровню"
L["Include mailboxes"] = "Включая содержимое почтовых ящиков"
L["Include guild bank(s)"] = "Включая содержимое банков гильдии"
L["Include known recipes"] = "Включая изученные рецепты"

-- ** Frame 3 : Mail **
L["Warn when mail expires in less days than this value"] = "Предупреждать об истечении срока хранения почты за указаное время"
L["Mail Expiry Warning"] = "Сообщать об истечении срока хранения почты"
L["Scan mail body (marks it as read)"] = "Просматривать почту (отмечает как прочитаную)"
L["New mail notification"] = true
L["Be informed when a guildmate sends a mail to one of my alts.\n\nMail content is directly visible without having to reconnect the character"] = true

-- ** Frame 4 : Minimap **
L["Move to change the angle of the minimap icon"] = "Изменяет местположение иконки относительно мини-карты"
L["Minimap Icon Angle"] = "Расположение иконки на мини-карте"
L["Move to change the radius of the minimap icon"] = "Изменяет отступ иконки от мини-карты"
L["Minimap Icon Radius"] = "Отступ иконки от мини-карты"
L["Show Minimap Icon"] = "Показывать иконку на мини-карте"

-- ** Frame 5 : Tooltip **
L["Show item source"] = "Указывать источник происхождения предмета"
L["Show item count per character"] = "Показывать количество предметов у каждого персонажа"
L["Show total item count"] = "Показывать общее количество предметов"
L["Show guild bank count"] = "Включая количество предметов в банке гильдии"
L["Show already known/learnable by"] = "Включая изученные / доступные для изучения рецепты"
L["Show item ID and item level"] = true
L["Show counters on gathering nodes"] = true
L["Show counters for both factions"] = true
L["Show counters for all accounts"] = true
L["Include guild bank count in the total count"] = true

-- ** Frame 6 : Calendar **
L["Week starts on Monday"] = true
L["Warn %d minutes before an event starts"] = true
