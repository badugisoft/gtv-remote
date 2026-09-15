import SwiftUI
import AppKit

public struct DPadView: View {
    @ObservedObject var viewModel: RemoteViewModel
    @ObservedObject private var loc = LocalizationManager.shared
    
    public init(viewModel: RemoteViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            // D-Pad circular outer ring background
            Circle()
                .fill(Color(nsColor: .controlBackgroundColor).opacity(0.85))
                .overlay(
                    Circle()
                        .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.12), radius: 10, x: 0, y: 4)
                .frame(width: 190, height: 190)
            
            // Up / Down / Left / Right directional buttons
            VStack {
                dpadArrowButton(key: .dpadUp)
                    .padding(.top, 10)
                Spacer()
                dpadArrowButton(key: .dpadDown)
                    .padding(.bottom, 10)
            }
            .frame(width: 190, height: 190)
            
            HStack {
                dpadArrowButton(key: .dpadLeft)
                    .padding(.leading, 10)
                Spacer()
                dpadArrowButton(key: .dpadRight)
                    .padding(.trailing, 10)
            }
            .frame(width: 190, height: 190)
            
            // Center Select (OK) button
            Button(action: { viewModel.sendKey(.dpadCenter) }) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color.blue.opacity(0.9), Color.blue],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 70, height: 70)
                    
                    Text("OK")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
            }
            .buttonStyle(DPadCenterButtonStyle(isExternalPressed: viewModel.activePressedKey == .dpadCenter))
            .focusable(false)
            .help(L10n.dpadSelectTooltip)
        }
    }
    
    private func dpadArrowButton(key: RemoteKey) -> some View {
        let tooltip: String = {
            switch key {
            case .dpadUp:    return L10n.dpadUpTooltip
            case .dpadDown:  return L10n.dpadDownTooltip
            case .dpadLeft:  return L10n.dpadLeftTooltip
            case .dpadRight: return L10n.dpadRightTooltip
            default:         return key.label
            }
        }()

        return Button(action: { viewModel.sendKey(key) }) {
            Image(systemName: key.iconName)
                .font(.system(size: 18, weight: .semibold))
                .frame(width: 44, height: 44)
                .contentShape(Rectangle())
        }
        .buttonStyle(DPadArrowButtonStyle(isExternalPressed: viewModel.activePressedKey == key))
        .focusable(false)
        .help(tooltip)
    }
}
