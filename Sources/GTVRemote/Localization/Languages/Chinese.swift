import Foundation

public struct ChineseStrings: LocalizableStrings {
    public init() {}

    // Connection Status
    public let connecting = "连接中..."
    public let discovering = "搜索设备中..."
    public let pairingRequired = "需要配对"
    public let disconnected = "未连接"
    public let connectionError = "连接错误"
    public let online = "在线"
    public let selectTVPrompt = "请选择设备"

    // Header & Menus
    public let selectDeviceTooltip = "点击选择设备与管理连接"
    public let shortcutsTooltip = "查看键盘快捷键"
    public let languageTooltip = "切换语言"
    public let deviceList = "设备列表"
    public let searching = "搜索中..."
    public let rescanDevices = "重新搜索设备"
    public let disconnect = "断开连接"
    public let quitApp = "退出 GTV Remote"

    // Remote Control Buttons
    public let powerTooltip = "电源 (P)"
    public let playPauseTooltip = "播放/暂停 (Space)"
    public let backTooltip = "返回 (Esc)"
    public let homeTooltip = "主页 (H)"
    public let volumeDownTooltip = "降低音量 (-)"
    public let volumeUpTooltip = "提高音量 (+)"
    public let dpadSelectTooltip = "选择 (Enter)"
    public let dpadUpTooltip = "向上 (↑)"
    public let dpadDownTooltip = "向下 (↓)"
    public let dpadLeftTooltip = "向左 (←)"
    public let dpadRightTooltip = "向右 (→)"
    public let assistantTooltip = "Google 助理 (A)"
    public let muteTooltip = "静音 (M)"
    public let inputTooltip = "输入源 (I)"

    // Smart Input Bar
    public let inputPlaceholder = "输入文字发送至电视..."
    public let send = "发送"

    // Quick Apps
    public let quickApps = "快捷应用"
    public let quickAppsSettingsTooltip = "快捷应用设置"
    public let noAppsSelected = "请在设置中选择应用"

    // Quick Apps Settings Sheet
    public let settingsTitle = "快捷应用设置"
    public let done = "完成"
    public func listVisibleCount(visible: Int, total: Int) -> String {
        "列表 (\(visible)/\(total) 显示中)"
    }
    public let dragToReorder = "拖拽调整顺序"
    public let addCustomApp = "添加自定义应用"
    public let collapse = "收起"
    public let appNamePlaceholder = "应用名称 (例如: Bilibili)"
    public let uriPlaceholder = "深度链接 URI (例如: https://...)"
    public let add = "添加"
    public let editAppShortcut = "编辑应用快捷方式"
    public let appName = "应用名称"
    public let deepLinkURI = "深度链接 URI"
    public let cancel = "取消"
    public let save = "保存"
    public let edit = "编辑"
    public let delete = "删除"

    // Pairing Sheet
    public let pairingTitle = "与 Google TV 配对"
    public let pairingPrompt = "请输入电视屏幕上显示的 6 位验证码。"
    public let pairingFailed = "配对失败，请检查验证码后重试。"
    public let pair = "配对"

    // Keyboard Shortcuts Sheet
    public let shortcutsTitle = "键盘快捷键指南"
    public let shortcutsDesc = "遥控器窗口激活时可直接使用以下快捷键。"
    public let groupNav = "导航与选择"
    public let groupMedia = "媒体与音频"
    public let groupSystem = "系统与应用"

    public let keyArrow = "方向键 (↑ ↓ ← →)"
    public let descArrow = "方向键导航"
    public let keyEnter = "Enter"
    public let descEnter = "确认选择 (OK)"
    public let keyEsc = "Esc"
    public let descEsc = "返回"
    public let keyH = "H"
    public let descH = "回到主屏幕"
    public let keySpace = "空格"
    public let descSpace = "播放 / 暂停"
    public let keyVolume = "+  /  -"
    public let descVolume = "音量增加 / 减小"
    public let keyM = "M"
    public let descM = "静音切换"
    public let keyP = "P"
    public let descP = "电源开关"
    public let keyA = "A"
    public let descA = "调出 Google 助理"
    public let keyI = "I"
    public let descI = "切换输入源"
    public let keyNumbers = "1 ~ 9"
    public let descNumbers = "直接启动快捷应用 1-9"
}
