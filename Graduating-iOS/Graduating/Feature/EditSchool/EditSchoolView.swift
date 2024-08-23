//
//  EditSchoolView.swift
//  Graduating
//
//  Created by hhhello0507 on 8/23/24.
//

import SwiftUI
import MyDesignSystem

struct EditSchoolPath: Hashable {}

struct EditSchoolView: View {
    
    @StateObject private var viewModel = SearchSchoolViewModel()
    @EnvironmentObject private var router: Router
    
    init(_ path: EditSchoolPath) {}
    
    var body: some View {
        MyTopAppBar.small(title: "") { insets in
            VStack(spacing: 12) {
                Text("학교를 알려주세요 🤔")
                    .myFont(.title1B)
                    .foreground(Colors.Label.normal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                SearchSchoolContainer(for: viewModel.searchedSchools, searchText: $viewModel.searchSchoolName) {
                    router.toRoot()
                }
            }
            .padding(insets)
        }
        .onAppear {
            viewModel.fetchSchools()
        }
    }
}
