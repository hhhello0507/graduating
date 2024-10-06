import SwiftUI
import Combine

import Data
import Model
import Shared

import GoogleSignIn
import MyDesignSystem
import MyUIKitExt
import SignKit
import SwiftUI
import UIKit

struct ProfileView {
    @EnvironmentObject private var dialog: DialogProvider
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var customPalette: CustomPalette.Provider
    
    @StateObject private var appleViewModel = AppleViewModel()
    @StateObject private var viewModel = ProfileViewModel()
    
    @State private var isSignInSheetPresent: Bool = false
    @State private var isColorPickerSheetPresent: Bool = false
    @State private var selectedColor: Color = .white
    
    @AppStorage("theme", store: .graduating) private var theme: Int = Palette.blue.rawValue
}

extension ProfileView: View {
    var body: some View {
        MyTopAppBar.default(
            title: "프로필",
            buttons: [
                .init(icon: Icons.Feature.Setting) {
                    router.push(SettingPath())
                }
            ]
        ) { insets in
            VStack(spacing: 0) {
                VStack(spacing: 8) {
                    MyAvatar(nil, type: .larger)
                    appState.currentUser.makeView {
                        ProgressView()
                    } success: { user in
                        HStack(spacing: 8) {
                            Text(user.nickname)
                                .foreground(Colors.Label.alternative)
                                .myFont(.bodyR)
                            Button {
                                router.push(EditProfilePath())
                            } label: {
                                Image(icon: Icons.Feature.Pen)
                                    .resizable()
                                    .renderingMode(.template)
                                    .foreground(Colors.Label.assistive)
                                    .frame(size: 18)
                            }
                        }
                    } failure: { _ in
                        Button {
                            isSignInSheetPresent = true
                        } label: {
                            Text("로그인 하기")
                                .foreground(Colors.Label.alternative)
                                .myFont(.bodyR)
                        }
                    }
                }
                .padding(.top, 16)
                HStack(spacing: 12) {
                    MyButton("학교 수정", role: .assistive, expanded: true) {
                        router.push(EditSchoolPath())
                    }
                    .size(.medium)
                    .frame(maxWidth: .infinity)
                    MyButton("학년 수정", role: .assistive, expanded: true) {
                        router.push(EditGradePath())
                    }
                    .size(.medium)
                    .frame(maxWidth: .infinity)
                }
                .padding(.top, 24)
                Text("커스터 마이징")
                    .padding(.top, 32)
                    .padding(.leading, 6)
                    .myFont(.labelR)
                    .foreground(Colors.Label.assistive)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button {
                    isColorPickerSheetPresent = true
                } label: {
                    HStack(spacing: 12) {
                        Text("🎨 테마 선택")
                            .foreground(Colors.Label.normal)
                            .myFont(.bodyM)
                        Spacer()
                        CustomPalette.primary50.frame(size: 48)
                            .stroke(8, color: Colors.Label.normal, lineWidth: 1.5)
                    }
                    .padding(12)
                    .background(Colors.Background.normal)
                    .cornerRadius(8, corners: .allCorners)
                }
                .padding(.top, 8)
                Spacer()
            }
            .padding(insets)
        }
        .sheet(isPresented: $isSignInSheetPresent, content: signInSheetContent)
        .sheet(isPresented: $isColorPickerSheetPresent, content: colorPickerSheetContent)
        .onReceive(viewModel.$signInFlow, perform: receiveSubject)
        .onReceive(appleViewModel.subject, perform: receiveAppleSubject)
    }
}

extension ProfileView {
    @ViewBuilder
    func signInSheetContent() -> some View {
        VStack(spacing: 10) {
            AppleSignInButton {
                appleViewModel.signIn()
            }
            GoogleSignInButton {
                guard let rootViewController = UIApplicationUtil.window?.rootViewController else { return }
                Task {
                    let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
                    guard let code = result.serverAuthCode else { return }
                    viewModel.signIn(code: code, platformType: .google)
                }
            }
        }
        .padding(20)
        .adjustHeightSheet()
        .background(Colors.Background.normal)
    }
    
    @ViewBuilder
    func colorPickerSheetContent() -> some View {
        HStack(spacing: 10) {
            ForEach(saturationPalletes, id: \.self) { pallete in
                Button {
                    customPalette.updateColor(pallete: pallete)
                    theme = pallete.rawValue
                } label: {
                    pallete.allCases[6].color
                        .frame(height: 128)
                        .cornerRadius(8, corners: .allCorners)
                        .stroke(8, color: Colors.Label.normal, lineWidth: self.theme == pallete.rawValue ? 2 : 0)
                }
            }
        }
        .padding(20)
        .adjustHeightSheet()
        .presentationBackground(Colors.Background.normal)
    }
}

extension ProfileView {
    func receiveSubject(flow: Flow) {
        isSignInSheetPresent = false
        switch flow {
        case .success:
            router.replace([MainPath()])
            Task {
                try? await Task.sleep(for: .seconds(1)) // 새 AccessToken을 넣어주는 코드보다 이 코드가 먼저 실행되서 로직이 꼬임
                appState.fetchCurrentUser()
            }
        case .failure:
            dialog.present(
                .init(title: "로그인 실패")
            )
        default:
            break
        }
    }
    
    func receiveAppleSubject(subject: AppleViewModel.Subject) {
        switch subject {
        case .signInSuccess(let code):
            viewModel.signIn(code: code, platformType: .apple)
        case .signInFailure:
            dialog.present(
                .init(title: "로그인 실패")
            )
        }
    }
}

private let saturationPalletes = Palette.allCases.filter(\.hasSaturation)
