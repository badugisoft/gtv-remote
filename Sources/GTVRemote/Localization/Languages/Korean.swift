import Foundation

public struct KoreanStrings: LocalizableStrings {
    public init() {}

    // Connection Status
    public let connecting = "연결 중..."
    public let discovering = "기기 검색 중..."
    public let pairingRequired = "페어링 대기 중"
    public let disconnected = "연결 없음"
    public let connectionError = "연결 오류"
    public let online = "온라인"
    public let selectTVPrompt = "기기 선택 필요"

    // Header & Menus
    public let selectDeviceTooltip = "클릭하여 기기 선택 및 연결 관리"
    public let shortcutsTooltip = "키보드 단축키 보기"
    public let languageTooltip = "언어 변경"
    public let deviceList = "기기 목록"
    public let searching = "검색 중..."
    public let rescanDevices = "기기 다시 검색"
    public let disconnect = "연결 해제"
    public let quitApp = "GTV Remote 종료"

    // Remote Control Buttons
    public let powerTooltip = "전원 (P)"
    public let playPauseTooltip = "재생/일시정지 (Space)"
    public let backTooltip = "뒤로 (Esc)"
    public let homeTooltip = "홈 (H)"
    public let volumeDownTooltip = "볼륨 낮추기 (-)"
    public let volumeUpTooltip = "볼륨 높이기 (+)"
    public let dpadSelectTooltip = "선택 (Enter)"
    public let dpadUpTooltip = "위로 (↑)"
    public let dpadDownTooltip = "아래로 (↓)"
    public let dpadLeftTooltip = "왼쪽 (←)"
    public let dpadRightTooltip = "오른쪽 (→)"
    public let assistantTooltip = "구글 어시스턴트 (A)"
    public let muteTooltip = "음소거 (M)"
    public let inputTooltip = "외부입력 (I)"

    // Smart Input Bar
    public let inputPlaceholder = "TV로 텍스트 전송 (Enter로 전송)"
    public let send = "전송"

    // Quick Apps
    public let quickApps = "빠른 앱"
    public let quickAppsSettingsTooltip = "빠른 앱 설정"
    public let noAppsSelected = "설정에서 앱을 선택하세요"

    // Quick Apps Settings Sheet
    public let settingsTitle = "빠른 앱 설정"
    public let done = "완료"
    public func listVisibleCount(visible: Int, total: Int) -> String {
        "목록 (\(visible)/\(total)개 표시 중)"
    }
    public let dragToReorder = "드래그하여 순서 조정"
    public let addCustomApp = "사용자 앱 추가"
    public let collapse = "접기"
    public let appNamePlaceholder = "앱 이름 (예: Wavve)"
    public let uriPlaceholder = "딥링크 URI (예: https://...)"
    public let add = "추가"
    public let editAppShortcut = "앱 바로가기 수정"
    public let appName = "앱 이름"
    public let deepLinkURI = "딥링크 URI"
    public let cancel = "취소"
    public let save = "저장"
    public let edit = "수정"
    public let delete = "삭제"

    // Pairing Sheet
    public let pairingTitle = "Google TV 페어링"
    public let pairingPrompt = "TV 화면에 표시된 6자리 코드를 입력하세요."
    public let pairingFailed = "페어링에 실패했습니다. 코드를 확인 후 다시 시도하세요."
    public let pair = "페어링"

    // Keyboard Shortcuts Sheet
    public let shortcutsTitle = "키보드 단축키 안내"
    public let shortcutsDesc = "창이 활성화된 상태에서 아래 키를 바로 누를 수 있습니다."
    public let groupNav = "내비게이션 & 선택"
    public let groupMedia = "미디어 & 사운드"
    public let groupSystem = "시스템 & 앱"

    public let keyArrow = "방향키 (↑ ↓ ← →)"
    public let descArrow = "D-Pad 상/하/좌/우 이동"
    public let keyEnter = "Enter"
    public let descEnter = "중앙 선택 (OK)"
    public let keyEsc = "Esc"
    public let descEsc = "뒤로가기"
    public let keyH = "H"
    public let descH = "홈 화면으로 이동"
    public let keySpace = "Space"
    public let descSpace = "재생 / 일시정지"
    public let keyVolume = "+  /  -"
    public let descVolume = "볼륨 올리기 / 내리기"
    public let keyM = "M"
    public let descM = "음소거 켜기 / 끄기"
    public let keyP = "P"
    public let descP = "전원 켜기 / 끄기"
    public let keyA = "A"
    public let descA = "구글 어시스턴트 호출"
    public let keyI = "I"
    public let descI = "외부입력 선택"
    public let keyNumbers = "1 ~ 9"
    public let descNumbers = "빠른 앱 1~9번 바로 실행"
}
