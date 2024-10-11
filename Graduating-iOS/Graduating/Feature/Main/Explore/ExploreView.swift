//  Author: hhhello0507
//  Created: 10/11/24


import SwiftUI
import MyDesignSystem
import Shared

struct ExploreView: View {
    @StateObject private var viewModel = ExploreViewModel()
    
    var body: some View {
        MyTopAppBar.default(
            title: "탐색"
        ) { insets in
            viewModel.scholarships.makeView {
                ProgressView()
            } success: { scholarships in
                ScrollView {
                    LazyVStack {
                        ForEach(scholarships, id: \.id) { scholarship in
                            Text("짜잔")
                        }
                    }
                    .padding(insets)
                }
            } failure: { _ in
                Text("정보를 불러올 수 없어요")
                    .myFont(.labelM)
                    .foreground(Colors.Label.alternative)
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .refreshable {
            viewModel.refresh()
        }
    }
}
