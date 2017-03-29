local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local TS = addon.TradeSkills.Names

if GetLocale() ~= "zhTW" then return end

local continents = { GetMapContinents() };		-- this gets localized names, also avoids hardcoding them.

-- 以下為聲望值、等級、技能等的建議
addon.Suggestions = {

	-- 來源 : http://forums.worldofwarcraft.com/thread.html?topicId=102789457&sid=1（英文）
	-- ** 主專業技能 **
	[TS.TAILORING] = {
		{ 50, "1-50: 亞麻布卷\n(2x亞麻布)x80" },
		{ 70, "51-70: 亞麻包\n(3x亞麻布卷/3x粗線)x20" },
		{ 75, "71-75: 強化亞麻斗篷\n(2x亞麻布卷/3x粗線)x5" },
		{ 105, "76-105: 毛布卷\n(3x毛料)x60" },
		{ 110, "106-110: 灰色毛紡襯衣\n(2x毛布卷/1x細線/1x灰色染料)x5"},
		{ 125, "111-125: 雙線毛紡護肩\n(3x毛布卷/2x細線)x15" },
		{ 145, "126-145: 絲綢卷\n(4x絲綢)x190" },
		{ 160, "146-160: 碧藍絲質頭巾\n(2x絲綢卷/2x藍色染料/1x細線)x15" },
		{ 170, "161-170: 絲質頭帶\n(3x絲綢卷/2x細線)x10" },
		{ 175, "171-175: 體面的白襯衣\n(3x絲綢卷/2x漂白液/1x細線)x5" },
		{ 185, "176-185: 魔紋布卷\n(5x魔紋布)x100" },
		{ 205, "186-205: 深紅絲質外衣\n(4x絲綢卷/2x紅色染料/2x細線)x15" },
		{ 215, "206-215: 深紅絲質馬褲\n(4x絲綢卷/2x紅色染料/2x絲線)x15" },
		{ 220, "216-220: 黑色魔紋短褲\n黑色魔紋外衣\n(2x魔紋布卷/3x絲線)x5" },
		{ 230, "221-230: 黑色魔紋手套\n(2x魔紋布卷/2x粗絲線)x10" },
		{ 250, "231-250: 黑色魔紋頭帶\n黑色魔紋護肩\n(3x魔紋布卷/2x粗絲線)x20" },
		{ 260, "251-260: 符文布卷\n(5x符文布)x180" },
		{ 275, "261-275: 符文布腰帶\n(3x符文布卷/1x符文線)x15" },
		{ 280, "276-280: 符文布背包\n(5x符文布卷/2x硬甲皮/1x符文線)x5" },
		{ 300, "281-300: 符文布手套\n(4x符文布卷/4x硬甲皮/1x符文線)x20" },
		{ 325, "301-325: 幽紋布卷\n(6x幽紋布)x25\n|cFFFFD700千萬別賣掉，你用來繼續升級的!" },
		{ 340, "326-340: 魔染幽紋布卷\n(3x幽紋布卷/2x魔塵)x15\n|cFFFFD700千萬別賣掉，你用來繼續升級的!" },
		{ 350, "341-350: 幽紋長靴\n(6x幽紋布卷/2x境外皮革/1x符文線)x10\n|cFFFFD700可分解為魔塵." },
		{ 360, "351-360: 幽紋外套\n(8x幽紋布卷/2x符文線)x10\n|cFFFFD700可分解為魔塵." },
		{ 375, "361-375: 魔染幽紋外套\n(6x魔染幽紋布卷/2x幽網蜘蛛絲/1x符文線)x15\n期間可以選擇分支並作專業套裝." }
	},
	[TS.LEATHERWORKING] = {
		{ 35, "1-35: 輕型護甲片\n(1x輕皮)x35" },
		{ 55, "36-55: 熟化輕毛皮\n(1x輕毛皮/1x鹽)x20" },
		{ 80, "56-80: 雕花皮靴\n(8x輕皮/5x粗線)x15" },
		{ 85, "81-85: 優質皮帶\n(6x輕皮/2x粗線)x5" },
		{ 90, "86-90: 優質皮外套\n(3x熟化輕毛皮/6x輕皮/4x粗線)x5" },
		{ 100, "91-100: 優質皮帶\n(6x輕皮/2x粗線)x10" },
		{ 120, "101-120: 熟化中毛皮\n(1x中毛皮/1x鹽)x20" },
		{ 125, "121-125: 優質皮帶\n(6x輕皮/2x粗線)x5" },
		{ 150, "126-150: 黑皮腰帶\n(1x優質皮帶/1x熟化中毛皮/2x細線/1x灰色染料)x25" },
		{ 160, "151-160: 熟化重毛皮\n(1x重毛皮/3x鹽)x10" },
		{ 170, "161-170: 重型護甲片\n(5x重皮/1x細線)x10" },
		{ 180, "171-180: 暗色皮護腿\n(10x重皮/1x黑色染料/2x細線)x10\n守護短褲\n(12x重皮/2x絲綢卷/2x細線)x10" },
		{ 195, "181-195: 野人護肩\n(8x重皮/1x熟化重毛皮/2x細線)x15" },
		{ 205, "196-205: 暗色護腕\n(16x重皮/1x黑色染料/2x絲線)x10" },
		{ 220, "206-220: 厚重護甲片\n(5x厚皮/1x絲線)x15" },
		{ 225, "221-225: 夜色頭帶\n(5x厚皮/2x絲線)x5" },
		{ 250, "226-250: 根據你的專精可以為:\n元素制皮:\n夜色頭帶\n(5x厚皮/2x絲線)x25\n夜色外套\n(7x厚皮/2x絲線)x25\n夜色短褲(14x厚皮/4x絲線)x20\n龍鱗制皮:\n硬化蠍殼胸甲(12x厚皮/12x蠍殼/4x絲線)x25\n硬化蠍殼手套(6x厚皮/8x蠍殼/2x絲線)x25\n部族制皮:\n龜殼頭盔(14x厚皮/24x龜殼/1x粗絲線)x20\n龜殼護腿(14x厚皮/28x龜殼/1x粗絲線)x15\n龜殼胸甲(6x厚皮/12x龜殼/1x粗絲線)x25\n龜殼手套(6x厚皮/8x龜殼/1x粗絲線)x25\n龜殼護腕(8x厚皮/12x龜殼/1x粗絲線)x25\n"},
		{ 260, "251-260: 夜色長靴\n(16x厚皮/2x粗絲線)x10" },
		{ 270, "261-270: 邪惡皮甲護手\n(8x硬甲皮/1x黑色染料/1x符文線)x10" },
		{ 285, "271-285: 邪惡皮甲護腕\n(8x硬甲皮/1x黑色染料/1x符文線)x10" },
		{ 300, "286-300: 邪惡皮甲頭環\n(12x硬甲皮/1x黑色染料/1x符文線)x15" },
		{ 310, "301-310: 境外皮革\n(5x境外皮革碎片)x10" },
		{ 320, "311-320: 野性德萊尼手套\n(9x境外皮革/3x符文線)x10" },
		{ 325, "3212-325: 厚重德萊尼長靴\n(10x境外皮革/3x符文線)x5" },
		{ 335, "326-335: 厚境外皮革\n(5x境外皮革)x10\n|cFFFFD700千萬別賣掉，你用來繼續升級的!" },
		{ 340, "336-340: 厚重德萊尼外套\n(14x境外皮革/3x符文線)x5" },
		{ 355, "341-355: 魔化鱗片胸甲\n(14x境外皮革/3x魔化鱗片/3x符文線)x15" },
		{ 365, "356-365: 厚重裂蹄長靴\n(4x厚裂締皮/20x厚裂蹄牛皮/4x原始大地/2x符文線)x10\n配方購於:\n芬德雷迅矛:贊格沼澤<79,63>\n|cFFFFD700需要塞納裏奧遠征隊 - 友善\n|cFFFFD700厚裂蹄牛皮在納葛蘭獲取" },
		{ 375, "366-375: 戰鬥之鼓\n(6x厚境外皮革/4x厚裂蹄牛皮)x10\n配方購於:\n奧瑪多爾:薩塔斯城<51,41>\n|cFFFFD700需要薩塔 - 尊敬" }
	},
	[TS.ENGINEERING] = {
		{ 40, "1-40: 劣質火藥\n(1x劣質的石頭)x40" },
		{ 50, "41-50: 一把螺栓\n(1x銅錠)x10" },
		{ 51, "51: 扳手\n(6x銅錠)x1" },
		{ 65, "52-65: 銅管\n(2x銅錠/1x弱效助熔劑)x14" },
		{ 75, "66-75: 劣質火槍\n(1x銅管/1x一把螺栓/1x木柴)x10" },
		{ 95, "76-95: 粗制火藥粉\n(1x粗糙的石頭)x20" },
		{ 105, "96-105: 銀觸媒\n(1x銀錠)x10" },
		{ 120, "106-120: 青銅管\n(2x青銅錠/1x弱效助熔劑)x15" },
		{ 125, "121-125: 小型青銅炸彈\n(4x粗制火藥粉/2x青銅錠/1x銀觸媒/1x毛料)x5" },
		{ 145, "126-145: 烈性火藥\n(1x沉重的石頭)x20" },
		{ 150, "146-150: 重磅青銅炸彈\n(2x烈性火藥/3x青銅錠/1x銀觸媒)x5" },
		{ 175, "151-175: 藍色焰火/紅色焰火/綠色焰火\n(1x烈性火藥/1x重皮)x25" },
		{ 176, "176: 地精微調器\n(4x鋼錠)x1" },
		{ 190, "177-190: 實心炸藥\n(2x堅固的石頭)x14" },
		{ 195, "191-195: 重磅鐵制炸彈\n(3x烈性火藥/3x鐵錠/1x銀觸媒)x5" },
		{ 205, "196-205: 秘銀管\n(3x秘銀錠)x10" },
		{ 210, "206-210: 不牢固的扳機\n(1x秘銀錠/1x魔紋布/1x實心炸藥)x5" },
		{ 225, "211-225: 高速秘銀彈頭\n(1x秘銀錠/1x實心炸藥)x15" },
		{ 235, "226-235: 秘銀外殼\n(3x秘銀錠)x10" },
		{ 245, "236-245: 高爆炸彈\n(2x秘銀外殼/1x不牢固的扳機/2x實心炸藥)x10" },
		{ 250, "246-250: 秘銀螺旋彈\n(2x秘銀錠/2x實心炸藥)x5" },
		{ 260, "251-260: 緻密炸藥粉\n(2x厚重的石頭)x10" },
		{ 290, "261-290: 瑟銀零件\n(3x瑟銀錠/1x符文布)x30" },
		{ 300, "291-300: 瑟銀管\n(3x瑟銀錠)x10\n瑟銀彈\n(2x瑟銀錠/1x緻密炸藥粉)x10" },
		{ 310, "301-310: 魔鐵外殼\n(3x魔鐵錠)x10\n一把魔鐵螺栓\n(1x魔鐵錠)x10\n元素炸藥粉\n(1x火焰微粒/2x大地微粒)x10\n保留這些東西，為了下一步使用!" },
		{ 320, "311-320: 魔鐵炸彈\n(1x魔鐵外殼/2x一把魔鐵螺栓/1x元素炸藥粉)x10" },
		{ 335, "321-335: 魔鐵步槍\n(1x沉重的樹幹/3x魔鐵外殼/6x一把魔鐵螺栓)x15" },
		{ 350, "336-350: 白色煙幕彈\n(1x元素炸藥粉/1x幽紋布)x15" },
		{ 360, "351-360: 克銀能量核心\n(3x克銀錠/1x原始之火)x10\n最好做20個，下一步要用到" },
		{ 375, "361-375: 修理機器人110G型\n(8x堅鋼錠/8x一把魔鐵螺栓/1x克銀能量核心)x15\n掉落:甘納格分解者 劍刃山脈" }
	},
	[TS.JEWELCRAFTING] = {
		{ 20, "1-20: 精緻的銅絲\n(2x銅錠)x20" },
		{ 30, "21-30: 劣質石像\n(8x劣質的石頭)x10" },
		{ 50, "31-50: 虎眼指環\n(1x虎眼石/1x精緻的銅絲)x20" },
		{ 75, "51-75: 青銅底座\n(2x青銅錠)x25" },
		{ 80, "76-80: 結實的青銅戒指\n(4x青銅錠)x5" },
		{ 90, "81-90: 優雅的銀戒指\n(1x銀錠)x10" },
		{ 110, "91-110: 銀色力量之戒\n(2x銀錠)x20" },
		{ 120, "111-120: 沉重石像\n(8x沉重的石頭)x10" },
		{ 150, "121-150: 瑪瑙護盾墜飾\n(1x綠瑪瑙/1x青銅底座)x30\n金色巨龍戒指\n(1x翡翠/2x金錠/2x精緻的銅絲)x30" },
		{ 180, "151-180: 秘銀絲邊\n(2x秘銀錠)x30" },
		{ 200, "181-200: 蝕刻真銀戒指\n(1x真銀錠/2x秘銀絲邊)x20" },
		{ 210, "201-210: 迅疾治療之黃水晶戒指\n(1x黃水晶/2x元素之水/2x秘銀錠)x10" },
		{ 225, "211-225: 青綠石徽記\n(3x青綠石/4x魔精)x15" },
		{ 250, "226-250: 瑟銀底座\n(1x瑟銀錠)x25" },
		{ 255, "251-255: 紅色毀滅指環\n(1x紅寶石/1x瑟銀底座)x5" },
		{ 265, "256-265: 真銀治療戒指\n(2x真銀錠/2x野性之心)x10" },
		{ 275, "266-275: 樸素的貓眼石戒指\n(1x大貓眼石/1x瑟銀底座)x10" },
		{ 285, "276-285: 藍寶石徽記\n(4x藍寶石/2x真銀錠/1x瑟銀底座)x10" },
		{ 290, "286-290: 鑽石專注戒指\n(1x艾澤拉斯鑽石/1x瑟銀底座)x5" },
		{ 300, "291-300: 翡翠獅王戒指\n(2x巨型綠寶石/1x瑟銀底座)x10" },
		{ 310, "301-310: 任何優秀品質的寶石(綠色)x10" },
		{ 315, "311-315: 魔鐵血戒\n(1x魔鐵錠/2x血石榴石)x5\n任何優秀品質的寶石(綠色)x5" },
		{ 320, "316-320: 任何優秀品質的寶石(綠色)x10" },
		{ 325, "321-325: 藍月石指環\n(1x魔鐵錠/2x藍月石/1x翠綠橄欖石)x5" },
		{ 335, "326-335: 水銀堅鋼石(升級用到)\n(4x堅鋼粉未/1x原始大地)x10\n任何優秀品質的寶石(綠色)x10" },
		{ 350, "336-350: 重型堅鋼戒指\n(1x堅鋼錠/1x水銀堅鋼石)x15" },
		{ 355, "351-355: 任何精良品質的寶石(藍色)x5" },
		{ 360, "356-360: 世界掉落配方，例如:\n生命紅寶石墜飾\n(4x克銀錠/1x水銀堅鋼石/1x生命紅寶石)x5\n厚重魔鋼項鏈\n(2x魔鋼錠/3x水銀堅鋼石)x5" },
		{ 365, "361-365: 秘法護盾指環\n(2x堅鋼錠/8x原始法力)x5\n配方購於:\n奧瑪多爾:薩塔斯城<51,41>\n|cFFFFD700需要薩塔 - 尊敬" },
		{ 375, "366-375: 大地風暴鑽石或天火鑽石系列\n世界掉落(精良品質)\n部分可購買，需要薩塔/薩爾瑪/榮譽堡/破碎之日 - 崇敬" }
	},
	[TS.ENCHANTING] = {
		{ 2, "1-2: 符文銅棒\n(1x銅棒/1x奇異之塵/1x次級魔法精華)x1" },
		{ 75, "3-75: 附魔護腕 - 初級生命\n(1x奇異之塵)x73" },
		{ 85, "76-85: 附魔護腕 - 初級偏斜\n(1x次級魔法精華/1x奇異之塵)x20" },
		{ 100, "86-100: 附魔護腕 - 初級耐力\n(3x奇異之塵)x15" },
		{ 101, "101: 符文銀棒\n(1x銀棒/6x奇異之塵/3x強效魔法精華/1x符文銅棒)x1" },
		{ 105, "102-105: 附魔護腕 - 初級耐力\n(3x奇異之塵)x4" },
		{ 120, "106-120: 強效魔法杖\n(1x普通木柴/1x強效魔法精華)x15" },
		{ 130, "121-130: 附魔盾牌 - 初級耐力\n(1x次級星界精華/2x奇異之塵)x10" },
		{ 150, "131-150: 附魔護腕 - 次級耐力\n(2x靈魂之塵)x20" },
		{ 151, "151: 符文金棒\n(1x金棒/1x彩色珍珠/2x強效星界精華/2x靈魂之塵/1x符文銀棒)x1" },
		{ 160, "152-160: 附魔護腕 - 次級耐力\n(2x靈魂之塵)x9" },
		{ 165, "161-165: 附魔盾牌 - 次級耐力\n(1x次級秘法精華/1x靈魂之塵)x5" },
		{ 180, "166-180: 附魔護腕 - 精神\n(1x次級秘法精華)x15" },
		{ 200, "181-200: 附魔護腕 - 力量\n(1x幻象之塵)x20" },
		{ 201, "201: 符文真銀棒\n(1x真銀棒/1x黑珍珠/2x強效秘法精華/2x幻象之塵/1x符文金棒)x1" },
		{ 205, "202-205: 附魔護腕 - 力量\n(1x幻象之塵)x4" },
		{ 225, "206-225: 附魔披風 - 強效防禦\n(3x幻象之塵)x20" },
		{ 235, "226-235: 附魔手套 - 敏捷\n(1x次級虛空精華/1x幻象之塵)x10" },
		{ 245, "236-245: 附魔胸甲 - 超強生命\n(6x幻象之塵)x10" },
		{ 250, "246-250: 附魔護腕 - 強效力量\n(2x夢境之塵/1x強效虛空精華)x5" },
		{ 270, "251-270: 次級法力之油\n(3x夢境之塵/2x紫蓮花/1x水晶瓶)x20\n配方購於:\n卡妮亞:希利蘇斯<51,39>" },
		{ 290, "271-290: 附魔盾牌 - 強效耐力\n(10x夢境之塵)x20\n附魔靴子 - 強效耐力\n(10x夢境之塵)x20" },
		{ 291, "291: 符文奧金棒\n(1x奧金棒/1x金珍珠/10x幻影之塵/4x強效不滅精華/1x符文真銀棒/2x大塊魔光碎片)x1" },
		{ 300, "292-300: 附魔披風 - 超強防禦\n(8x幻影之塵)x9" },
		{ 301, "301: 符文魔鐵棒\n(1x魔鐵棒/4x強效不滅精華/6x大塊魔光碎片/1x符文奧金棒)x1" },
		{ 305, "302-305: 附魔披風 - 超強防禦\n(8x幻影之塵)x4" },
		{ 315, "306-315: 附魔護腕 - 攻擊\n(6x魔塵)x10" },
		{ 325, "316-325: 附魔披風 - 特效護甲\n(8x魔塵)x10\n附魔護腕 - 攻擊\n(6x魔塵)x10" },
		{ 335, "326-335: 附魔胸甲 - 特效精神\n(2x強效異界精華)x10" },
		{ 340, "336-340: 附魔盾牌 - 特效耐力\n(15x魔塵)x5" },
		{ 345, "341-345: 超級巫師之油\n(3x魔塵/1x夢魘根/1x灌魔之瓶)x5\n配方購於:\n盧比夫人:薩塔斯城<63,70>\n琳娜:銀月城<69,24>\n艾苟米斯:埃索達<39,39>\n如果有足夠的夢魘根最好沖到350，這個材料便宜" },
		{ 350, "346-350: 附魔手套 - 極效力量\n(12x魔塵/1x強效異界精華)x5" },
		{ 351, "351: 符文堅鋼棒\n(1x堅鋼棒/8x強效異界精華/8x大塊棱光碎片/1x原始力量/1x符文魔鐵棒)x1\n配方購於:\n沃德辛:地獄火半島<24,38>\n倫格爾:泰洛卡森林<48,46>" },
		{ 360, "352-360: 附魔手套 - 極效力量\n(12x魔塵/1x強效異界精華)x9" },
		{ 370, "361-370: 附魔手套 - 法術打擊\n(8x強效異界精華/2x魔塵/2x大塊棱光碎片)x10\n配方購於:\n芬德雷迅矛:贊格沼澤<79,63>\n|cFFFFD700需要塞納裏奧遠征隊 - 崇敬" },
		{ 375, "371-375: 附魔戒指 - 治療能量\n(2x大塊棱光碎片/3x強效異界精華/5x魔塵)x5\n配方購於:\n奧瑪多爾:薩塔斯城<51,41>\n|cFFFFD700需要薩塔 - 崇敬" }
	},
	[TS.BLACKSMITHING] = {	
		{ 25, "1-25: 劣質磨刀石\n(1x劣質的石頭)x25" },
		{ 45, "26-45: 劣質砂輪\n(2x劣質的石頭)x20" },
		{ 75, "46-75: 銅質鎖甲腰帶\n(6x銅錠)x30" },
		{ 80, "76-80: 粗制砂輪\n(2x粗糙的石頭)x5" },
		{ 100, "81-100: 銅質符文腰帶\n(10x銅錠)x20" },
		{ 105, "101-105: 銀棒\n(1x銀錠/2x劣質砂輪)x5" },
		{ 125, "106-125: 劣質青銅護腿\n(6x青銅錠)x20" },
		{ 150, "126-150: 重砂輪\n(3x沉重的石頭)x25" },
		{ 155, "151-155: 金棒\n(1x金錠/2x粗制砂輪)x5" },
		{ 165, "156-165: 綠鐵護腿\n(8x鐵錠/1x重砂輪/1x綠色染料)x10" },
		{ 185, "166-185: 綠鐵護腕\n(6x鐵錠/1x綠色染料)x20" },
		{ 200, "186-200: 金鱗護腕\n(5x鋼錠/2x重砂輪)x15" },
		{ 210, "201-210: 堅固的砂輪\n(4x堅固的石頭)x10" },
		{ 215, "211-215: 金鱗護腕\n(5x鋼錠/2x重砂輪)x5" },
		{ 235, "216-235: 鋼質頭盔\n(14x鋼錠/1x堅固的砂輪)x20\n秘銀鱗片護腕(成本低)\n(8x秘銀錠)x20\n配方購於:\n哈爾甘:辛特蘭,鷹巢山<13,44>\n卡爾拉什:悲傷沼澤,斯通納德<45,51>" },
		{ 250, "236-250: 秘銀罩帽\n(10x秘銀錠/6x魔紋布)x15\n秘銀馬刺(成本低)\n(4x秘銀錠/3x堅固的砂輪)x15\n配方世界掉落" },
		{ 260, "251-260: 緻密磨刀石\n(1x厚重的石頭)x10" },
		{ 270, "261-270: 瑟銀腰帶(成本低)\n(12x瑟銀錠/4x紅色能量水晶)x10\n瑟銀護腕(成本低)\n(12x瑟銀錠/4x藍色能量水晶)x10\n以上兩種配方世界掉落\n地鑄護腿 (防具鍛造)\n(16x秘銀錠/2x大地之核)x10\n風鑄護腿(防具鍛造)\n((16x秘銀錠/2x風之氣息))x10\n輕型地鑄利刃(鑄劍大師)\n(12x秘銀錠/4x大地之核)x10\n輕型灰燼鑄錘(鑄錘大師)\n(12x秘銀錠/4x火焰之心)x10\n輕型天鑄戰斧(大師鑄斧)\n(12x秘銀錠/4x風之氣息)x10" },
		{ 295, "271-295: 君王鎧甲護腕\n(12x瑟銀錠)x25\n配方任務取得" },
		{ 300, "296-300: 君王鎧甲戰靴\n(18x瑟銀錠)x5\n配方任務取得" },
		{ 305, "301-305: 魔能平衡石\n(1x魔鐵錠/1x幽紋布)x5" },
		{ 320, "306-320: 魔鐵鎧甲腰帶\n(4x魔鐵錠)x15" },
		{ 325, "321-325: 魔鐵鎧甲戰靴\n(6x魔鐵錠)x5" },
		{ 330, "326-330: 次級結界符文\n(1x堅鋼錠)x5" },
		{ 335, "331-335: 魔鐵胸甲\n(10x魔鐵錠)x5" },
		{ 340, "336-340: 堅鋼利斧\n(8x堅鋼錠)x5\n配方購於:\n埃隆霍爾曼:薩塔斯城<64,71>\n恩裏德:銀月城<80,36>\n阿爾拉斯:埃索達<61,89>" },
		{ 345, "341-345: 次級護盾結界\n(1x堅鋼錠)x5\n配方購於:瑪裏石拳:影月谷,蠻錘要塞<36,55>/羅霍克:地獄火半島,薩爾瑪<53,38>" },
		{ 350, "346-350: 堅鋼利斧\n(8x堅鋼錠)x5\n配方購於:\n埃隆霍爾曼:薩塔斯城<64,71>\n恩裏德:銀月城<80,36>\n阿爾拉斯:埃索達<61,89>" },
		{ 360, "351-360: 堅鋼平衡石\n(1x堅鋼錠/2x幽紋布)x10\n配方購於:\n芬德雷迅矛:贊格沼澤<79,63>\n|cFFFFD700需要塞納裏奧遠征隊 - 尊敬" },
		{ 370, "361-370: 魔鋼手套\n(6x魔鋼錠)x10\n奧奇奈地穴掉落\n烈焰毀滅手套\n(8x魔鐵錠/4x原始之水/4x原始之火)x10\n配方購於:\n軍需官恩達爾林:薩塔斯城<47,25>\n|cFFFFD700需要奧多爾 - 尊敬\n魔化堅鋼腰帶\n(2x特堅鋼錠/8x魔塵/2x大塊棱光碎片)x10\n配方購於:\n軍需官恩努利爾:薩塔斯城<60,64>\n|cFFFFD700需要占星者 - 友善" },
		{ 375, "371-375: 魔鋼手套\n(6x魔鋼錠)x5\n奧奇奈地穴掉落\n烈焰毀滅胸甲\n配方購於:\n軍需官恩達爾林:薩塔斯城<47,25>\n(16x魔鐵錠/6x原始之水/4x原始之火)x5\n|cFFFFD700需要奧多爾 - 尊敬\n魔化堅鋼腰帶\n(2x特堅鋼錠/8x魔塵/2x大塊棱光碎片)x5\n配方購於:\n軍需官恩努利爾:薩塔斯城<60,64>\n|cFFFFD700需要占星者 - 友善"  }
	},
	[TS.ALCHEMY] = {	
		{ 60, "1-60: 初級治療藥水\n(1x寧神花/1x銀葉草/1x空瓶)x60" },
		{ 110, "61-110: 次級治療藥水\n(1x初級治療藥水/1x石南草)x50" },
		{ 140, "111-140: 治療藥水\n(1x跌打草/1x石南草/1x鉛瓶)x30" },
		{ 155, "141-155: 次級法力藥水\n(1x魔皇草/1x荊棘藻/1x空瓶)x15" },
		{ 185, "156-185: 強效治療藥水\n(1x活根草/1x皇血草/1x鉛瓶)x30" },
		{ 210, "186-210: 敏捷藥劑\n(1x荊棘藻/1x金棘草/1x鉛瓶)x25" },
		{ 215, "211-215: 強效防禦藥劑\n(1x野鋼花/1x金棘草/1x鉛瓶)x5" },
		{ 230, "216-230: 優質治療藥水\n(1x太陽草/1x卡德加的鬍鬚/1x水晶瓶)x15" },
		{ 250, "231-250: 偵測不死生物藥劑\n(1x阿爾薩斯之淚/1x水晶瓶)x20" },
		{ 265, "251-265: 強效敏捷藥劑\n(1x太陽草/1x金棘草/1x水晶瓶)x15" },
		{ 285, "266-285: 超強法力藥水\n(2x太陽草/2x盲目草/1x水晶瓶)x20" },
		{ 300, "286-300: 極效治療藥水\n(2x黃金參/1x山鼠草/1x水晶瓶)x15" },
		{ 315, "301-315: 強烈治療藥水\n(1x黃金參/1x魔獄草/1x灌魔之瓶)x15\n極效法力藥水\n(3x夢葉草/2x冰蓋草/1x水晶瓶)x15" },
		{ 350, "316-350: 瘋狂煉金師藥水\n(1x水晶瓶/2x拉格維花)x35+\n在335的時候會變黃，但是該配方成本低" },
		{ 375, "351-375: 極效昏睡藥水\n(1x譽夢草/1x夢魘根/1x灌魔之瓶)x25\n配方購於:莉莉朗哈格:泰洛卡森林,艾蘭里堡疊<57,53>\n聯達加拉姆巴:劍刃山脈,雷神要塞<51,57>" }
	},
	[L["Mining"]] = {
		{ 65, "1-65: 銅礦\n所有起始地區" },
		{ 125, "66-125: 錫礦/銀礦/火岩礦/次級血石礦\n\n火岩礦分佈于瑟根石(濕地)\n很容易升到125" },
		{ 175, "126-175: 鐵礦/金礦\n淒涼之地/灰谷/荒蕪之地/阿拉希高地\n奧特蘭克山脈/荊棘谷/悲傷沼澤" },
		{ 250, "176-250: 秘銀礦/真銀礦\n詛咒之地/灼熱峽谷/荒蕪之地/辛特蘭\n西瘟疫之地/艾薩拉/冬泉谷/費伍德森林/石爪山脈/塔納利斯" },
		{ 300, "251-300: 瑟銀礦\n安戈洛環形山/冬泉谷/詛咒之地/灼熱峽谷\n燃燒平原/東瘟疫之地/西瘟疫之地" },
		{ 330, "301-330: 魔鐵礦\n地獄火半島/贊格沼澤" },
		{ 375, "331-375: 魔鐵礦/堅鋼礦\n泰洛卡森林/納葛蘭\n所有外域地區均有" }
	},
	[L["Herbalism"]] = {
		{ 50, "1-50: 銀葉草/寧神花\n所有起始地區" },
		{ 70, "51-70: 魔皇草/地根草\n貧瘠之地/西部荒野/銀松森林/洛克莫丹/黑海岸" },
		{ 100, "71-100: 石南草\n銀松森林/暮色森林/黑海岸/洛克莫丹/赤脊山" },
		{ 115, "101-115: 跌打草\n灰谷/石爪山脈/南貧瘠之地/洛克莫丹/赤脊山" },
		{ 125, "116-125: 野鋼花\n石爪山脈/阿拉希高地/荊棘谷/南貧瘠之地/千針石林" },
		{ 160, "126-160: 皇血草\n灰谷/石爪山脈/濕地/希爾斯布萊德丘陵/悲傷沼澤" },
		{ 185, "161-185: 枯葉草\n悲傷沼澤" },
		{ 205, "186-205: 卡德加的鬍鬚\n辛特蘭/阿拉希高地/悲傷沼澤" },
		{ 230, "206-230: 火焰花\n灼熱峽谷/詛咒之地/塔納利斯" },
		{ 250, "231-250: 太陽草\n費伍德森林/菲拉斯/艾薩拉/辛特蘭" },
		{ 270, "251-270: 格羅姆之血\n費伍德森林/詛咒之地/瑪諾洛克集會所(淒涼之地)" },
		{ 285, "271-285: 夢葉草\n安戈洛環形山/艾薩拉" },
		{ 300, "286-300: 瘟疫花\n東瘟疫之地/西瘟疫之地/費伍德森林/\n冰蓋草\n冬泉谷" },
		{ 330, "301-330: 魔獄草\n地獄火半島/贊格沼澤" },
		{ 375, "331-375: 任何外域植物\n贊格沼澤和泰洛卡森林較集中" }
	},
	[L["Skinning"]] = {
		{ 375, "1-375: 技能等級處以5,\n所獲值對應的可剝皮怪物" }
	},
	-- 來源: http://www.almostgaming.com/wowguides/world-of-warcraft-lockpicking-guide
	[L["Lockpicking"]] = {
		{ 85, "1-85: 開鎖練習\n奧瑟爾伐木場，赤脊山(聯盟)\n棘齒城附近的海盜船(部落)" },
		{ 150, "86-150: 制毒任務目標怪附近的箱子\n西部荒野(聯盟)/貧瘠之地(部落)" },
		{ 185, "151-185: 魚人營地(濕地)" },
		{ 225, "186-225: 薩瑟裏斯海岸(淒涼之地)\n" },
		{ 250, "226-250: 苦痛堡壘(荒蕪之地)" },
		{ 275, "251-275: 熔渣之池(灼熱峽谷)" },
		{ 300, "276-300: 落帆海灣(塔納利斯)\n風暴海灣(艾薩拉)" },
		{ 325, "301-325: 蠻沼村(贊格沼澤)" },
		{ 350, "326-350: 基爾索羅堡壘(納葛蘭)\n偷取石拳系巨魔(納葛蘭)" }
	},
	
	-- ** 輔助技能 **
	[TS.FIRSTAID] = {
		{ 40, "1-40: 亞麻繃帶" },
		{ 80, "41-80: 厚亞麻繃帶\n50的時候學急救(中級)" },
		{ 115, "81-115: 絨線繃帶" },
		{ 150, "116-150: 厚絨線繃帶\n125的時候去買教材<中級急救教材 - 繃帶縛體>和2個配方\n配方購於:\n德尼布沃克:阿拉希高地,激流堡<27,58>\n格魯克卡恩:塵泥沼澤,蕨牆村<35,30>\n巴萊洛克維:塵泥沼澤,蕨牆村<36,30>" },
		{ 180, "151-180: 絲質繃帶" },
		{ 210, "181-210: 厚絲質繃帶\n200的時候滿35級，做任務學會急救(專家級)\n地點:塞拉摩島(聯盟)/落錘鎮(部落)" },
		{ 240, "211-240: 魔紋繃帶\n" },
		{ 260, "241-260: 厚魔紋繃帶" },
		{ 290, "261-290: 符文布繃帶" },
		{ 330, "291-330: 厚符文布繃帶\n300的時候去買教材<大師級急救手冊 - 私人醫生>\n配方購於:\n阿蕾瑟拉:地獄火半島,塔哈瑪特神殿<26,62>\n布林庫:地獄火半島,獵鷹崗哨<22,39>" },
		{ 360, "331-360: 幽紋布繃帶\n購買<手冊:幽紋布繃帶>\n配方購於:\n阿蕾瑟拉:地獄火半島,塔哈瑪特神殿<26,62>\n布林庫:地獄火半島,獵鷹崗哨<22,39>" },
		{ 375, "361-375: 厚幽紋布繃帶\n購買<手冊:厚幽紋布繃帶>\n配方購於:\n阿蕾瑟拉:地獄火半島,塔哈瑪特神殿<26,62>\n布林庫:地獄火半島,獵鷹崗哨<22,39>" }
	},
	[TS.COOKING] = {
		{ 40, "1-40: 香料麵包\n(1x麵粉/1x甜香料)x70" },
		{ 75, "41-75: 熏熊肉\n(1x熊肉)x30\n配方購於:\n德拉克卷刃:洛克莫丹<35,49>\n安德魯希爾伯特:銀松森林<43,40>" },
		{ 85, "76-85: 蟹肉蛋糕(聯盟)\n(1x蟹肉, 1x甜香料)x10\n熏熊肉(部落)\n(1x熊肉)x20\n配方購於:\n德拉克卷刃:洛克莫丹<35,49>\n安德魯希爾伯特:銀松森林<43,40>" },
		{ 90, "86-90: 煮蟹爪(聯盟)\n(1x蟹爪, 1x甜香料)x5\n配方購於:\n肯多爾卡邦卡:暴風城<74,36>\n熏熊肉(部落)\n(1x熊肉)x10\n配方購於:\n德拉克卷刃:洛克莫丹<35,49>\n安德魯希爾伯特:銀松森林<43,40>" },
		{ 100, "91-100: 煮蟹爪(聯盟)\n(1x蟹爪/1x甜香料)x15\n配方購於:\n肯多爾卡邦卡:暴風城<74,36>\n掘地鼠燉肉(部落)\n(1x掘地鼠)x10\n配方任務獲取:[23]掘地鼠燉肉" },
		{ 125, "101-125: 掘地鼠燉肉(部落)\n(1x掘地鼠)x30\n配方任務獲取:[23]掘地鼠燉肉\n幹烤狼肉串(聯盟)\n(2x狼肋排/1x暴風城特產調料)x25\n配方購於:\n肯多爾卡邦卡:暴風城<74,36>" },
		{ 130, "126-130: 烤獅排(部落)\n(1x獅肉/1x辣椒)x5\n配方購於:\n紮爾夫:貧瘠之地<52,29>\n幹烤狼肉串(聯盟)\n(2x狼肋排/1x暴風城特產調料)x25\n配方購於:\n肯多爾卡邦卡:暴風城<74,36>" },
		{ 175, "131-175: 美味煎蛋捲(聯盟)\n(1x迅猛龍蛋/1x辣椒)x50\n配方購於:\n肯多爾卡邦卡:暴風城<74,36>\n烤獅排(部落)\n(1x獅肉/1x辣椒)x55\n配方購於:\n紮爾夫:貧瘠之地<52,29>" },
		{ 200, "176-200: 烤迅猛龍肉\n(1x迅猛龍肉/1x辣椒)x30\n配方購於:\n耐裏斯特:荊棘谷,格羅姆高營地<32,29>\n布魯斯下士:荊棘谷,反抗軍營地<37,3>" },
		{ 225, "201-225: 蜘蛛肉腸\n(2x白蜘蛛肉)x30\n\n|cFFFFFFFF225接到烹飪大師任務: 迪爾格奎克裏弗:加基森<51,27>給予\n|cFFFFD700需要12個巨蛋/10個美味的蚌肉/20個奧特蘭克冷酪" },
		{ 275, "226-275: 超級煎蛋捲\n(1x巨蛋/2x舒心草)x80\n配方購於:\n琦亞:冬泉谷,永望鎮<61,37>\n西米克:冬泉谷,永望鎮<61,39>\n拜爾:費伍德森林,血毒崗哨<34,53>\n瑪裏甘:費伍德森林,刺枝林地<62,25>\n嫩狼肉排\n(1x嫩狼肉/1x舒心草)x80\n配方購於:\n迪爾格奎克裏弗:塔納利斯,加基森<52,28>\n特魯克蠻鬃:辛特蘭,鷹巢山<14,42>" },
		{ 285, "276-285: 洛恩塔姆薯塊\n(1x洛恩塔姆地薯/1x舒心草)x10\n掉落:普希林 厄運之槌" },
		{ 300, "286-300: 沙漠肉丸子\n(1x沙蟲的肉/1x舒心草)x20\n希利蘇斯任務(旅店老闆)" },
		{ 325, "301-325: 掠食者熱狗\n(1x掠食者的肉)x40\n配方購於:\n獨眼曲奇:地獄火半島,薩爾瑪<54,41>\n希德利巴迪:地獄火半島,榮譽堡<54,63>\n美味禿鷲\n(1x禿鷹肉)x40\n來源:任務 [61]萬無一失" },
		{ 350, "326-350: 燒烤裂蹄牛\n(1x裂蹄牛肉)x40\n配方購於:\n屠夫努爾拉:納葛蘭,加拉達爾<58,35>\n烏利庫:納葛蘭,泰拉<56,73>\n扭曲漢堡\n(1x扭曲肉塊)x40\n配方購於:\n屠夫努爾拉:納葛蘭,加拉達爾<58,35>\n烏利庫:納葛蘭,泰拉<56,73>\n旅店老闆格裏爾卡:泰洛卡森林,裂石堡<48,45>\n供給官米爾斯:泰洛卡森林,艾蘭里堡疊<55,53>\n塔布肉排\n(1x塔布羊肉)x40\n配方購於:\n屠夫努爾拉:納葛蘭,加拉達爾<58,35>\n烏利庫:納葛蘭,泰拉<56,73>" },
		{ 375, "351-375: 香辣小龍蝦\n(1x狂暴龍蝦)x25\n配方購於:\n旅店老闆貝莉比:泰洛卡森林,艾蘭里堡疊<56,53>\n倫格爾:泰洛卡森林,裂石堡<48,46>\n此處建議和釣魚一起練\n莫克納薩肋排\n(1x迅猛龍肋排)x60\n香脆蛇\n(1x蛇肉)x60c\n以上兩個配方來源:\n任務 [67]莫克納薩的美味(部落)\n購買:薩莎焊井:劍刃山脈,托雷斯營地<61,68>" }
	},	
	-- 來源: http://www.wowguideonline.com/fishing.html
	[TS.FISHING] = {
		{ 50, "1-50: 任何起始地點" },
		{ 75, "51-75:\n暴風城的河裏\n奧格瑞瑪的池塘裏" },
		{ 150, "76-150: 希爾斯布萊德丘陵的河裏" },
		{ 225, "151-225: 淒涼之地/阿拉希高地\n150的時候購買<中級釣魚教材 - 鱸魚與你>\n配方購於:\n老人海明威:藏寶海灣<27,77>" },
		{ 250, "226-250: 辛特蘭/塔納利斯\n\n|cFFFFFFFF225開始高級釣魚任務\n起始於各個主城，均到納特帕格:塵泥沼澤<59,61>\n|cFFFFD700野人海岸藍色叉牙魚(荊棘谷<34,35>)\n菲拉斯草魚(沃丹提斯河, 菲拉斯)\n薩瑟裏斯虎魚(薩瑟裏斯海岸北部, 葬影村附近, 淒涼之地)\n蘆葦海岸大馬哈魚(蘆葦海岸, 悲傷沼澤)" },
		{ 260, "251-260: 費伍德森林" },
		{ 300, "261-300: 艾薩拉" },
		{ 330, "301-330: 贊格沼澤東部\n300的時候購買<頂級釣魚教材 - 下鉤的藝術>\n配方購於:\n喬諾杜伏恩:塞納裏奧避難所<78,66>" },
		{ 345, "331-345: 贊格沼澤西部" },
		{ 360, "346-360: 泰洛卡森林" },
		{ 375, "361-375: 泰洛卡森林,高地上:\n尤魯恩湖, 裂石堡西北方\n艾雷諾湖, 艾蘭里堡疊東南方\n黑風湖, 司凱堤斯地區\n需要飛行坐騎" }
	},
	
	[TS.ARCHAEOLOGY] = {
		{ 300, "1~300: " .. continents[1] .. "\n" .. continents[2]},
		{ 375, "301~375: " .. continents[3]},
		{ 450, "376~450: " .. continents[4]},
		{ 525, "451~525: " .. GetMapNameByID(606) .. "\n" .. GetMapNameByID(720) .. "\n" .. GetMapNameByID(700)},
		{ 600, "526~600: " .. continents[6]},
	},
	
	-- suggested leveling zones, as defined by recommended quest levels. map id's : http://wowpedia.org/MapID
	-- 建議升級地區，來源眾多，不一一列舉了
	["Leveling"] = {
		{ 10, "1-10級: 所有起始地區" },
		
		{ 15, "15級: " .. GetMapNameByID(39)},
		{ 16, "16級: " .. GetMapNameByID(684)},
		{ 20, "20級: " .. GetMapNameByID(181) .. "\n" .. GetMapNameByID(35) .. "\n" .. GetMapNameByID(476)
							.. "\n" .. GetMapNameByID(42) .. "\n" .. GetMapNameByID(21) .. "\n" .. GetMapNameByID(11)
							.. "\n" .. GetMapNameByID(463) .. "\n" .. GetMapNameByID(36)},
		{ 25, "25級: " .. GetMapNameByID(34) .. "\n" .. GetMapNameByID(40) .. "\n" .. GetMapNameByID(43) 
							.. "\n" .. GetMapNameByID(24)},
		{ 30, "30級: " .. GetMapNameByID(16) .. "\n" .. GetMapNameByID(37) .. "\n" .. GetMapNameByID(81)},
		{ 35, "35級: " .. GetMapNameByID(673) .. "\n" .. GetMapNameByID(101) .. "\n" .. GetMapNameByID(26)
							.. "\n" .. GetMapNameByID(607)},
		{ 40, "40級: " .. GetMapNameByID(141) .. "\n" .. GetMapNameByID(121) .. "\n" .. GetMapNameByID(22)},
		{ 45, "45級: " .. GetMapNameByID(23) .. "\n" .. GetMapNameByID(61)},
		{ 48, "48級: " .. GetMapNameByID(17)},
		{ 50, "50級: " .. GetMapNameByID(161) .. "\n" .. GetMapNameByID(182) .. "\n" .. GetMapNameByID(28)},
		{ 52, "52級: " .. GetMapNameByID(29)},
		{ 54, "54級: " .. GetMapNameByID(38)},
		{ 55, "55級: " .. GetMapNameByID(201) .. "\n" .. GetMapNameByID(281)},
		{ 58, "58級: " .. GetMapNameByID(19)},
		{ 60, "60級: " .. GetMapNameByID(32) .. "\n" .. GetMapNameByID(241) .. "\n" .. GetMapNameByID(261)},
		
		-- Outland
		-- 465 Hellfire Peninsula 
		-- 467 Zangarmarsh 
		-- 478 Terokkar Forest 
		-- 477 Nagrand 
		-- 475 Blade's Edge Mountains 
		-- 479 Netherstorm 
		-- 473 Shadowmoon Valley 
		
		{ 63, "63級: " .. GetMapNameByID(465)},
		{ 64, "64級: " .. GetMapNameByID(467)},
		{ 65, "65級: " .. GetMapNameByID(478)},
		{ 67, "67級: " .. GetMapNameByID(477)},
		{ 68, "68級: " .. GetMapNameByID(475)},
		{ 70, "70級: " .. GetMapNameByID(479) .. "\n" .. GetMapNameByID(473) .. "\n" .. GetMapNameByID(499) .. "\n" .. GetMapNameByID(32)},

		-- Northrend
		-- 491 Howling Fjord 
		-- 486 Borean Tundra 
		-- 488 Dragonblight 
		-- 490 Grizzly Hills 
		-- 496 Zul'Drak 
		-- 493 Sholazar Basin 
		-- 510 Crystalsong Forest 
		-- 495 The Storm Peaks 
		-- 492 Icecrown 
		
		{ 72, "72級: " .. GetMapNameByID(491) .. "\n" .. GetMapNameByID(486)},
		{ 75, "75級: " .. GetMapNameByID(488) .. "\n" .. GetMapNameByID(490)},
		{ 76, "76級: " .. GetMapNameByID(496)},
		{ 78, "78級: " .. GetMapNameByID(493)},
		{ 80, "80級: " .. GetMapNameByID(510) .. "\n" .. GetMapNameByID(495) .. "\n" .. GetMapNameByID(492)},
		
		-- Cataclysm
		-- 606 Mount Hyjal 
		-- 613 Vashj'ir 
		-- 640 Deepholm 
		-- 720 Uldum 
		-- 700 Twilight Highlands 
		
		{ 82, "82級: " .. GetMapNameByID(606) .. "\n" .. GetMapNameByID(613)},
		{ 83, "83級: " .. GetMapNameByID(640)},
		{ 84, "84級: " .. GetMapNameByID(720)},
		{ 85, "85級: " .. GetMapNameByID(700)},

		-- Pandaria
		-- 806 The Jade Forest 
		-- 807 Valley of the Four Winds 
		-- 857 Krasarang Wilds 
		-- 809 Kun-Lai Summit 
		-- 810 Townlong Steppes 
		-- 858 Dread Wastes 
		
		{ 86, "86級: " .. GetMapNameByID(806)},
		{ 87, "87級: " .. GetMapNameByID(807) .. "\n" .. GetMapNameByID(857)},
		{ 88, "88級: " .. GetMapNameByID(809)},
		{ 89, "89級: " .. GetMapNameByID(810)},
		{ 90, "90級: " .. GetMapNameByID(858)},
	},
}
