import Foundation

public struct JapaneseStrings: LocalizableStrings {
    public init() {}

    // Connection Status
    public let connecting = "接続中..."
    public let discovering = "デバイスを検索中..."
    public let pairingRequired = "ペアリングが必要"
    public let disconnected = "未接続"
    public let connectionError = "接続エラー"
    public let online = "オンライン"
    public let selectTVPrompt = "デバイスを選択"

    // Header & Menus
    public let selectDeviceTooltip = "クリックしてTVを選択・接続管理"
    public let shortcutsTooltip = "キーボードショートカットを表示"
    public let languageTooltip = "言語を変更"
    public let deviceList = "検出されたデバイス"
    public let searching = "検索中..."
    public let rescanDevices = "デバイスを再検索"
    public let disconnect = "接続解除"
    public let quitApp = "GTV Remoteを終了"

    // Remote Control Buttons
    public let powerTooltip = "電源 (P)"
    public let playPauseTooltip = "再生/一時停止 (Space)"
    public let backTooltip = "戻る (Esc)"
    public let homeTooltip = "ホーム (H)"
    public let volumeDownTooltip = "音量ダウン (-)"
    public let volumeUpTooltip = "音量アップ (+)"
    public let dpadSelectTooltip = "選択 (Enter)"
    public let dpadUpTooltip = "上 (↑)"
    public let dpadDownTooltip = "下 (↓)"
    public let dpadLeftTooltip = "左 (←)"
    public let dpadRightTooltip = "右 (→)"
    public let assistantTooltip = "Google アシスタント (A)"
    public let muteTooltip = "消音 (M)"
    public let inputTooltip = "入力切替 (I)"

    // Smart Input Bar
    public let inputPlaceholder = "テレビにテキストを入力して送信..."
    public let send = "送信"

    // Quick Apps
    public let quickApps = "クイックアプリ"
    public let quickAppsSettingsTooltip = "クイックアプリ設定"
    public let noAppsSelected = "設定でアプリを選択してください"

    // Quick Apps Settings Sheet
    public let settingsTitle = "クイックアプリ設定"
    public let done = "完了"
    public func listVisibleCount(visible: Int, total: Int) -> String {
        "一覧 (\(visible)/\(total)件 表示中)"
    }
    public let dragToReorder = "ドラッグして並べ替え"
    public let addCustomApp = "カスタムアプリを追加"
    public let collapse = "閉じる"
    public let appNamePlaceholder = "アプリ名 (例: TVer)"
    public let uriPlaceholder = "ディープリンク URI (例: https://...)"
    public let add = "追加"
    public let editAppShortcut = "アプリショートカットを編集"
    public let appName = "アプリ名"
    public let deepLinkURI = "ディープリンク URI"
    public let cancel = "キャンセル"
    public let save = "保存"
    public let edit = "編集"
    public let delete = "削除"

    // Pairing Sheet
    public let pairingTitle = "Google TVとペアリング"
    public let pairingPrompt = "テレビ画面に表示されている6文字のコードを入力してください。"
    public let pairingFailed = "ペアリングに失敗しました。コードを確認して再試行してください。"
    public let pair = "ペアリング"

    // Keyboard Shortcuts Sheet
    public let shortcutsTitle = "キーボードショートカット一覧"
    public let shortcutsDesc = "リモコンウィンドウがアクティブな時に以下のキーで直接操作できます。"
    public let groupNav = "ナビゲーション & 決定"
    public let groupMedia = "メディア & サウンド"
    public let groupSystem = "システム & アプリ"

    public let keyArrow = "矢印キー (↑ ↓ ← →)"
    public let descArrow = "D-Pad 上下左右移動"
    public let keyEnter = "Enter"
    public let descEnter = "決定 (OK)"
    public let keyEsc = "Esc"
    public let descEsc = "戻る"
    public let keyH = "H"
    public let descH = "ホーム画面に移動"
    public let keySpace = "Space"
    public let descSpace = "再生 / 一時停止"
    public let keyVolume = "+  /  -"
    public let descVolume = "音量アップ / ダウン"
    public let keyM = "M"
    public let descM = "消音切り替え"
    public let keyP = "P"
    public let descP = "電源オン / オフ"
    public let keyA = "A"
    public let descA = "Google アシスタントを起動"
    public let keyI = "I"
    public let descI = "入力切替"
    public let keyNumbers = "1 ~ 9"
    public let descNumbers = "クイックアプリ 1〜9を即時起動"
}
