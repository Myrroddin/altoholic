local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BF = LibStub("LibBabble-Faction-3.0"):GetLookupTable()

if GetLocale() ~= "ruRU" then return end

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"

-- This table contains a list of suggestions to get to the next level of reputation, craft or skill
Altoholic.Suggestions = {
	[L["Riding"]] = {
		{ 75, "Ученик в деле верховой езды (30 урв): |cFFFFFFFF35g\n|cFFFFD700Стандартные верховые животные/nобучаются в столицах: |cFFFFFFFF10з" },
		{ 150, "Подмастерьем в деле верховой езды (60 урв): |cFFFFFFFF600g\n|cFFFFD700Эпические верховые животные/nобучаются в столицах: |cFFFFFFFF100з" },
		{ 225, "Умельцем в деле верховой езды (70 урв): |cFFFFFFFF800g\n|cFFFFD700Летающие верховые животные в Долине Призрачной Луны: |cFFFFFFFF100з" },
		{ 300, "Профессионалом в деле верховой езды (70 урв): |cFFFFFFFF5000g\n|cFFFFD700Эпические летающие верховые животные в Долине Призрачной Луны: |cFFFFFFFF200з" }
	},
	
	-- source : http://forums.worldofwarcraft.com/thread.html?topicId=102789457&sid=1
	-- ** Primary professions **
	[BI["Tailoring"]] = {
		{ 50, "До 50: Рулон льняной ткани" },
		{ 70, "До 70: Льняная сумка" },
		{ 75, "До 75: Усиленная льняная накидка" },
		{ 105, "До 105: Рулон шерсти" },
		{ 110, "До 110: Серая шерстяная рубашка"},
		{ 125, "До 125: Шерстяные наплечники с двойным швом" },
		{ 145, "До 145: Рулон шелка" },
		{ 160, "До 160: Лазурный шелковый капюшон" },
		{ 170, "До 170: Шелковая головная повязка" },
		{ 175, "До 175: Церемониальная белая рубашка" },
		{ 185, "До 185: Рулон магической ткани" },
		{ 205, "До 205: Багровый шелковый жилет" },
		{ 215, "До 215: Багровые шелковые кюлоты" },
		{ 220, "До 220: Черные поножи из магической ткани\nили Черный жилет из магической ткани" },
		{ 230, "До 230: Черные перчатки из магической ткани" },
		{ 250, "До 250: Черная повязка из магической ткани\nили Черные наплечники из магической ткани" },
		{ 260, "До 260: Рулон рунической ткани" },
		{ 275, "До 275: Пояс из рунической ткани" },
		{ 280, "До 280: Сумка из рунической ткани" },
		{ 300, "До 300: Перчатки из рунической ткани" },
		{ 325, "До 325: Рулоны ткани Пустоты\n|cFFFFD700Не продовайте их, пожже они вам понадобятся" },
		{ 340, "До 340: Рулоны прочной ткани Пустоты\n|cFFFFD700Не продовайте их, пожже они вам понадобятся" },
		{ 350, "До 350: Сапоги из ткани Пустоты\n|cFFFFD700Распылите их на Чародейскую пыль" },
		{ 375, "До 375: Рулоны ледяной ткани" },
		{ 380, "До 380: Ледотканые сапоги" },
		{ 395, "До 395: Ледотканый шлем" },
		{ 405, "До 405: Клобук из сумеречной ткани" },
		{ 410, "До 410: Напульсники из сумеречной ткани" },
		{ 415, "До 415: Перчатки из сумеречной ткани" },
		{ 425, "До 425: Иссиня-черная ткань, Лунный тюль, или Чароткань\nСумка из ледяной ткани" },
		{ 450, "До 450: Зделайте любую вещь для получения очка,\nв зависимости от ваших потребностей" }
	},
	[BI["Leatherworking"]] = {
		{ 35, "До 35: Накладки из тонкой кожи" },
		{ 55, "До 55: Обработанная легкая шкура" },
		{ 85, "До 85: Тисненые кожаные перчатки" },
		{ 100, "До 100: Тонкий кожаный пояс" },
		{ 120, "До 120: Обработанная средняя шкура" },
		{ 125, "До 125: Тонкий кожаный пояс" },
		{ 150, "До 150: Темный кожаный пояс" },
		{ 160, "До 160: Обработанная тяжелая шкура" },
		{ 170, "До 170: Накладки из толстой кожи" },
		{ 180, "До 180: Мглистые кожаные поножи\nили Штаны стража" },
		{ 195, "До 195: Варварские наплечники" },
		{ 205, "До 205: Мглистые наручи" },
		{ 220, "До 220: Накладки из плотной кожи" },
		{ 225, "До 225: Ночная головная повязка" },
		{ 250, "До 250: Зависит от вашей специализации\nНочная головная повязка/мундир/штаны (сила стихий)\nЖесткая кираса из чешуи скорпида/перчатки (чешуя дракона)\nTКомплект из Черепашьего панциря (традиции предков)" },
		{ 260, "До 260: Ночные сапоги" },
		{ 270, "До 270: Гибельные кожаные рукавицы" },
		{ 285, "До 285: Гибельные кожаные наручи" },
		{ 300, "До 300: Гибельная кожаная головная повязка" },
		{ 310, "До 310: Узловатая кожа" },
		{ 320, "До 320: Перчатки дренейского дикаря" },
		{ 325, "До 325: Утолщенные дренейские сапоги" },
		{ 335, "До 335: Толстая узловатая кожа\n|cFFFFD700Не продовайте их, пожже они вам понадобятся" },
		{ 340, "До 340: Утолщенная дренейская безрукавка" },
		{ 350, "До 350: Скверночешуйчатая кираса" },
		{ 375, "До 375: Накладки из борейской кожи" },
		{ 385, "До 385: Арктические сапоги" },
		{ 395, "До 395: Арктический пояс" },
		{ 400, "До 400: Арктические накулачники" },
		{ 405, "До 405: Нерубские накладки для поножей" },
		{ 410, "До 410: Any Черный нагрудник или поножи" },
		{ 425, "До 425: Любую Меховую подкладку\nСумки для профессий" },
		{ 450, "До 450: Зделайте любую вещь для получения очка,\nв зависимости от ваших потребностей" }
	},
	[BI["Engineering"]] = {
		{ 40, "До 40: Rough Blasting Powder" },
		{ 50, "До 50: Handful of Copper Bolt" },
		{ 51, "Craft one Arclight Spanner" },
		{ 65, "До 65: Copper Tubes" },
		{ 75, "До 75: Rough Boom Sticks" },
		{ 95, "До 95: Coarse Blasting Powder" },
		{ 105, "До 105: Silver Contacts" },
		{ 120, "До 120: Bronze Tubes" },
		{ 125, "До 125: Small Bronze Bombs" },
		{ 145, "До 145: Heavy Blasting Powder" },
		{ 150, "До 150: Big Bronze Bombs" },
		{ 175, "До 175: Blue, Green or Red Fireworks" },
		{ 176, "Craft one Gyromatic Micro-Adjustor" },
		{ 190, "До 190: Solid Blasting Powder" },
		{ 195, "До 195: Big Iron Bomb" },
		{ 205, "До 205: Mithril Tubes" },
		{ 210, "До 210: Unstable Triggers" },
		{ 225, "До 225: Hi-Impact Mithril Slugs" },
		{ 235, "До 235: Mithril Casings" },
		{ 245, "До 245: Hi-Explosive Bomb" },
		{ 250, "До 250: Mithril Gyro-Shot" },
		{ 260, "До 260: Dense Blasting Powder" },
		{ 290, "До 290: Thorium Widget" },
		{ 300, "До 300: Thorium Tubes\nor Thorium Shells (cheaper)" },
		{ 310, "До 310: Fel Iron Casing,\nHandful of Fel Iron Bolts,\n and Elemental Blasting Powder\nKeep them all for future crafts" },
		{ 320, "До 320: Fel Iron Bomb" },
		{ 335, "До 335: Fel Iron Musket" },
		{ 350, "До 350: White Smoke Flare" },
		{ 375, "До 375: Cobalt Frag Bomb" },
		{ 430, "До 430: Mana & Healing Injector Kit\nYou'll need them on the long run" },
		{ 435, "До 435: Mana Injector Kit" },
		{ 450, "До 450: Whatever makes you earn a point,\ndepending on your needs" }
	},
	[BI["Jewelcrafting"]] = {
		{ 20, "До 20: Delicate Copper Wire" },
		{ 30, "До 30: Rough Stone Statue" },
		{ 50, "До 50: Tigerseye Band" },
		{ 75, "До 75: Bronze Setting" },
		{ 80, "До 80: Solid Bronze Ring" },
		{ 90, "До 90: Elegant Silver Ring" },
		{ 110, "До 110: Ring of Silver Might" },
		{ 120, "До 120: Heavy Stone Statue" },
		{ 150, "До 150: Pendant of the Agate Shield\nor Golden Dragon Ring" },
		{ 180, "До 180: Mithril Filigree" },
		{ 200, "До 200: Engraved Truesilver Ring" },
		{ 210, "До 210: Citrine Ring of Rapid Healing" },
		{ 225, "До 225: Aquamarine Signet" },
		{ 250, "До 250: Thorium Setting" },
		{ 255, "До 255: Red Ring of Destruction" },
		{ 265, "До 265: Truesilver Healing Ring" },
		{ 275, "До 275: Simple Opal Ring" },
		{ 285, "До 285: Sapphire Signet" },
		{ 290, "До 290: Diamond Focus Ring" },
		{ 300, "До 300: Emerald Lion Ring" },
		{ 310, "До 310: Any green quality gem" },
		{ 315, "До 315: Fel Iron Blood Ring\nor any green quality gem" },
		{ 320, "До 320: Any green quality gem" },
		{ 325, "До 325: Azure Moonstone Ring" },
		{ 335, "До 335: Mercurial Adamantite (required later)\nor any green quality gem" },
		{ 350, "До 350: Heavy Adamantite Ring" },
		{ 355, "До 355: Any blue quality gem" },
		{ 360, "До 360: World drop recipes like:\nLiving Ruby Pendant\nor Thick Felsteel Necklace" },
		{ 365, "До 365: Ring of Arcane Shielding\nThe Sha'tar - Уважение" },
		{ 375, "До 375: Transmute diamonds\nWorld drops (blue quality)\nПочтение с Sha'tar, Honor Hold, Thrallmar" }
	},
	[BI["Enchanting"]] = {
		{ 2, "До 2: Runed Copper Rod" },
		{ 75, "До 75: Enchant Bracer - Minor Health" },
		{ 85, "До 85: Enchant Bracer - Minor Deflection" },
		{ 100, "До 100: Enchant Bracer - Minor Stamina" },
		{ 101, "Craft one Runed Silver Rod" },
		{ 105, "До 105: Enchant Bracer - Minor Stamina" },
		{ 120, "До 120: Greater Magic Wand" },
		{ 130, "До 130: Enchant Shield - Minor Stamina" },
		{ 150, "До 150: Enchant Bracer - Lesser Stamina" },
		{ 151, "Craft one Runed Golden Rod" },
		{ 160, "До 160: Enchant Bracer - Lesser Stamina" },
		{ 165, "До 165: Enchant Shield - Lesser Stamina" },
		{ 180, "До 180: Enchant Bracer - Spirit" },
		{ 200, "До 200: Enchant Bracer - Strength" },
		{ 201, "Craft one Runed Truesilver Rod" },
		{ 205, "До 205: Enchant Bracer - Strength" },
		{ 225, "До 225: Enchant Cloak - Greater Defense" },
		{ 235, "До 235: Enchant Gloves - Agility" },
		{ 245, "До 245: Enchant Chest - Superior Health" },
		{ 250, "До 250: Enchant Bracer - Greater Strength" },
		{ 270, "До 270: Lesser Mana Oil\nRecipe is sold in Silithus" },
		{ 290, "До 290: Enchant Shield - Greater Stamina\nor Enchant Boots: Greater Stamina" },
		{ 291, "Craft one Runed Arcanite Rod" },
		{ 300, "До 300: Enchant Cloak - Superior Defense" },
		{ 301, "Craft one Runed Fel Iron Rod" },
		{ 305, "До 305: Enchant Cloak - Superior Defense" },
		{ 315, "До 315: Enchant Bracers - Assault" },
		{ 325, "До 325: Enchant Cloak - Major Armor\nor Enchant Gloves - Assault" },
		{ 335, "До 335: Enchant Chest - Major Spirit" },
		{ 340, "До 340: Enchant Shield - Major Stamina" },
		{ 345, "До 345: Superior Wizard Oil\nDo this up to 350 if you have the mats" },
		{ 350, "До 350: Enchant Gloves - Major Strength" },
		{ 351, "Craft one Runed Adamantite Rod" },
		{ 360, "До 360: Enchant Gloves - Major Strength" },
		{ 370, "До 370: Enchant Gloves - Spell Strike\nТребуется Почтение с Cenarion Expedition" },
		{ 375, "До 375: Enchant Ring - Healing Power\nТребуется Почтение with The Sha'tar" }
	},
	[BI["Blacksmithing"]] = {	
		{ 25, "До 25: Rough Sharpening Stones" },
		{ 45, "До 45: Rough Grinding Stones" },
		{ 75, "До 75: Copper Chain Belt" },
		{ 80, "До 80: Coarse Grinding Stones" },
		{ 100, "До 100: Runed Copper Belt" },
		{ 105, "До 105: Silver Rod" },
		{ 125, "До 125: Rough Bronze Leggings" },
		{ 150, "До 150: Heavy Grinding Stone" },
		{ 155, "До 155: Golden Rod" },
		{ 165, "До 165: Green Iron Leggings" },
		{ 185, "До 185: Green Iron Bracers" },
		{ 200, "До 200: Golden Scale Bracers" },
		{ 210, "До 210: Solid Grinding Stone" },
		{ 215, "До 215: Golden Scale Bracers" },
		{ 235, "До 235: Steel Plate Helm\nor Mithril Scale Bracers (cheaper)\nRecipe in Aerie Peak (A) or Stonard (H)" },
		{ 250, "До 250: Mithril Coif\nor Mothril Spurs (cheaper)" },
		{ 260, "До 260: Dense Sharpening Stones" },
		{ 270, "До 270: Thorium Belt or Bracers (cheaper)\nEarthforged Leggings (Armorsmith)\nLight Earthforged Blade (Swordsmith)\nLight Emberforged Hammer (Hammersmith)\nLight Skyforged Axe (Axesmith)" },
		{ 295, "До 295: Imperial Plate Bracers" },
		{ 300, "До 300: Imperial Plate Boots" },
		{ 305, "До 305: Fel Weightstone" },
		{ 320, "До 320: Fel Iron Plate Belt" },
		{ 325, "До 325: Fel Iron Plate Boots" },
		{ 330, "До 330: Lesser Rune of Warding" },
		{ 335, "До 335: Fel Iron Breastplate" },
		{ 340, "До 340: Adamantite Cleaver\nSold in Shattrah, Silvermoon, Exodar" },
		{ 345, "До 345: Lesser Rune of Shielding\nSold in Wildhammer Stronghold and Thrallmar" },
		{ 350, "До 350: Adamantite Cleaver" },
		{ 360, "До 360: Adamantite Weightstone\nRequires Cenarion Expedition - Уважение" },
		{ 370, "До 370: Felsteel Gloves (Auchenai Crypts)\nFlamebane Gloves (Aldor - Уважение)\nEnchanted Adamantite Belt (Scryer - Дружелюбие)" },
		{ 375, "До 375: Felsteel Gloves (Auchenai Crypts)\nFlamebane Breastplate (Aldor - Почтение)\nEnchanted Adamantite Belt (Scryer - Дружелюбие)" },
		{ 385, "До 385: Cobalt Gauntlets" },
		{ 393, "До 393: Spiked Cobalt Shoulders\nor Chestpiece" },
		{ 395, "До 395: Spiked Cobalt Gauntlets" },
		{ 400, "До 400: Spiked Cobalt Belt" },
		{ 410, "До 410: Spiked Cobalt Bracers" },
	},
	[BI["Alchemy"]] = {	
		{ 60, "До 60: Minor Healing Potion" },
		{ 110, "До 110: Lesser Healing Potion" },
		{ 140, "До 140: Healing Potion" },
		{ 155, "До 155: Lesser Mana Potion" },
		{ 185, "До 185: Greater Healing Potion" },
		{ 210, "До 210: Elixir of Agility" },
		{ 215, "До 215: Elixir of Greater Defense" },
		{ 230, "До 230: Superior Healing Potion" },
		{ 250, "До 250: Elixir of Detect Undead" },
		{ 265, "До 265: Elixir of Greater Agility" },
		{ 285, "До 285: Superior Mana Potion" },
		{ 300, "До 300: Major Healing Potion" },
		{ 315, "До 315: Volatile Healing Potion\nor Major Mana Potion" },
		{ 350, "До 350: Mad Alchemists's Potion\nTurns yellow at 335, but cheap to make" },
		{ 375, "До 375: Major Dreamless Sleep Potion\nSold in Allerian Stronghold (A)\nor Thunderlord Stronghold (H)" }
	},
	[L["Mining"]] = {
		{ 65, "До 65: Mine Copper\nAvailable in all starting zones" },
		{ 125, "До 125: Mine Tin, Silver, Incendicite and Lesser Bloodstone\n\nMine Incendicite at Thelgen Rock (Wetlands)\nEasy leveling up to 125" },
		{ 175, "До 175: Mine Iron and Gold\nDesolace, Ashenvale, Badlands, Arathi Highlands,\nAlterac Mountains, Stranglethorn Vale, Swamp of Sorrows" },
		{ 250, "До 250: Mine Mithril and Truesilver\nBlasted Lands, Searing Gorge, Badlands, The Hinterlands,\nWestern Plaguelands, Azshara, Winterspring, Felwood, Stonetalon Mountains, Tanaris" },
		{ 300, "До 300: Mine Thorium \nUn’goro Crater, Azshara, Winterspring, Blasted Lands\nSearing Gorge, Burning Steppes, Eastern Plaguelands, Western Plaguelands" },
		{ 330, "До 330: Mine Fel Iron\nHellfire Peninsula, Zangarmarsh" },
		{ 375, "До 375: Mine Fel Iron and Adamantite\nTerrokar Forest, Nagrand\nBasically everywhere in Outland" }
	},
	[L["Herbalism"]] = {
		{ 50, "До 50: Collect Silverleaf and Peacebloom\nAvailable in all starting zones" },
		{ 70, "До 70: Collect Mageroyal and Earthroot\nThe Barrens, Westfall, Silverpine Forest, Loch Modan" },
		{ 100, "До 100: Collect Briarthorn\nSilverpine Forest, Duskwood, Darkshore,\nLoch Modan, Redridge Mountains" },
		{ 115, "До 115: Collect Bruiseweed\nAshenvale, Stonetalon Mountains, Southern Barrens\nLoch Modan, Redridge Mountains" },
		{ 125, "До 125: Collect Wild Steelbloom\nStonetalon Mountains, Arathi Highlands, Stranglethorn Vale\nSouthern Barrens, Thousand Needles" },
		{ 160, "До 160: Collect Kingsblood\nAshenvale, Stonetalon Mountains, Wetlands,\nHillsbrad Foothills, Swamp of Sorrows" },
		{ 185, "До 185: Collect Fadeleaf\nSwamp of Sorrows" },
		{ 205, "До 205: Collect Khadgar's Whisker\nThe Hinterlands, Arathi Highlands, Swamp of Sorrows" },
		{ 230, "До 230: Collect Firebloom\nSearing Gorge, Blasted Lands, Tanaris" },
		{ 250, "До 250: Collect Sungrass\nFelwood, Feralas, Azshara\nThe Hinterlands" },
		{ 270, "До 270: Collect Gromsblood\nFelwood, Blasted Lands,\nMannoroc Coven in Desolace" },
		{ 285, "До 285: Collect Dreamfoil\nUn'goro Crater, Azshara" },
		{ 300, "До 300: Collect Plagueblooms\nEastern & Western Plaguelands, Felwood\nor Icecaps in Winterspring" },
		{ 330, "До 330: Collect Felweed\nHellfire Peninsula, Zangarmarsh" },
		{ 375, "До 375: Any flower available in Outland\nFocus on Zangarmarsh & Terrokar Forest" }
	},
	[L["Skinning"]] = {
		{ 375, "До 375: Разделите ваш текущий уровень 5,\nи снемайте шкуру с животных полученного уровня" }
	},

	-- source: http://www.elsprofessions.com/inscription/leveling.html
	[L["Inscription"]] = {
		{ 18, "До 18: Ivory Ink" },
		{ 35, "До 35: Scroll of Intellect, Spirit or Stamina" },
		{ 50, "До 50: Moonglow Ink\nSave if for Minor Inscription Research" },
		{ 75, "До 75: Scroll of Recall, Armor Vellum" },
		{ 79, "До 79: Midnight Ink" },
		{ 80, "До 80: Minor Inscription Research" },
		{ 85, "До 85: Glyph of Backstab, Frost Nova\nRejuvenation, ..." },
		{ 87, "До 87: Hunter's Ink" },
		{ 90, "До 90: Glyph of Corruption, Flame Shock\nRapid Charge, Wrath" },
		{ 100, "До 100: Glyph of Ice Armor, Maul\nSerpent Sting" },
		{ 104, "До 104: Lion's Ink" },
		{ 105, "До 105: Glyph of Arcane Shot, Arcane Explosion" },
		{ 110, "До 110: Glyph of Eviscerate, Holy Light, Fade" },
		{ 115, "До 115: Glyph of Fire Nova Totem\nHealth Funel, Rending" },
		{ 120, "До 120: Glyph of Arcane Missiles, Healing Touch" },
		{ 125, "До 125: Glyph of Expose Armor\nFlash Heal, Judgment" },
		{ 130, "До 130: Dawnstar Ink" },
		{ 135, "До 135: Glyph of Blink\nImmolation, Moonfire" },
		{ 140, "До 140: Glyph of Lay on Hands\nGarrote, Inner Fire" },
		{ 142, "До 142: Glyph of Sunder Armor\nImp, Lightning Bolt" },
		{ 150, "До 150: Strange Tarot" },
		{ 155, "До 155: Jadefire Ink" },
		{ 160, "До 160: Scroll of Stamina III" },
		{ 165, "До 165: Glyph of Gouge, Renew" },
		{ 170, "До 170: Glyph of Shadow Bolt\nStrength of Earth Totem" },
		{ 175, "До 175: Glyph of Overpower" },
		{ 177, "До 177: Royal Ink" },
		{ 183, "До 183: Scroll of Agility III" },
		{ 185, "До 185: Glyph of Cleansing\nShadow Word: Pain" },
		{ 190, "До 190: Glyph of Insect Swarm\nFrost Shock, Sap" },
		{ 192, "До 192: Glyph of Revenge\nVoidwalker" },
		{ 200, "До 200: Arcane Tarot" },
		{ 204, "До 204: Celestial Ink" },
		{ 210, "До 210: Armor Vellum II" },
		{ 215, "До 215: Glyph of Smite, Sinister Strike" },
		{ 220, "До 220: Glyph of Searing Pain\nHealing Stream Totem" },
		{ 225, "До 225: Glyph of Starfire\nBarbaric Insults" },
		{ 227, "До 227: Fiery Ink" },
		{ 230, "До 230: Scroll of Agility IV" },
		{ 235, "До 235: Glyph of Dispel Magic" },
		{ 250, "До 250: Weapon Vellum II" },
		{ 255, "До 255: Scroll of Stamina V" },
		{ 260, "До 260: Scroll of Spirit V" },
		{ 265, "До 265: Glyph of Freezing Trap, Shred" },
		{ 270, "До 270: Glyph of Exorcism, Bone Shield" },
		{ 275, "До 275: Glyph of Fear Ward, Frost Strike" },
		{ 285, "До 285: Ink of the Sky" },
		{ 295, "До 295: Glyph of Execution\nSprint, Death Grip" },
		{ 300, "До 300: Scroll of Spirit VI" },
		{ 304, "До 304: Ethereal Ink" },
		{ 305, "До 305: Glyph of Plague Strike\nEarthliving Weapon, Flash of Light" },
		{ 310, "До 310: Glyph of Feint" },
		{ 315, "До 315: Glyph of Rake, Rune Tap" },
		{ 320, "До 320: Glyph of Holy Nova, Rapid Fire" },
		{ 325, "До 325: Glyph of Blood Strike, Sweeping Strikes" },
		{ 327, "До 327: Darkflame Ink" },
		{ 330, "До 330: Glyph of Mage Armor, Succubus" },
		{ 335, "До 335: Glyph of Scourge Strike, Windfury Weapon" },
		{ 340, "До 340: Glyph of Arcane Power, Seal of Command" },
		{ 345, "До 345: Glyph of Ambush, Death Strike" },
		{ 350, "До 350: Glyph of Whirlwind" },
		{ 350, "До 350: Glyph of Mind Flay, Banish" },
		
		{ 450, "До 450: Not yet implemented" }
	},

	-- source: http://www.almostgaming.com/wowguides/world-of-warcraft-lockpicking-guide
	[L["Lockpicking"]] = {
		{ 85, "До 85: Thieves Training\nAtler Mill, Redridge Moutains (A)\nShip near Ratchet (H)" },
		{ 150, "До 150: Chest near the boss of the poison quest\nWestfall (A) or The Barrens (H)" },
		{ 185, "До 185: Murloc camps (Wetlands)" },
		{ 225, "До 225: Sar'Theris Strand (Desolace)\n" },
		{ 250, "До 250: Angor Fortress (Badlands)" },
		{ 275, "До 275: Slag Pit (Searing Gorge)" },
		{ 300, "До 300: Lost Rigger Cove (Tanaris)\nBay of Storms (Azshara)" },
		{ 325, "До 325: Feralfen Village (Zangarmarsh)" },
		{ 350, "До 350: Kil'sorrow Fortress (Nagrand)\nPickpocket the Boulderfists in Nagrand" }
	},
	
	-- ** Secondary professions **
	[BI["First Aid"]] = {
		{ 40, "До 40: Linen Bandages" },
		{ 80, "До 80: Heavy Linen Bandages\nBecome Journeyman at 50" },
		{ 115, "До 115: Wool Bandages" },
		{ 150, "До 150: Heavy Wool Bandages\nGet Expert First Aid book at 125\nBuy the 2 manuals in Stromguarde (A) or Brackenwall Village (H)" },
		{ 180, "До 180: Silk Bandages" },
		{ 210, "До 210: Heavy Silk Bandages" },
		{ 240, "До 240: Mageweave Bandages\nFirst Aid quest at level 35\nTheramore Isle (A) or Hammerfall (H)" },
		{ 260, "До 260: Heavy Mageweave Bandages" },
		{ 290, "До 290: Runecloth Bandages" },
		{ 330, "До 330: Heavy Runecloth Bandages\nBuy Master First Aid book\nTemple of Telhamat (A) or Falcon Watch (H)" },
		{ 360, "До 360: Netherweave Bandages\nBuy the book in the Temple of Telhamat (A) or in Falcon Watch (H)" },
		{ 375, "До 375: Heavy Netherweave Bandages\nBuy the book in the Temple of Telhamat (A) or in Falcon Watch (H)" }
	},
	[BI["Cooking"]] = {
		{ 40, "До 40: Spice Bread"	},
		{ 85, "До 85: Smoked Bear Meat, Crab Cake" },
		{ 100, "До 100: Cooked Crab Claw (A)\nDig Rat Stew (H)" },
		{ 125, "До 125: Dig Rat Stew (H)\nSeasoned Wolf Kabob (A)" },
		{ 175, "До 175: Curiously Tasty Omelet (A)\nHot Lion Chops (H)" },
		{ 200, "До 200: Roast Raptor" },
		{ 225, "До 225: Spider Sausage\n\n|cFFFFFFFFCooking quest:\n|cFFFFD70012 Giant Eggs,\n10 Zesty Clam Meat,\n20 Alterac Swiss " },
		{ 275, "До 275: Monster Omelet\nor Tender Wolf Steaks" },
		{ 285, "До 285: Runn Tum Tuber Surprise\nDire Maul (Pusillin)" },
		{ 300, "До 300: Smoked Desert Dumplings\nQuest in Silithus" },
		{ 325, "До 325: Ravager Dogs, Buzzard Bites" },
		{ 350, "До 350: Roasted Clefthoof\nWarp Burger, Talbuk Steak" },
		{ 375, "До 375: Crunchy Serpent\nMok'nathal Treats" }
	},	
	-- source: http://www.wowguideonline.com/fishing.html
	[BI["Fishing"]] = {
		{ 50, "До 50: Any starting zone" },
		{ 75, "До 75:\nThe Canals in Stormwind\nThe Pond in Orgrimmar" },
		{ 150, "До 150: Hillsbrad Foothills' river" },
		{ 225, "До 225: Expert Fishing book sold in Booty Bay\nFish in Desolace or Arathi Highlands" },
		{ 250, "До 250: Hinterlands, Tanaris\n\n|cFFFFFFFFFishing quest in Dustwallow Marsh\n|cFFFFD700Savage Coast Blue Sailfin (Stranglethorn Vale)\nFeralas Ahi (Verdantis River, Feralas)\nSer'theris Striker (Northern Sartheris Strand, Desolace)\nMisty Reed Mahi Mahi (Swamp of Sorrows coastline)" },
		{ 260, "До 260: Felwood" },
		{ 300, "До 300: Azshara" },
		{ 330, "До 330: Fish in Eastern Zangarmarsh\nArtisan Fishing Book at the Cenarion Expedition" },
		{ 345, "До 345: Western Zangarmarsh" },
		{ 360, "До 360: Terrokar Forest" },
		{ 375, "До 375: Terrokar Forest, in altitude\nFlying mount required" }
	},
	
	-- suggested leveling zones, compiled by Thaoky, based on too many sources to list + my own leveling experience on Alliance side
	["Leveling"] = {
		{ 10, "До 10: Any starting zone" },
		{ 20, "До 20: "  .. BZ["Loch Modan"] .. "\n" .. BZ["Westfall"] .. "\n" .. BZ["Darkshore"] .. "\n" .. BZ["Bloodmyst Isle"] 
						.. "\n" .. BZ["Silverpine Forest"] .. "\n" .. BZ["The Barrens"] .. "\n" .. BZ["Ghostlands"]},
		{ 25, "До 25: " .. BZ["Wetlands"] .. "\n" .. BZ["Redridge Mountains"] .. "\n" .. BZ["Ashenvale"] 
						.. "\n" .. BZ["The Barrens"] .. "\n" .. BZ["Stonetalon Mountains"] .. "\n" .. BZ["Hillsbrad Foothills"] },
		{ 28, "До 28: " .. BZ["Duskwood"] .. "\n" .. BZ["Wetlands"] .. "\n" .. BZ["Ashenvale"] 
						.. "\n" .. BZ["Stonetalon Mountains"] .. "\n" .. BZ["Thousand Needles"] },
		{ 31, "До 31: " .. BZ["Duskwood"] .. "\n" .. BZ["Thousand Needles"] .. "\n" .. BZ["Ashenvale"] },
		{ 35, "До 35: " .. BZ["Thousand Needles"] .. "\n" .. BZ["Stranglethorn Vale"] .. "\n" .. BZ["Alterac Mountains"] 
						.. "\n" .. BZ["Arathi Highlands"] .. "\n" .. BZ["Desolace"] },
		{ 40, "До 40: " .. BZ["Stranglethorn Vale"] .. "\n" .. BZ["Desolace"] .. "\n" .. BZ["Badlands"]
						.. "\n" .. BZ["Dustwallow Marsh"] .. "\n" .. BZ["Swamp of Sorrows"] },
		{ 43, "До 43: " .. BZ["Tanaris"] .. "\n" .. BZ["Stranglethorn Vale"] .. "\n" .. BZ["Badlands"] 
						.. "\n" .. BZ["Dustwallow Marsh"] .. "\n" .. BZ["Swamp of Sorrows"] },
		{ 45, "До 45: " .. BZ["Tanaris"] .. "\n" .. BZ["Feralas"] .. "\n" .. BZ["The Hinterlands"] },
		{ 48, "До 48: " .. BZ["Tanaris"] .. "\n" .. BZ["Feralas"] .. "\n" .. BZ["The Hinterlands"] .. "\n" .. BZ["Searing Gorge"] },
		{ 51, "До 51: " .. BZ["Tanaris"] .. "\n" .. BZ["Azshara"] .. "\n" .. BZ["Blasted Lands"] 
						.. "\n" .. BZ["Searing Gorge"] .. "\n" .. BZ["Un'Goro Crater"] .. "\n" .. BZ["Felwood"] },
		{ 55, "До 55: " .. BZ["Un'Goro Crater"] .. "\n" .. BZ["Felwood"] .. "\n" .. BZ["Burning Steppes"]
						.. "\n" .. BZ["Blasted Lands"] .. "\n" .. BZ["Western Plaguelands"] },
		{ 58, "До 58: " .. BZ["Winterspring"] .. "\n" .. BZ["Burning Steppes"] .. "\n" .. BZ["Western Plaguelands"] 
						.. "\n" .. BZ["Eastern Plaguelands"] .. "\n" .. BZ["Silithus"] },
		{ 60, "До 60: " .. BZ["Winterspring"] .. "\n" .. BZ["Eastern Plaguelands"] .. "\n" .. BZ["Silithus"] },
		{ 62, "До 62: " .. BZ["Hellfire Peninsula"] },
		{ 64, "До 64: " .. BZ["Zangarmarsh"] .. "\n" .. BZ["Terokkar Forest"]},
		{ 65, "До 65: " .. BZ["Terokkar Forest"] },
		{ 66, "До 66: " .. BZ["Terokkar Forest"] .. "\n" .. BZ["Nagrand"]},
		{ 67, "До 67: " .. BZ["Nagrand"]},
		{ 68, "До 68: " .. BZ["Blade's Edge Mountains"]},
		{ 70, "До 70: " .. BZ["Blade's Edge Mountains"] .. "\n" .. BZ["Netherstorm"] .. "\n" .. BZ["Shadowmoon Valley"]},
		{ 72, "До 72: " .. BZ["Howling Fjord"] .. "\n" .. BZ["Borean Tundra"]},
		{ 74, "До 74: " .. BZ["Grizzly Hills"] .. "\n" .. BZ["Dragonblight"]},
		{ 76, "До 76: " .. BZ["Dragonblight"] .. "\n" .. BZ["Zul'Drak"]},
		{ 78, "До 78: " .. BZ["Zul'Drak"] .. "\n" .. BZ["Sholazar Basin"]},
		{ 80, "До 80: " .. BZ["The Storm Peaks"] .. "\n" .. BZ["Icecrown"]},
	},

	-- Reputation levels
	-- -42000 = "Hated"
	-- -6000 = "Hostile"
	-- -3000 = "Unfriendly"
	-- 0 = "Neutral"
	-- 3000 = "Friendly"
	-- 9000 = "Honored"
	-- 21000 = "Revered"
	-- 42000 = "Exalted"
	
	-- Outland factions: source: http://www.mmo-champion.com/
	[BF["The Aldor"]] = {
		{ 0, "До Равнодушия:\n" .. WHITE .. "[Dreadfang Venom Sac]|r +250 rep\n\n"
				.. YELLOW .. "Dreadfang Lurker,\nDreadfang Widow\n"
				.. WHITE .. "(Terrokar Forest)" },
		{ 9000, "До Уважения:\n" .. WHITE .. "[Mark of Kil'jaeden]|r\n+25 rep" },
		{ 42000, "До Превознесения:\n" .. WHITE .. "[Mark of Sargeras]|r +25 rep per mark\n" 
				.. GREEN .. "[Fel Armament]|r +350 rep (+1 Holy Dust)"       }
	},
	[BF["The Scryers"]] = {
		{ 0, "До Равнодушия:\n" .. WHITE .. "[Dampscale Basilisk Eye]|r +250 rep\n\n"
				.. YELLOW .. "Ironspine Petrifier,\nDampscale Devourer,\nDampscale Basilisk\n"
				.. WHITE .. "(Terrokar Forest)" },
		{ 9000, "До Уважения:\n" .. WHITE .. "[Firewing Signet]|r\n+25 rep" },
		{ 42000, "До Превознесения:\n" .. WHITE .. "[Sunfury Signet]|r +25 rep per mark\n" 
				.. GREEN .. "[Arcane Tome]|r +350 rep (+1 Arcane Rune)"       }
	},
	[BF["Netherwing"]] = {
		{ 3000, "До Дружелюбие, repeat these quests:\n\n" 
				.. YELLOW .. "A Slow Death (Daily)|r 250 rep\n"
				.. YELLOW.. "Netherdust Pollen (Daily)|r 250 rep\n"
				.. YELLOW.. "Netherwing crystal (Daily)|r 250 rep\n"
				.. YELLOW.. "Not so friendly skies (Daily)\n"
				.. YELLOW.. "Great Netherwing egg hunt (Repeatable)|r 250 rep" },
		{ 9000, "До Уважения, repeat these quests:\n\n" 
				.. YELLOW .. "Overseeing and you: making the right choices|r 350 rep\n"
				.. YELLOW .. "The Booterang: A Cure ... (Daily)|r 350 rep\n"
				.. YELLOW .. "Picking up the pieces (Daily)|r 350 rep\n"
				.. YELLOW .. "Dragons are the least of our problems (Daily)|r 350 rep\n"
				.. YELLOW .. "Crazed & confused|r 350 rep\n" },
		{ 21000, "До Почтения, repeat these quests:\n\n" 
				.. YELLOW .. "Subduing the Subduer|r 500 rep\n" 
				.. YELLOW .. "Disrupting the Twiligth Generator (Daily)|r 500 rep\n"
				.. YELLOW .. "Race quests 500 each for first 5, 1000 for 6th\n" },
		{ 42000, "До Превознесения, repeat this quest:\n\n" 
				.. YELLOW .. "The greatest trap ever (Daily) (3 man group)|r 500 rep" }
	},
	[BF["Honor Hold"]] = {
		{ 9000, "До Уважения:\n\n" 
				.. YELLOW .. "Quest in Hellfire Peninsula\n"
				.. GREEN .. "Hellfire Remparts |r(Normal)\n"
				.. GREEN .. "Blood Furnace |r(Normal)" },		
		{ 42000, "До Превознесения:\n\n" 
				.. GREEN .. "Shattered Halls |r(Normal & Heroic)\n"
				.. GREEN .. "Hellfire Remparts |r(Heroic)\n"
				.. GREEN .. "Blood Furnace |r(Heroic)" }
	},
	[BF["Thrallmar"]] = {
		{ 9000, "До Уважения:\n\n" 
				.. YELLOW .. "Quest in Hellfire Peninsula\n"
				.. GREEN .. "Hellfire Remparts |r(Normal)\n"
				.. GREEN .. "Blood Furnace |r(Normal)" },		
		{ 42000, "До Превознесения:\n\n" 
				.. GREEN .. "Shattered Halls |r(Normal & Heroic)\n"
				.. GREEN .. "Hellfire Remparts |r(Heroic)\n"
				.. GREEN .. "Blood Furnace |r(Heroic)" }
	},
	[BF["Cenarion Expedition"]] = {
		{ 3000, "До Дружелюбия:\n\n" 
				.. WHITE .. "Darkcrest & Bloodscale Nagas (+5 rep)\n"
				.. YELLOW .. "Quest in Zangarmarsh\n"
				.. "|rRun any " .. GREEN .. "Coilfang|r instance\n\n"
				.. WHITE .. "Keep [Unidentified Plant Parts] for later" },	
		{ 9000, "До Уважения:\n\n" 
				.. WHITE .. "Turn in [Unidentified Plant Parts] x240\n"
				.. YELLOW .. "Quest in Zangarmarsh\n"
				.. "|rRun any " .. GREEN .. "Coilfang|r instance" },
		{ 42000, "До Превознесения:\n\n" 
				.. WHITE .. "Turn in [Coilfang Armaments] +75 rep\n\n"
				.. GREEN .. "Steamvault |r(Normal)\n"
				.. GREEN .. "Any Coilfang instance |r(Heroic)" }
	},
	[BF["Keepers of Time"]] = {
		{ 42000, "До Превознесения:\n\n" 
				.. "|rRun the " .. GREEN .. "Old Hillsbrad Foothills|r & " .. GREEN .. "The Black Morass\n\n"
				.. YELLOW .. "Keep quests for later:\nOld Hillsbrad quesline = 5000 rep\nBlack Morass questline = 8000 rep" }
	},
	[BF["The Sha'tar"]] = {
		{ 42000, "До Превознесения:\n\n" 
				.. GREEN .. "The Botanica |r(Normal & Heroic)\n"
				.. GREEN .. "The Mechanar |r(Normal & Heroic)\n"
				.. GREEN .. "The Arcatraz |r(Normal & Heroic)\n" }
	},	
	[BF["Lower City"]] = {
		{ 9000, "До Уважения:\n\n" 
				.. WHITE .. "Turn in [Arrakoa Feather] x30 (+250 rep)\n"
				.. GREEN .. "Shadow Labyrinth |r(Normal)\n"
				.. GREEN .. "Auchenai Crypts |r(Normal)\n"
				.. GREEN .. "Sethekk Halls |r(Normal)" },
		{ 42000, "До Превознесения:\n\n" 
				.. GREEN .. "Shadow Labyrinth |r(Normal & Heroic)\n"
				.. GREEN .. "Auchenai Crypts |r(Heroic)\n"
				.. GREEN .. "Sethekk Halls |r(Heroic)" }
	},	
	[BF["The Consortium"]] = {
		{ 3000, "До Дружелюбия:\n\n" 
				.. "|rTurn in [Oshu'gun Crystal Fragment] +250 rep\n"
				.. "Turn in [Pair of Ivory Tusks] +250 rep\n\n"
				.. GREEN .. "Mana-Tombs |r(Normal)" },
		{ 9000, "До Уважения:\n\n" 
				.. "|rTurn in [Obsidian Warbeads] +250 rep\n\n"
				.. GREEN .. "Mana-Tombs |r(Normal)" },
		{ 42000, "До Превознесения:\n\n" 
				.. "|rTurn in [Zaxxis Insignia] +250 rep\n"
				.. "|rTurn in [Obsidian Warbeads] +250 rep\n\n"
				.. GREEN .. "Mana-Tombs |r(Heroic)" }
	}

	-- Northrend factions
}
