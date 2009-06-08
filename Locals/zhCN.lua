local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "zhCN" )

if not L then return end

--@localization(locale="zhCN", format="lua_additive_table", handle-unlocalized="ignore", escape-non-ascii=false, same-key-is-true=true)@

L["Location"] = true
L["Left-click to |cFF00FF00open"] = "左键点击|cFF00FF00打开"
L["Right-click to |cFF00FF00drag"] = "右键点击|cFF00FF00拖拽"
L["Enter an account name that will be\nused for |cFF00FF00display|r purposes only."] = "输入一个账户名称\n仅用作 |cFF00FF00显示|r ."
L["This name can be anything you like,\nit does |cFF00FF00NOT|r have to be the real account name."] = "可任意名称,\n并 |cFF00FF00不需要|r 是真实的账户名称."
L["This field |cFF00FF00cannot|r be left empty."] = "这栏 |cFF00FF00不能|r be 留空."

L["Summary"] = "概要"
L["Characters"] = "人物"

L["Account Summary"] = "账号统计"
L["Bag Usage"] = "背包用量"
L["Activity"] = "活跃度"
L["Guild Members"] = "公会成员"
L["Guild Skills"] = "公会技能"
L["Guild Bank Tabs"] = "公会银行标签"
L["Calendar"] = true

L["Account Sharing Request"] = "账户共享请求"
L["Click this button to ask a player\nto share his entire Altoholic Database\nand add it to your own"] = "点击此按钮来询问玩家\n是否共享整个Altoholic数据库\n并将其添加到自己的数据库"
L["Both parties must enable account sharing\nbefore using this feature (see options)"] = "双方都必须启用账户共享\n来使用此功能 (参考选项)"
L["Account Sharing"] = "账户共享"
				
L["Realm"] = "服务器"
L["Character"] = "人物"
L["View"] = "浏览"

L["Item / Location"] = "物品 / 地点"

L["Hide this guild in the tooltip"] = "在提示信息里隐藏这个公会仓库的显示"

L["Not started"] = "未启动"
L["Started"] = "已启动"

L["General"] = "一般"
L["Tooltip"] = "提示"

L["Totals"] = "总计"
L["Search Containers"] = "搜索容器"
L["Equipment Slot"] = "装备位置"
L["Reset"] = "重置"

L["Account Name"] = "账户名称"
L["Send account sharing request to:"] = "发送账户共享请求到:"

--TabOptions.lua

-- ** Frame 1 : General **
L["Max rest XP displayed as 150%"] = "最大奖励经验显示为150%"
L["Show FuBar icon"] = "显示FuBar图标"
L["Show FuBar text"] = "显示FuBar文字"
L["Account Sharing Enabled"] = "启用账号共享"
L["Guild Communication Enabled"] = "启用工会交流"

L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto send you account sharing requests.\n"] = "|cFFFFFFFF当 |cFF00FF00启用|cFFFFFFFF时, 这选项允许其他Altoholic用户\n向你发送帐户共享请求.\n\n"     ---注意, 相较与原lua文件有多出个“\n”
L["Your confirmation will still be required any time someone requests your information.\n\n"] = "任何时候玩家请求你信息都必须得到你的确认.\n\n"      ----新版多的命令
L["When |cFFFF0000disabled|cFFFFFFFF, all requests will be automatically rejected.\n\n"] = "当 |cFFFF0000关闭|cFFFFFFFF时, 所有帐户共享请求会被拒.\n\n"
L["Security hint: Only enable this when you actually need to transfer data,\ndisable otherwise"] = "安全性提示: 只有当您需要实际的数据传输时才启用,\n反之请关闭它"

L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow your guildmates\nto see your alts and their professions.\n\n"] = "|cFFFFFFFF当 |cFF00FF00启用|cFFFFFFFF时, 这选项会让你公会的公会成员\n看见你的小号和其专业技能.\n\n"
L["When |cFFFF0000disabled|cFFFFFFFF, there will be no communication with the guild."] = "当 |cFFFF0000关闭|cFFFFFFFF时, 将不会有任何公会联系."

L["Automatically authorize guild bank updates"] = "自动授权公会仓库更新"

L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto update their guild bank information with yours automatically.\n\n"] = "|cFFFFFFFF当 |cFF00FF00启用|cFFFFFFFF时, 此选项将允许其他Altoholic用户\n与你的公会仓库资料作自动更新.\n\n"
L["When |cFFFF0000disabled|cFFFFFFFF, your confirmation will be\nrequired before sending any information.\n\n"] = "当 |cFFFF0000关闭|cFFFFFFFF时, 发送任何信息\n之前将需要您的确认.\n\n"
L["Security hint: disable this if you have officer rights\non guild bank tabs that may not be viewed by everyone,\nand authorize requests manually"] = "安全提示：如果您有公会管理的权利请关闭\n有查看限制的公会金库分页来防止被任何人观看,\n如需要同步时请用手动授权."
L["Transparency"] = true

-- ** Frame 2 : Search **				
L["AutoQuery server |cFFFF0000(disconnection risk)"] = "自动向服务器查询|cFFFF0000(可能会掉线！)"
L["|cFFFFFFFFIf an item not in the local item cache\nis encountered while searching loot tables,\nAltoholic will attempt to query the server for 5 new items.\n\n"] = "|cFFFFFFFF如果一个不在本地缓存中物品\n被在搜索物品时被搜索到，\nAltoholic将会尝试以5个每次的频率向服务器查询。\n\n"
L["This will gradually improve the consistency of the searches,\nas more items are available in the item cache.\n\n"] = "这将会逐渐的改进搜索的效率，\n因为越来越多的物品将被保存到物品缓存中。\n\n"
L["There is a risk of disconnection if the queried item\nis a loot from a high level dungeon.\n\n"] = "当然，向服务器查询物品时有掉线的风险，\n特别是那些没有被完全推倒的首领！\n\n"
L["|cFF00FF00Disable|r to avoid this risk"] = "|cFF00FF00禁用|r以防止发生这类现象。"

L["Sort loots in descending order"] = "拾取按照逆序排列"
L["Include items without level requirement"] = "包含没有等级要求的物品"
L["Include mailboxes"] = "包括邮箱"
L["Include guild bank(s)"] = "包括公会银行"
L["Include known recipes"] = "包括已知配方"

-- ** Frame 3 : Mail **
L["Warn when mail expires in less days than this value"] = "在邮件过期前多少天进行警告"
L["Mail Expiry Warning"] = "邮件过期警告"
L["Scan mail body (marks it as read)"] = "扫描邮件内容(标记为已读)"
L["New mail notification"] = "新邮件提示"
L["Be informed when a guildmate sends a mail to one of my alts.\n\nMail content is directly visible without having to reconnect the character"] = "通知我如果有工会成员发送邮件给小号.\n\n邮件内容直接可视而不必联系该角色"

-- ** Frame 4 : Minimap **
L["Move to change the angle of the minimap icon"] = "移动迷你地图图标的角度"
L["Minimap Icon Angle"] = "迷你地图图标角度"
L["Move to change the radius of the minimap icon"] = "移动迷你地图图标的半径"
L["Minimap Icon Radius"] = "迷你地图图标半径"
L["Show Minimap Icon"] = "显示迷你地图图标";

-- ** Frame 5 : Tooltip **
L["Show item source"] = "显示物品来源";
L["Show item count per character"] = "显示每个人物的物品数量";
L["Show total item count"] = "显示物品总计数量";
L["Show guild bank count"] = "包括公会银行内的物品";
L["Show already known/learnable by"] = "包括已学习/可学习：";
L["Show item ID and item level"] = "显示物品ID和物品等级";
L["Show counters on gathering nodes"] = "在采集点上显示数量";
L["Show counters for both factions"] = "显示双方的声望数值";
L["Show counters for all accounts"] = "显示所有账户的数值";
L["Include guild bank count in the total count"] = true

-- ** Frame 6 : Calendar **
L["Week starts on Monday"] = true
L["Warn %d minutes before an event starts"] = true
