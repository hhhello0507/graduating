//
//  EditProfileView.swift
//  Graduating
//
//  Created by hhhello0507 on 10/4/24.
//

import SwiftUI

import MyDesignSystem

struct EditProfilePath: Hashable {}

struct EditProfileView: View {
    
    @StateObject private var observable = EditProfileObservable()
    
    var body: some View {
        MyTopAppBar.small(title: "프로필 수정") { insets in
            LazyVStack(spacing: 0) {
                MyTextField(text: $observable.nickname)
                Spacer()
            }
            .padding(insets)
        }
        .safeAreaInset(edge: .bottom) {
            MyButton("수정 완료", expanded: true) {
                observable.editProfile()
            }
        }
    }
}
