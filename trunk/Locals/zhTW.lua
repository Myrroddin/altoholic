--zhTW locale file by 天明@眾星之子
local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "zhTW" )
if not L then return end

--@localization(locale="zhTW", format="lua_additive_table", handle-unlocalized="ignore", escape-non-ascii=false, same-key-is-true=true)@

L["Location"] = true
L["Left-click to |cFF00FF00open"] = "左鍵 |cFF00FF00開啟";
L["Right-click to |cFF00FF00drag"] = "右鍵 |cFF00FF00拖曳";
L["Enter an account name that will be\nused for |cFF00FF00display|r purposes only."] = "輸入帳戶名稱\n用作|cFF00FF00識別而已|r ."
L["This name can be anything you like,\nit does |cFF00FF00NOT|r have to be the real account name."] = "這個名稱可以隨你歡喜,\n並 |cFF00FF00不需要|r 是真實的帳戶名稱."
L["This field |cFF00FF00cannot|r be left empty."] = "這欄 |cFF00FF00不能|r 留空."

L["Summary"] = "摘要"
L["Characters"] = "角色"

L["Account Summary"] = "帳戶摘要"
L["Bag Usage"] = "背包使用度"
L["Activity"] = "活躍度"
L["Guild Members"] = "公會成員"
L["Guild Skills"] = "公會技能"
L["Guild Bank Tabs"] = "公會金庫分頁"
L["Calendar"] = true

L["Account Sharing Request"] = "要求帳戶共享資料"
L["Click this button to ask a player\nto share his entire Altoholic Database\nand add it to your own"] = "按一下這個按鈕來詢問玩家\n要求分享Altoholic的數據庫\n並將其添加到您自己數據庫內"
L["Both parties must enable account sharing\nbefore using this feature (see options)"] = "雙方都必須啟用帳戶共享\n來使用此功能 (請參考選項)"
L["Account Sharing"] = "帳戶共享"
				
L["Realm"] = "伺服器"
L["Character"] = "角色"
L["View"] = "顯示"

L["Item / Location"] = "物品 / 地點"

L["Hide this guild in the tooltip"] = "在提示框隱藏這公會金庫的顯示"

L["Not started"] = "尚未啟動"
L["Started"] = "已啟動"

L["General"] = "一般"
L["Tooltip"] = "提示"

L["Totals"] = "總數";
L["Search Containers"] = "搜索容器";
L["Equipment Slot"] = "設備格";
L["Reset"] = "重置";

L["Account Name"] = "帳戶名稱"
L["Send account sharing request to:"] = "發送帳戶共享資料的要求:"

--TabOptions.lua

-- ** Frame 1 : General **
L["Max rest XP displayed as 150%"] = "充份休息經驗值以150%來顯示"
L["Show FuBar icon"] = "顯示圖示";
L["Show FuBar text"] = "顯示文字";
L["Account Sharing Enabled"] = "啟用帳戶共享";
L["Guild Communication Enabled"] = "啟用公會聯系";

L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto send you account sharing requests.\n"] = "|cFFFFFFFF當 |cFF00FF00啟用|cFFFFFFFF時, 這選項會讓共它Altoholic用家\n"
L["Your confirmation will still be required any time someone requests your information.\n\n"] = "可向你發送帳戶資料要求.\n\n"
L["When |cFFFF0000disabled|cFFFFFFFF, all requests will be automatically rejected.\n\n"] = "當 |cFFFF0000關閉|cFFFFFFFF時, 所有帳戶資料要求會被拒.\n\n"
L["Security hint: Only enable this when you actually need to transfer data,\ndisable otherwise"] = "安全性提示: 只有當您需要實際的數據傳輸時才啟用,\n反之請關閉它"

L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow your guildmates\nto see your alts and their professions.\n\n"] = "|cFFFFFFFF當 |cFF00FF00啟用|cFFFFFFFF時, 這選項會讓你公會的會友\n看見你的分身和其專業技能.\n\n"
L["When |cFFFF0000disabled|cFFFFFFFF, there will be no communication with the guild."] = "當 |cFFFF0000關閉|cFFFFFFFF時, 將不會有任何公會聯系."

L["Automatically authorize guild bank updates"] = "自動授權公會金庫更新"

L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto update their guild bank information with yours automatically.\n\n"] = "|cFFFFFFFF當 |cFF00FF00啟用|cFFFFFFFF時, 此選項將允許其他Altoholic用戶\n與你的公會金庫資料作自動更新.\n\n"
L["When |cFFFF0000disabled|cFFFFFFFF, your confirmation will be\nrequired before sending any information.\n\n"] = "當 |cFFFF0000關閉|cFFFFFFFF時, 發送任何信息\n之前將需要您的確認.\n\n"
L["Security hint: disable this if you have officer rights\non guild bank tabs that may not be viewed by everyone,\nand authorize requests manually"] = "安全提示：如果您有公會理事的權利請關閉\n有查看限制的公會金庫分頁來防止被任何人觀看,\n如需要同步時請用手動受權."
L["Transparency"] = true

-- ** Frame 2 : Search **
L["AutoQuery server |cFFFF0000(disconnection risk)"] = "自動向伺服器查詢 |cFFFF0000(有可能導至斷線)";
L["|cFFFFFFFFIf an item not in the local item cache\nis encountered while searching loot tables,\nAltoholic will attempt to query the server for 5 new items.\n\n"] = "|cFFFFFFFF當物品不在本機的內存時\n當在搜索表裡找到,\nAltoholic 將試圖查詢服務器下5個新項目.\n\n"
L["This will gradually improve the consistency of the searches,\nas more items are available in the item cache.\n\n"] = "這將逐步完善的一致性搜查,\n隨著越來越多的項目都可以在本機的內存時.\n\n"
L["There is a risk of disconnection if the queried item\nis a loot from a high level dungeon.\n\n"] = "如查詢的物品是一件非常高級的副本掉落\n極有可能導至斷線.\n\n"
L["|cFF00FF00Disable|r to avoid this risk"] = "|cFF00FF00關閉|r 這選項可避免這種情況發生";

L["Sort loots in descending order"] = "戰利品排序";
L["Include items without level requirement"] = "包括沒等級要求的物品";
L["Include mailboxes"] = "包括郵箱";
L["Include guild bank(s)"] = "包括公會金庫";
L["Include known recipes"] = "包括已學的配方";

-- ** Frame 3 : Mail **
L["Warn when mail expires in less days than this value"] = "當郵件屆滿少過此值的日數時發出警告";
L["Mail Expiry Warning"] = "郵件屆滿警告";
L["Scan mail body (marks it as read)"] = "掃描郵件內容 (標記為己讀取)";
L["New mail notification"] = "新郵件通知";
L["Be informed when a guildmate sends a mail to one of my alts.\n\nMail content is directly visible without having to reconnect the character"] = "當公會成員發送了一封郵件給我的一個角色會發出通知.\n\n郵件內容是直接可見而不必重新登錄該角色";

-- ** Frame 4 : Minimap **
L["Move to change the angle of the minimap icon"] = "移動來改變小地圖圖示的角度";
L["Minimap Icon Angle"] = "小地圖圖示角度";
L["Move to change the radius of the minimap icon"] = "移動來改變小地圖圖示的半徑距離";
L["Minimap Icon Radius"] = "小地圖圖示半徑距離";
L["Show Minimap Icon"] = "顯示小地圖圖示";

-- ** Frame 5 : Tooltip **
L["Show item source"] = "顯示物品來源";
L["Show item count per character"] = "顯示每個角色的物品數量";
L["Show total item count"] = "顯示物品總數量";
L["Show guild bank count"] = "包括公會金庫";
L["Show already known/learnable by"] = "包括已學會/可被學會";
L["Show item ID and item level"] = "顯示物品ID和物品等級ILVL";
L["Show counters on gathering nodes"] = "在採集點上顯示數量";
L["Show counters for both factions"] = "顯示兩方的聲望數值";
L["Show counters for all accounts"] = "顯示所有帳戶的數值";
L["Include guild bank count in the total count"] = "總數包括公會金庫計數";

-- ** Frame 6 : Calendar **
L["Week starts on Monday"] = true
L["Warn %d minutes before an event starts"] = true
