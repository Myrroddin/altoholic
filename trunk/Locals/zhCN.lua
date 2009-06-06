local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "zhCN" )

if not L then return end

--@localization(locale="zhCN", format="lua_additive_table", handle-unlocalized="ignore", escape-non-ascii=false, same-key-is-true=true)@

if GetLocale() == "zhCN" then
-- Altoholic.xml local
LEFT_HINT = "左键点击|cFF00FF00打开";
RIGHT_HINT = "右键点击|cFF00FF00拖拽";

XML_ALTO_SHARING_HINT1 = "输入一个账户名称\n仅用作 |cFF00FF00显示|r .\n"
				.. "可任意名称,\n并 |cFF00FF00不需要|r 是真实的账户名称.\n\n"
XML_ALTO_SHARING_HINT2 = "这栏 |cFF00FF00不能|r be 留空."

XML_ALTO_TAB1 = "概要"
XML_ALTO_TAB2 = "人物"
XML_ALTO_TAB3 = "搜索"
-- XML_ALTO_TAB4 = GUILD_BANK
XML_ALTO_TABOPTIONS = "选项"

XML_ALTO_SUMMARY_MENU1 = "账号统计"
XML_ALTO_SUMMARY_MENU2 = "背包用量"
-- XML_ALTO_SUMMARY_MENU3 = SKILLS
XML_ALTO_SUMMARY_MENU4 = "活跃度"
XML_ALTO_SUMMARY_MENU5 = "公会成员"
XML_ALTO_SUMMARY_MENU6 = "公会技能"
XML_ALTO_SUMMARY_MENU7 = "公会银行标签"
XML_ALTO_SUMMARY_MENU8 = "Calendar"

XML_ALTO_SUMMARY_TEXT1 = "账户共享请求"
XML_ALTO_SUMMARY_TEXT2 = "点击此按钮来询问玩家\n"
				.. "是否共享整个Altoholic数据库\n"
				.. "并将其添加到自己的数据库"
XML_ALTO_SUMMARY_TEXT3 = "双方都必须启用账户共享\n来使用此功能 (参考选项)"
XML_ALTO_SUMMARY_TEXT4 = "账户共享"

XML_ALTO_CHAR_DD1 = "服务器"
XML_ALTO_CHAR_DD2 = "人物"
XML_ALTO_CHAR_DD3 = "浏览"

XML_ALTO_SEARCH_COL1 = "物品 / 地点"

XML_ALTO_GUILD_TEXT1 = "在提示信息里隐藏这个公会仓库的显示"

XML_ALTO_ACH_NOTSTARTED = "未启动"
XML_ALTO_ACH_STARTED = "已启动"

XML_ALTO_OPT_MENU1 = "一般"
XML_ALTO_OPT_MENU2 = "搜索"
XML_ALTO_OPT_MENU3 = "邮件"
XML_ALTO_OPT_MENU4 = "小地图"
XML_ALTO_OPT_MENU5 = "提示"

XML_TEXT_1 = "总计";
XML_TEXT_2 = "搜索容器";
XML_TEXT_3 = "等级范围";
XML_TEXT_4 = "稀有度";
XML_TEXT_5 = "装备位置";
XML_TEXT_6 = "重置";
XML_TEXT_7 = "搜索";

XML_ALTO_TEXT10 = "账户名称"

XML_ALTO_TEXT11 = "发送账户共享请求到:"

--Options.xml
XML_ALTO_OPT_GENERAL1 = "最大奖励经验显示为150%";
XML_ALTO_OPT_GENERAL2 = "显示FuBar图标";
XML_ALTO_OPT_GENERAL3 = "显示FuBar文字";
XML_ALTO_OPT_GENERAL4 = "启用账号共享";
XML_ALTO_OPT_GENERAL5 = "启用工会交流";
XML_ALTO_OPT_GENERAL6 = "|cFFFFFFFF当 |cFF00FF00启用|cFFFFFFFF时, 这选项允许其他Altoholic用户\n"
				.. "向你发送帐户共享请求.\n\n"     ---注意, 相较与原lua文件有多出个“\n”
				.. "任何时候玩家请求你信息都必须得到你的确认.\n\n"      ----新版多的命令
				.. "当 |cFFFF0000关闭|cFFFFFFFF时, 所有帐户共享请求会被拒.\n\n"
				.. "安全性提示: 只有当您需要实际的数据传输时才启用,\n反之请关闭它"
XML_ALTO_OPT_GENERAL7 = "|cFFFFFFFF当 |cFF00FF00启用|cFFFFFFFF时, 这选项会让你公会的公会成员\n"
				.. "看见你的小号和其专业技能.\n\n"
				.. "当 |cFFFF0000关闭|cFFFFFFFF时, 将不会有任何公会联系."
XML_ALTO_OPT_GENERAL8 = "自动授权公会仓库更新"
XML_ALTO_OPT_GENERAL9 = "|cFFFFFFFF当 |cFF00FF00启用|cFFFFFFFF时, 此选项将允许其他Altoholic用户\n"
				.. "与你的公会仓库资料作自动更新.\n\n"
				.. "当 |cFFFF0000关闭|cFFFFFFFF时, 发送任何信息\n"
				.. "之前将需要您的确认.\n\n"
				.. "安全提示：如果您有公会管理的权利请关闭\n"
				.. "有查看限制的公会金库分页来防止被任何人观看,\n"
				.. "如需要同步时请用手动授权."
XML_ALTO_OPT_GENERAL10 = "Transparency"

XML_ALTO_OPT_SEARCH1 = "自动向服务器查询|cFFFF0000(可能会掉线！)";
XML_ALTO_OPT_SEARCH2 = "|cFFFFFFFF如果一个不在本地缓存中物品\n"
				.. "被在搜索物品时被搜索到，\n"
				.. "Altoholic将会尝试以5个每次的频率向服务器查询。\n\n"
				.. "这将会逐渐的改进搜索的效率，\n"
				.. "因为越来越多的物品将被保存到物品缓存中。\n\n"
				.. "当然，向服务器查询物品时有掉线的风险，\n"
				.. "特别是那些没有被完全推倒的首领！\n\n"
				.. "|cFF00FF00禁用|r以防止发生这类现象。";
XML_ALTO_OPT_SEARCH3 = "拾取按照逆序排列";
XML_ALTO_OPT_SEARCH4 = "包含没有等级要求的物品";
XML_ALTO_OPT_SEARCH5 = "包括邮箱";
XML_ALTO_OPT_SEARCH6 = "包括公会银行";
XML_ALTO_OPT_SEARCH7 = "包括已知配方";

XML_ALTO_OPT_MAIL1 = "在邮件过期前多少天进行警告";
XML_ALTO_OPT_MAIL2 = "邮件过期警告";
XML_ALTO_OPT_MAIL3 = "扫描邮件内容(标记为已读)";
XML_ALTO_OPT_MAIL4 = "新邮件提示";
XML_ALTO_OPT_MAIL5 = "通知我如果有工会成员发送邮件给小号.\n\n"
				.. "邮件内容直接可视而不必联系该角色";

XML_ALTO_OPT_MINIMAP1 = "移动迷你地图图标的角度";
XML_ALTO_OPT_MINIMAP2 = "迷你地图图标角度";
XML_ALTO_OPT_MINIMAP3 = "移动迷你地图图标的半径";
XML_ALTO_OPT_MINIMAP4 = "迷你地图图标半径";
XML_ALTO_OPT_MINIMAP5 = "显示迷你地图图标";

XML_ALTO_OPT_TOOLTIP1 = "显示物品来源";
XML_ALTO_OPT_TOOLTIP2 = "显示每个人物的物品数量";
XML_ALTO_OPT_TOOLTIP3 = "显示物品总计数量";
XML_ALTO_OPT_TOOLTIP4 = "包括公会银行内的物品";
XML_ALTO_OPT_TOOLTIP5 = "包括已学习/可学习：";
XML_ALTO_OPT_TOOLTIP6 = "显示物品ID和物品等级";
XML_ALTO_OPT_TOOLTIP7 = "在采集点上显示数量";
XML_ALTO_OPT_TOOLTIP8 = "显示双方的声望数值";
XML_ALTO_OPT_TOOLTIP9 = "显示所有账户的数值";
XML_ALTO_OPT_TOOLTIP10 = "Include guild bank count in the total count";

XML_ALTO_OPT_CALENDAR1 = "Week starts on Monday"; 
XML_ALTO_OPT_CALENDAR2 = "Warn %d minutes before an event starts"; 
end
