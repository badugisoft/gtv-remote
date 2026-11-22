APP_NAME    = GTV Remote
BIN_NAME    = GTVRemote
BIN_PATH    = $(shell swift build -c release --show-bin-path 2>/dev/null || echo .build/arm64-apple-macosx/release)
APP_BUNDLE  = /Applications/$(APP_NAME).app
DIST_DIR    = dist
DIST_BUNDLE = $(DIST_DIR)/$(APP_NAME).app
RESOURCES   = Resources
SIGN_IDENTITY ?= $(shell security find-identity -v -p codesigning 2>/dev/null | grep -m1 "Developer ID Application" | sed -E 's/.*"([^"]+)".*/\1/')

define sign_bundle
	@if [ -n "$(SIGN_IDENTITY)" ] && [ "$(SIGN_IDENTITY)" != "-" ]; then \
		echo "🔐 코드사인 ($(SIGN_IDENTITY))..."; \
		codesign --force --deep --options runtime --timestamp --sign "$(SIGN_IDENTITY)" "$(1)"; \
	else \
		echo "🔐 코드사인 (ad-hoc)..."; \
		codesign --force --deep --sign - "$(1)" 2>/dev/null || true; \
	fi
endef

.PHONY: all build build-debug run dev install uninstall package dmg clean

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
	@sleep 0.8

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

	$(call sign_bundle,$(APP_BUNDLE))
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
	$(call sign_bundle,$(DIST_BUNDLE))
	@xattr -cr "$(DIST_BUNDLE)" 2>/dev/null || true
	@$(MAKE) dmg
	@echo "🗜️  ZIP 생성 중..."
	@ditto -c -k --sequesterRsrc --keepParent "$(DIST_BUNDLE)" "$(DIST_DIR)/$(APP_NAME).zip"
	@echo "✅ 패키징 완료: $(DIST_DIR)/"

## dist/GTV Remote.app 에서 DMG 생성 (create-dmg 우선, 미설치 시 hdiutil 폴백)
dmg:
	@echo "💿 DMG 생성 중..."
	@rm -rf "$(DIST_DIR)/dmg-stage" "$(DIST_DIR)/$(APP_NAME).dmg"
	@mkdir -p "$(DIST_DIR)/dmg-stage"
	@cp -R "$(DIST_BUNDLE)" "$(DIST_DIR)/dmg-stage/"
	@if command -v create-dmg >/dev/null 2>&1; then \
		create-dmg \
			--volname "$(APP_NAME)" \
			--volicon "$(RESOURCES)/AppIcon.icns" \
			--background "assets/dmg-background.tiff" \
			--window-pos 200 120 \
			--window-size 660 400 \
			--icon-size 100 \
			--icon "$(APP_NAME).app" 175 205 \
			--hide-extension "$(APP_NAME).app" \
			--app-drop-link 485 205 \
			--no-internet-enable \
			"$(DIST_DIR)/$(APP_NAME).dmg" \
			"$(DIST_DIR)/dmg-stage"; \
	else \
		ln -s /Applications "$(DIST_DIR)/dmg-stage/Applications"; \
		hdiutil create -volname "$(APP_NAME)" -srcfolder "$(DIST_DIR)/dmg-stage" -ov -format UDZO "$(DIST_DIR)/$(APP_NAME).dmg"; \
	fi
	@rm -rf "$(DIST_DIR)/dmg-stage"

# ── 제거 / 청소 ──────────────────────────────────────────────────────────────

uninstall:
	@echo "🗑️  $(APP_BUNDLE) 삭제 중..."
	@rm -rf "$(APP_BUNDLE)"
	@rm -rf "/Applications/GTVRemote.app" 2>/dev/null || true
	@echo "✅ 삭제 완료"

clean:
	swift package clean
	@rm -rf "$(DIST_DIR)"
