# GTV Remote

<p align="center">
  <img src="../assets/app_icon.png" alt="GTV Remote Icon" width="128" height="128" />
</p>

<p align="center">
  <strong>Google TV / Android TV 向けのモダンなネイティブ macOS リモコン & クイックランチャー</strong><br>
  <em>低遅延の双方向 TLS 制御、mDNS 自動検出、テキスト即時入力、クイックアプリ起動、キーボードショートカットを Mac からそのまま利用できます。</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/macOS-14.0%2B-black?style=flat-square&logo=apple" alt="macOS 14+" />
  <img src="https://img.shields.io/badge/Swift-6.0%2B-orange?style=flat-square&logo=swift" alt="Swift 6.0+" />
  <img src="https://img.shields.io/badge/Architecture-Apple%20Silicon%20%7C%20Intel-blue?style=flat-square" alt="Apple Silicon & Intel" />
  <img src="https://img.shields.io/badge/100%25-Built%20with%20Antigravity-blue?style=flat-square" alt="100% Built with Antigravity" />
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square" alt="MIT License" />
</p>

<p align="center">
  <a href="../README.md">English</a> ·
  <a href="README.ko.md">한국어</a> ·
  <a href="README.zh-Hans.md">简体中文</a> ·
  <strong>日本語</strong> ·
  <a href="README.de.md">Deutsch</a> ·
  <a href="README.fr.md">Français</a> ·
  <a href="README.es.md">Español</a>
</p>

---

> [!NOTE]
> **🤖 100% Google Antigravity 製**
>
> TLS ソケット通信、Protobuf パケットシリアライズ、mDNS 自動検出、SwiftUI ビュー、キーボードイベント監視、ドラッグ＆ドロップでのクイックアプリ並び替え、7言語ローカライズ、ビルド自動化に至るまで、このアプリケーション全体は **Google Antigravity との自律的なペアプログラミングによって 100% 設計・実装・検証**されました。

---

## スクリーンショット

<p align="center">
  <img src="../assets/remote_main.png" alt="GTV Remote メインウィンドウ" height="460" />
  <img src="../assets/quick_apps_settings.png" alt="クイックアプリ設定" height="460" />
  <img src="../assets/keyboard_shortcuts.png" alt="キーボードショートカット" height="460" />
  <br>
  <em>GTV Remote：ネイティブ macOS フロストガラス UI、クイックアプリ管理 & キーボードショートカット一覧</em>
</p>

---

## 主な機能

- **ネイティブ macOS エクスペリエンス**:
  - 100% Swift、SwiftUI、AppKit で構築され、ネイティブの `.sidebar` フロストガラスマテリアル（`NSVisualEffectView`）を採用しています。
  - macOS メニューバーに 45 度傾いた専用リモコンアイコンを配置し、ワンクリックでウィンドウを開いたりフォーカスを切り替えたりできます。
  - ウィンドウを閉じてもバックグラウンドに常駐するため、Dock やメニューバーからプロセスを再起動することなく瞬時に再表示できます。

- **ゼロ設定ネットワーク検出 & 即時再接続**:
  - 設定不要の Bonjour / mDNS（`_androidtvremote2._tcp`）により、ローカルネットワーク上の Google TV および Android TV デバイスを自動検出します。
  - DHCP によって TV の IP アドレスが変更されても、リアルタイムに追跡して自動同期します。
  - 再接続リトライ回数に上限を設け、接続中状態が無限ループするのを防ぎます。
  - Unicode や多言語を含むデバイス名も正確に解決・表示します。
  - 最後に接続した TV を記憶し、起動時にすぐ再接続します。

- **高速・安全な TLS 接続**:
  - Android TV Remote v2 プロトコル準拠の双方向相互 TLS 暗号化通信。
  - Apple の `Security.framework` を直接利用し、一時的な RSA-2048 クライアント証明書をアプリ内で生成します（外部 `openssl` バイナリ不要）。

- **キーボード操作 & 視覚的フィードバック**:
  - 矢印キー、`Enter`、`Esc`、`Home`、`Space`、音量キーで TV メニューを快適に操作できます。
  - キーボード操作に連動して画面上のボタンが **0.15 秒間ハイライト表示されるリアルタイムフィードバック** を備えています。

- **スマートテキスト入力 & クリップボード同期**:
  - 統合されたスマート入力バーから、検索キーワードや URL、パスワードを TV へ直接入力できます。
  - ワンクリックまたは `Cmd + V` で Mac のクリップボード内容を TV の入力欄へ即座に送信します。

- **カスタマイズ可能なクイックアプリランチャー**:
  - 主要ストリーミングサービスのプリセットを標準搭載：**YouTube、Netflix、Disney+、Apple TV、Prime Video、Coupang Play、Max、Paramount+、YouTube TV、Tubi、Pluto TV、Google Play Store、Surfshark、Plex、Spotify、Twitch、Stremio**。
  - **ドラッグ＆ドロップによる並び替え**と表示チェックボックスを備えた統合アプリ管理画面。
  - カスタムディープリンク（`https://` または `app://`）の追加・編集・削除に対応。
  - ボタンサイズを一定に保つ 3 列固定グリッド。
  - 数字キー（`1` 〜 `9`）で上位のクイックアプリをダイレクト起動できます。

- **7 言語マルチローカライズ対応**:
  - **English**、**한국어**、**简体中文**、**日本語**、**Deutsch**、**Français**、**Español** に対応。
  - 初回起動時に macOS のシステム言語設定を自動認識します。
  - ヘッダーの地球アイコンからいつでも即座に UI 言語を切り替えられます。

---

## キーボードショートカット一覧

リモコンウィンドウがアクティブな状態で、以下のショートカットキーを使用できます：

| キー | リモコン機能 | 説明 |
| :--- | :--- | :--- |
| **矢印キー (↑ ↓ ← →)** | `DPAD_UP / DOWN / LEFT / RIGHT` | D-Pad 上下左右移動 |
| **Return / Enter** | `DPAD_CENTER` | 決定 (OK) |
| **Esc / Backspace** | `BACK` | 戻る / メニューを閉じる |
| **H** | `HOME` | TV ホーム画面に移動 |
| **Space** | `MEDIA_PLAY_PAUSE` | 再生 / 一時停止 |
| **+ / =** | `VOLUME_UP` | 音量アップ |
| **- / _** | `VOLUME_DOWN` | 音量ダウン |
| **M** | `VOLUME_MUTE` | 消音切り替え |
| **P** | `POWER` | 電源オン / オフ |
| **A** | `ASSISTANT` | Google アシスタントを起動 |
| **I** | `INPUT` | 外部入力を切り替え |
| **1 ~ 9** | クイックアプリ 1–9 | クイックアプリ 1〜9 を即時起動 |
| **Cmd + V** | クリップボード同期 | Mac のクリップボードテキストを TV へ送信 |
| **Cmd + W** | ウィンドウを隠す | リモコンウィンドウを隠す（バックグラウンド待機） |

---

## インストール方法

### 方法 1: リリース版をダウンロード（推奨）

1. [GitHub Releases](https://github.com/badugisoft/gtv-remote/releases/latest) から最新の `GTV-Remote-v*.dmg` または `GTV-Remote-v*.zip` をダウンロードします。
2. `.dmg` を開く（または `.zip` を展開する）と表示される **GTV Remote.app** を `/Applications`（アプリケーション）フォルダへドラッグします。
3. `/Applications` から **GTV Remote** を起動します。

#### macOS の「開発元を検証できない」/ 証明書警告を解除する方法（Gatekeeper）

**GTV Remote** は有料の Apple Developer ID 証明書ではなくアドホック署名で配布されているため、初回起動時に macOS の警告（*「Appleは“GTV Remote.app”に悪意のあるソフトウェアが含まれていないことを確認できませんでした」* または *「開発元を検証できないため開けません」*）が表示される場合があります。

**方法 A — システム設定から許可する（GUI）:**

1. まず **GTV Remote.app** を一度開き、警告ダイアログで **完了**（または **キャンセル**）をクリックします。
2. **システム設定** → **プライバシーとセキュリティ** を開きます。
3. 下部の **セキュリティ** セクションまでスクロールし、`“GTV Remote.app”は〜ブロックされました` というメッセージの横にある **このまま開く** をクリックします。
4. 確認ダイアログで **このまま開く**（または **開く**）をクリックし、Mac のパスワードまたは Touch ID で認証します。

**方法 B — ターミナルから検疫属性を削除する:**

```bash
xattr -cr "/Applications/GTV Remote.app"
```

---

### 方法 2: ソースコードからビルド（Makefile 使用）

#### 動作環境・前提条件
- macOS 14.0 (Sonoma) 以降
- Xcode 16+ または Swift 6.0+ Command Line Tools

#### ビルドおよびインストール

リポジトリをクローンして以下を実行します：

```bash
# Release ビルドを作成し、/Applications/GTV Remote.app にパッケージングして起動
make install

# dist/ 内に .app、.dmg、.zip パッケージを生成
make package
```

ビルド成果物を削除する場合：
```bash
make clean
```

アンインストールする場合：
```bash
make uninstall
```

---

## プロジェクト構成

```
gtv-remote/
├── .github/workflows/release.yml     # CI/CD 自動リリースワークフロー
├── AGENTS.md                         # AI エージェント & 開発者向けガイドライン
├── Makefile                          # リリースパッケージング & 配置スクリプト
├── Package.swift                     # Swift Package Manager マニフェスト
├── LICENSE                           # MIT ライセンス
├── README.md                         # 英語ドキュメント（ベース）
├── Resources/
│   ├── AppIcon.icns                  # macOS アプリアイコン
│   └── Info.plist                    # バンドル構成および権限設定
├── Sources/
│   └── GTVRemote/
│       ├── App/                      # アプリエントリー & キーボード監視
│       │   ├── GTVRemote.swift
│       │   └── KeyboardMonitor.swift
│       ├── Core/
│       │   ├── Network/              # mDNS 検出 & NIO TLS ソケットブリッジ
│       │   │   ├── BonjourResolver.swift
│       │   │   ├── DeviceDiscoveryService.swift
│       │   │   ├── TLSSocketBridge.swift
│       │   │   └── TVConnectionManager.swift
│       │   ├── Proto/                # Protobuf プロトコルバインディング
│       │   │   ├── pairing.pb.swift
│       │   │   └── remote.pb.swift
│       │   └── Security/             # RSA-2048 証明書生成
│       │       └── CertificateManager.swift
│       ├── Localization/             # 7 言語ローカライズエンジン
│       │   ├── Languages/            # 各言語の文字列定義
│       │   ├── L10n.swift
│       │   ├── LocalizableStrings.swift # ローカライズキー定義プロトコル
│       │   └── LocalizationManager.swift
│       ├── Models/                   # データモデル & アプリショートカット一覧
│       │   ├── AppShortcut.swift
│       │   ├── Models.swift
│       │   └── RemoteKey.swift
│       ├── ViewModels/               # Observable リモコンビジネスロジック
│       │   └── RemoteViewModel.swift
│       └── Views/                    # SwiftUI 画面 & シート
│           ├── Components/
│           │   ├── DPadView.swift
│           │   ├── RemoteButtonStyles.swift
│           │   └── SmartInputBar.swift
│           ├── Sheets/
│           │   ├── AppShortcutsSettingsView.swift
│           │   ├── PairingSheetView.swift
│           │   └── ShortcutsView.swift
│           └── RemoteControlView.swift
├── assets/                           # スクリーンショット & ドキュメント用画像
│   ├── app_icon.png
│   ├── keyboard_shortcuts.png
│   ├── quick_apps_settings.png
│   └── remote_main.png
└── docs/                             # 各言語ドキュメント
    ├── README.de.md                  # Deutsch
    ├── README.es.md                  # Español
    ├── README.fr.md                  # Français
    ├── README.ja.md                  # 日本語
    ├── README.ko.md                  # 한국어
    └── README.zh-Hans.md             # 简体中文
```

---

## オープンソースライセンス

本プロジェクトは **MIT ライセンス** の下で公開されています。詳細は [LICENSE](../LICENSE) ファイルをご覧ください。
