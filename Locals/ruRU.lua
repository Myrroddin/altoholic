-- 
-- Russian localization made by Hellbot & Interim @ EU Realms 
-- Перевод выполнен Хэлла и Интерим @ Азурегос 
--

local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "ruRU" )

if not L then return end

--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="ignore", escape-non-ascii=false, same-key-is-true=true)@

if GetLocale() == "ruRU" then
-- Altoholic.xml local
LEFT_HINT = "Щелкните левой кнопкой мыши чтобы |cFF00FF00открыть";
RIGHT_HINT = "Щелкните правой кнопкой мыши чтобы  |cFF00FF00перетащить";

XML_ALTO_SHARING_HINT1 = "Enter an account name that will be\nused for |cFF00FF00display|r purposes only.\n"
				.. "This name can be anything you like,\nit does |cFF00FF00NOT|r have to be the real account name.\n\n"
XML_ALTO_SHARING_HINT2 = "This field |cFF00FF00cannot|r be left empty."

XML_ALTO_TAB1 = "Сводная информация"
XML_ALTO_TAB2 = "Персонажи"
XML_ALTO_TAB3 = "Поиск"
-- XML_ALTO_TAB4 = GUILD_BANK
XML_ALTO_TABOPTIONS = "Настройки"

XML_ALTO_SUMMARY_MENU1 = "Отчет"
XML_ALTO_SUMMARY_MENU2 = "Сумки"
-- XML_ALTO_SUMMARY_MENU3 = SKILLS
XML_ALTO_SUMMARY_MENU4 = "Activity"
XML_ALTO_SUMMARY_MENU5 = "Guild Members"
XML_ALTO_SUMMARY_MENU6 = "Guild Skills"
XML_ALTO_SUMMARY_MENU7 = "Guild Bank Tabs"
XML_ALTO_SUMMARY_MENU8 = "Calendar"

XML_ALTO_SUMMARY_TEXT1 = "Account Sharing Request"
XML_ALTO_SUMMARY_TEXT2 = "Click this button to ask a player\n"
				.. "to share his entire Altoholic Database\n"
				.. "and add it to your own"
XML_ALTO_SUMMARY_TEXT3 = "Both parties must enable account sharing\nbefore using this feature (see options)"
XML_ALTO_SUMMARY_TEXT4 = "Account Sharing"

XML_ALTO_CHAR_DD1 = "Игровой мир"
XML_ALTO_CHAR_DD2 = "Персонаж"
XML_ALTO_CHAR_DD3 = "Просмотр"

XML_ALTO_SEARCH_COL1 = "Предметы / Нахождение"

XML_ALTO_GUILD_TEXT1 = "Hide this guild in the tooltip"

XML_ALTO_ACH_NOTSTARTED = "Not started"
XML_ALTO_ACH_STARTED = "Started"

XML_ALTO_OPT_MENU1 = "Общее"
XML_ALTO_OPT_MENU2 = "Поиск"
XML_ALTO_OPT_MENU3 = "Почта"
XML_ALTO_OPT_MENU4 = "Мини-карта"
XML_ALTO_OPT_MENU5 = "Подсказка"

XML_TEXT_1 = "Всего";
XML_TEXT_2 = "Поиск по сумкам";
XML_TEXT_3 = "Параметры уровня";
XML_TEXT_4 = "Качество";
XML_TEXT_5 = "Ячейка снаряжения";
XML_TEXT_6 = "Сброс";
XML_TEXT_7 = "Поиск";

XML_ALTO_TEXT10 = "Account Name"
XML_ALTO_TEXT11 = "Send account sharing request to:"

--Options.xml
XML_ALTO_OPT_GENERAL1 = "Максимальную бодрость показывать как 150%";
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
XML_ALTO_OPT_GENERAL10 = "Transparency"

XML_ALTO_OPT_SEARCH1 = "Запрашивать информацию о предмете у сервера |cFFFF0000(риск отключения от сервера)";
XML_ALTO_OPT_SEARCH2 = "|cFFFFFFFFЕсли предмет не найден в локальном кэше клиента, но обнаружен во время поиска,\n"
			  .. "Altoholic попытается запросить информацию о предмете у сервера (не более 5 за раз).\n\n"
			  .. "Это значительно улучшает эффективность работы, поскольку больше количество предметов\n"
			  .. "будет включено в кэш клиента. Однако существует риск отключения от сервера, если запрощеный\n"
			  .. "предмет является добычей из инстанса слишком высогого уровня, недоступного этому серверу.\n\n"
			  .. "|cFF00FF00Не включайте|r если не хотите рисковать.";
XML_ALTO_OPT_SEARCH3 = "Сортировать предметы в порядке убывания";
XML_ALTO_OPT_SEARCH4 = "Включая предметы без требований к уровню";
XML_ALTO_OPT_SEARCH5 = "Включая содержимое почтовых ящиков";
XML_ALTO_OPT_SEARCH6 = "Включая содержимое банков гильдии";
XML_ALTO_OPT_SEARCH7 = "Включая изученные рецепты";

XML_ALTO_OPT_MAIL1 = "Предупреждать об истечении срока хранения почты за указаное время";
XML_ALTO_OPT_MAIL2 = "Сообщать об истечении срока хранения почты";
XML_ALTO_OPT_MAIL3 = "Просматривать почту (отмечает как прочитаную)";
XML_ALTO_OPT_MAIL4 = "New mail notification";
XML_ALTO_OPT_MAIL5 = "Be informed when a guildmate sends a mail to one of my alts.\n\n"
				.. "Mail content is directly visible without having to reconnect the character";


XML_ALTO_OPT_MINIMAP1 = "Изменяет местположение иконки относительно мини-карты";
XML_ALTO_OPT_MINIMAP2 = "Расположение иконки на мини-карте";
XML_ALTO_OPT_MINIMAP3 = "Изменяет отступ иконки от мини-карты";
XML_ALTO_OPT_MINIMAP4 = "Отступ иконки от мини-карты";
XML_ALTO_OPT_MINIMAP5 = "Показывать иконку на мини-карте";

XML_ALTO_OPT_TOOLTIP1 = "Указывать источник происхождения предмета";
XML_ALTO_OPT_TOOLTIP2 = "Показывать количество предметов у каждого персонажа";
XML_ALTO_OPT_TOOLTIP3 = "Показывать общее количество предметов";
XML_ALTO_OPT_TOOLTIP4 = "Включая количество предметов в банке гильдии";
XML_ALTO_OPT_TOOLTIP5 = "Включая изученные / доступные для изучения рецепты";
XML_ALTO_OPT_TOOLTIP6 = "Show item ID and item Level";
XML_ALTO_OPT_TOOLTIP7 = "Show counters on gathering nodes";
XML_ALTO_OPT_TOOLTIP8 = "Show counters for both factions";
XML_ALTO_OPT_TOOLTIP9 = "Show counters for all accounts";
XML_ALTO_OPT_TOOLTIP10 = "Include guild bank count in the total count";

XML_ALTO_OPT_CALENDAR1 = "Week starts on Monday"; 
XML_ALTO_OPT_CALENDAR2 = "Warn %d minutes before an event starts"; 
end
