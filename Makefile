APP_NAME    = GTV Remote
BIN_NAME    = GTVRemote
BIN_PATH    = $(shell swift build -c release --show-bin-path 2>/dev/null || echo .build/arm64-apple-macosx/release)
APP_BUNDLE  = /Applications/$(APP_NAME).app
DIST_DIR    = dist
DIST_BUNDLE = $(DIST_DIR)/$(APP_NAME).app
RESOURCES   = Resources

.PHONY: all build build-debug run dev install uninstall package clean

## 기본 타겟: release 빌드 후 설치
all: install

# ── 빌드 ────────────────────────────────────────────────────────────────────

## Release 빌드
build:
	swift build -c release

## Debug 빌드
build-debug:
	swift build

# ── 실행 ────────────────────────────────────────────────────────────────────

## Debug 빌드 후 바로 실행 (로그 터미널 출력)
run: build-debug
	@echo "▶  $(DEBUG_DIR)/$(BIN_NAME) 실행 중..."
	"$(DEBUG_DIR)/$(BIN_NAME)"

## run 의 별칭 (편의용)
dev: run

# ── 설치 ────────────────────────────────────────────────────────────────────

## Release 빌드 → /Applications 에 앱 번들 설치 후 실행
install: build
	@echo "⏹️  기존 실행 중인 앱 종료..."
	@pkill -f "GTV Remote" 2>/dev/null || true
	@pkill -f "GTVRemote" 2>/dev/null || true
	@sleep 0.3

	@echo "📦 앱 번들 생성 중..."
	@rm -rf "/Applications/GTVRemote.app" 2>/dev/null || true
	@mkdir -p "$(APP_BUNDLE)/Contents/MacOS"
	@mkdir -p "$(APP_BUNDLE)/Contents/Resources"

	@echo "🔧 실행파일 복사..."
	@cp "$(BIN_PATH)/$(BIN_NAME)" "$(APP_BUNDLE)/Contents/MacOS/$(APP_NAME)"
	@chmod +x "$(APP_BUNDLE)/Contents/MacOS/$(APP_NAME)"

	@echo "🎨 아이콘 복사..."
	@cp "$(RESOURCES)/AppIcon.icns" "$(APP_BUNDLE)/Contents/Resources/AppIcon.icns"

	@echo "📄 Info.plist 복사..."
	@cp "$(RESOURCES)/Info.plist" "$(APP_BUNDLE)/Contents/Info.plist"

	@echo "🔐 코드사인 (ad-hoc)..."
	@codesign --force --deep --sign - "$(APP_BUNDLE)" 2>/dev/null || true
	@xattr -cr "$(APP_BUNDLE)" 2>/dev/null || true
	@touch "$(APP_BUNDLE)"
	@/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f -r "$(APP_BUNDLE)" 2>/dev/null || true

	@echo "✅ 설치 완료: $(APP_BUNDLE)"
	@open "$(APP_BUNDLE)"

# ── 패키징 (배포용 번들, DMG, ZIP 생성) ──────────────────────────────────────────

package: build
	@echo "📦 배포용 앱 번들 생성 중..."
	@rm -rf "$(DIST_DIR)"
	@mkdir -p "$(DIST_BUNDLE)/Contents/MacOS"
	@mkdir -p "$(DIST_BUNDLE)/Contents/Resources"
	@cp "$(BIN_PATH)/$(BIN_NAME)" "$(DIST_BUNDLE)/Contents/MacOS/$(APP_NAME)"
	@chmod +x "$(DIST_BUNDLE)/Contents/MacOS/$(APP_NAME)"
	@cp "$(RESOURCES)/AppIcon.icns" "$(DIST_BUNDLE)/Contents/Resources/AppIcon.icns"
	@cp "$(RESOURCES)/Info.plist" "$(DIST_BUNDLE)/Contents/Info.plist"
	@echo "🔐 코드사인 (ad-hoc)..."
	@codesign --force --deep --sign - "$(DIST_BUNDLE)" 2>/dev/null || true
	@xattr -cr "$(DIST_BUNDLE)" 2>/dev/null || true
	@echo "💿 DMG 생성 중..."
	@hdiutil create -volname "$(APP_NAME)" -srcfolder "$(DIST_BUNDLE)" -ov -format UDZO "$(DIST_DIR)/$(APP_NAME).dmg"
	@echo "🗜️  ZIP 생성 중..."
	@ditto -c -k --sequesterRsrc --keepParent "$(DIST_BUNDLE)" "$(DIST_DIR)/$(APP_NAME).zip"
	@echo "✅ 패키징 완료: $(DIST_DIR)/"

# ── 제거 / 청소 ──────────────────────────────────────────────────────────────

uninstall:
	@echo "🗑️  $(APP_BUNDLE) 삭제 중..."
	@rm -rf "$(APP_BUNDLE)"
	@rm -rf "/Applications/GTVRemote.app" 2>/dev/null || true
	@echo "✅ 삭제 완료"

clean:
	swift package clean
	@rm -rf "$(DIST_DIR)"
