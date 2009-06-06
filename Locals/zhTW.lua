--zhTW locale file by 天明@眾星之子
local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "zhTW" )
if not L then return end

--@localization(locale="zhTW", format="lua_additive_table", handle-unlocalized="ignore", escape-non-ascii=false, same-key-is-true=true)@

if GetLocale() == "zhTW" then
-- Altoholic.xml local
LEFT_HINT = "左鍵 |cFF00FF00開啟";
RIGHT_HINT = "右鍵 |cFF00FF00拖曳";

XML_ALTO_SHARING_HINT1 = "輸入帳戶名稱\n用作|cFF00FF00識別而已|r .\n"
				.. "這個名稱可以隨你歡喜,\n並 |cFF00FF00不需要|r 是真實的帳戶名稱.\n\n"
XML_ALTO_SHARING_HINT2 = "這欄 |cFF00FF00不能|r 留空."

XML_ALTO_TAB1 = "摘要"
XML_ALTO_TAB2 = "角色"
XML_ALTO_TAB3 = "搜尋"
-- XML_ALTO_TAB4 = GUILD_BANK
XML_ALTO_TABOPTIONS = "選項"

XML_ALTO_SUMMARY_MENU1 = "帳戶摘要"
XML_ALTO_SUMMARY_MENU2 = "背包使用度"
-- XML_ALTO_SUMMARY_MENU3 = SKILLS
XML_ALTO_SUMMARY_MENU4 = "活躍度"
XML_ALTO_SUMMARY_MENU5 = "公會成員"
XML_ALTO_SUMMARY_MENU6 = "公會技能"
XML_ALTO_SUMMARY_MENU7 = "公會金庫分頁"
XML_ALTO_SUMMARY_MENU8 = "Calendar"

XML_ALTO_SUMMARY_TEXT1 = "要求帳戶共享資料"
XML_ALTO_SUMMARY_TEXT2 = "按一下這個按鈕來詢問玩家\n"
				.. "要求分享Altoholic的數據庫\n"
				.. "並將其添加到您自己數據庫內"
XML_ALTO_SUMMARY_TEXT3 = "雙方都必須啟用帳戶共享\n來使用此功能 (請參考選項)"
XML_ALTO_SUMMARY_TEXT4 = "帳戶共享"

XML_ALTO_CHAR_DD1 = "伺服器"
XML_ALTO_CHAR_DD2 = "角色"
XML_ALTO_CHAR_DD3 = "顯示"

XML_ALTO_SEARCH_COL1 = "物品 / 地點"

XML_ALTO_GUILD_TEXT1 = "在提示框隱藏這公會金庫的顯示"

XML_ALTO_ACH_NOTSTARTED = "尚未啟動"
XML_ALTO_ACH_STARTED = "已啟動"

XML_ALTO_OPT_MENU1 = "一般"
XML_ALTO_OPT_MENU2 = "搜尋"
XML_ALTO_OPT_MENU3 = "郵件"
XML_ALTO_OPT_MENU4 = "小地圖"
XML_ALTO_OPT_MENU5 = "提示"

XML_TEXT_1 = "總數";
XML_TEXT_2 = "搜索容器";
XML_TEXT_3 = "等級範圍";
XML_TEXT_4 = "稀有";
XML_TEXT_5 = "設備格";
XML_TEXT_6 = "重置";
XML_TEXT_7 = "搜索";

XML_ALTO_TEXT10 = "帳戶名稱"
XML_ALTO_TEXT11 = "發送帳戶共享資料的要求:"

--Options.xml
XML_ALTO_OPT_GENERAL1 = "充份休息經驗值以150%來顯示";
XML_ALTO_OPT_GENERAL2 = "顯示圖示";
XML_ALTO_OPT_GENERAL3 = "顯示文字";
XML_ALTO_OPT_GENERAL4 = "啟用帳戶共享";
XML_ALTO_OPT_GENERAL5 = "啟用公會聯系";
XML_ALTO_OPT_GENERAL6 = "|cFFFFFFFF當 |cFF00FF00啟用|cFFFFFFFF時, 這選項會讓共它Altoholic用家\n"
				.. "可向你發送帳戶資料要求.\n\n"
				.. "當 |cFFFF0000關閉|cFFFFFFFF時, 所有帳戶資料要求會被拒.\n\n"
				.. "安全性提示: 只有當您需要實際的數據傳輸時才啟用,\n反之請關閉它"
XML_ALTO_OPT_GENERAL7 = "|cFFFFFFFF當 |cFF00FF00啟用|cFFFFFFFF時, 這選項會讓你公會的會友\n"
				.. "看見你的分身和其專業技能.\n\n"
				.. "當 |cFFFF0000關閉|cFFFFFFFF時, 將不會有任何公會聯系."
XML_ALTO_OPT_GENERAL8 = "自動授權公會金庫更新"
XML_ALTO_OPT_GENERAL9 = "|cFFFFFFFF當 |cFF00FF00啟用|cFFFFFFFF時, 此選項將允許其他Altoholic用戶\n"
				.. "與你的公會金庫資料作自動更新.\n\n"
				.. "當 |cFFFF0000關閉|cFFFFFFFF時, 發送任何信息\n"
				.. "之前將需要您的確認.\n\n"
				.. "安全提示：如果您有公會理事的權利請關閉\n"
				.. "有查看限制的公會金庫分頁來防止被任何人觀看,\n"
				.. "如需要同步時請用手動受權."
XML_ALTO_OPT_GENERAL10 = "Transparency"

XML_ALTO_OPT_SEARCH1 = "自動向伺服器查詢 |cFFFF0000(有可能導至斷線)";
XML_ALTO_OPT_SEARCH2 = "|cFFFFFFFF當物品不在本機的內存時\n"
				.. "當在搜索表裡找到,\n"
				.. "Altoholic 將試圖查詢服務器下5個新項目.\n\n"
				.. "這將逐步完善的一致性搜查,\n"
				.. "隨著越來越多的項目都可以在本機的內存時.\n\n"
				.. "如查詢的物品是一件非常高級的副本掉落\n"
				.. "極有可能導至斷線.\n\n"
				.. "|cFF00FF00關閉|r 這選項可避免這種情況發生";
XML_ALTO_OPT_SEARCH3 = "戰利品排序";
XML_ALTO_OPT_SEARCH4 = "包括沒等級要求的物品";
XML_ALTO_OPT_SEARCH5 = "包括郵箱";
XML_ALTO_OPT_SEARCH6 = "包括公會金庫";
XML_ALTO_OPT_SEARCH7 = "包括已學的配方";

XML_ALTO_OPT_MAIL1 = "當郵件屆滿少過此值的日數時發出警告";
XML_ALTO_OPT_MAIL2 = "郵件屆滿警告";
XML_ALTO_OPT_MAIL3 = "掃描郵件內容 (標記為己讀取)";
XML_ALTO_OPT_MAIL4 = "新郵件通知";
XML_ALTO_OPT_MAIL5 = "當公會成員發送了一封郵件給我的一個角色會發出通知.\n\n"
				.. "郵件內容是直接可見而不必重新登錄該角色";

XML_ALTO_OPT_MINIMAP1 = "移動來改變小地圖圖示的角度";
XML_ALTO_OPT_MINIMAP2 = "小地圖圖示角度";
XML_ALTO_OPT_MINIMAP3 = "移動來改變小地圖圖示的半徑距離";
XML_ALTO_OPT_MINIMAP4 = "小地圖圖示半徑距離";
XML_ALTO_OPT_MINIMAP5 = "顯示小地圖圖示";

XML_ALTO_OPT_TOOLTIP1 = "顯示物品來源";
XML_ALTO_OPT_TOOLTIP2 = "顯示每個角色的物品數量";
XML_ALTO_OPT_TOOLTIP3 = "顯示物品總數量";
XML_ALTO_OPT_TOOLTIP4 = "包括公會金庫";
XML_ALTO_OPT_TOOLTIP5 = "包括已學會/可被學會";
XML_ALTO_OPT_TOOLTIP6 = "顯示物品ID和物品等級ILVL";
XML_ALTO_OPT_TOOLTIP7 = "在採集點上顯示數量";
XML_ALTO_OPT_TOOLTIP8 = "顯示兩方的聲望數值";
XML_ALTO_OPT_TOOLTIP9 = "顯示所有帳戶的數值";
XML_ALTO_OPT_TOOLTIP10 = "總數包括公會金庫計數";

XML_ALTO_OPT_CALENDAR1 = "Week starts on Monday"; 
XML_ALTO_OPT_CALENDAR2 = "Warn %d minutes before an event starts"; 
end
