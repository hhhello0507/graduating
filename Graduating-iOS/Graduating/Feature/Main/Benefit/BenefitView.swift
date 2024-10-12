//  Author: hhhello0507
//  Created: 10/11/24


import SwiftUI
import MyDesignSystem

struct BenefitView {
    @StateObject private var viewModel = BenefitViewModel()
}

extension BenefitView: View {
    var body: some View {
        MyTopAppBar.default(
            title: "혜택"
        ) { insets in
            viewModel.scholarships.makeView {
                ProgressView()
            } success: { scholarships in
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(scholarships.indices, id: \.self) { index in
                            ScholarshipCell(for: scholarships[index])
                            if index != scholarships.count - 1 {
                                MyDivider()
                                    .padding(.horizontal, 4)
                            }
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

#Preview {
    BenefitView()
}
