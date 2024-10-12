//  Author: hhhello0507
//  Created: 10/11/24


import SwiftUI
import MyDesignSystem
import Shared

struct ExploreView {
    @StateObject private var viewModel = ExploreViewModel()
}

extension ExploreView: View {
    var body: some View {
        MyTopAppBar.default(
            title: "탐색"
        ) { insets in
        }
    }
}
