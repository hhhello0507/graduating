import SwiftUI

import Shared

import MyDesignSystem

struct EditProfilePath: Hashable {}

struct EditProfileView {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var dialog: DialogProvider
    @EnvironmentObject private var appState: AppState
    
    @StateObject private var viewModel = EditProfileViewModel()
}

extension EditProfileView: View {
    var body: some View {
        MyTopAppBar.small(title: "프로필 수정") { insets in
            VStack(spacing: 0) {
                MyTextField("닉네임", text: $viewModel.nickname)
                Spacer()
            }
            .padding(insets)
        }
        .onAppear(perform: initNickname)
        .onReceive(viewModel.$editProfileFlow, perform: receiveEditProfileFlow)
        .safeAreaInset(edge: .bottom, content: safeAreaContent)
    }
}

extension EditProfileView {
    @ViewBuilder
    func safeAreaContent() -> some View {
        MyButton(
            "수정 완료",
            isEnabled: viewModel.isValidInput,
            expanded: true
        ) {
            viewModel.editProfile()
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
    }
}

extension EditProfileView {
    func initNickname() {
        guard let user = appState.currentUser.data else { return }
        viewModel.initNickname(user.nickname)
    }
    
    func receiveEditProfileFlow(flow: Flow) {
        switch flow {
        case .success:
            dialog.present(
                .init(title: "프로필 수정 성공")
                .primaryButton("닫기") {
                    appState.fetchCurrentUser()
                    router.pop()
                }
            )
        case .failure:
            dialog.present(
                .init(title: "프로필 수정 실패", message: "잠시 후 다시 시도해 주세요")
                .primaryButton("확인")
            )
        default:
            break
        }
    }
}
