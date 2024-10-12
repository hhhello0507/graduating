//  Author: hhhello0507
//  Created: 10/11/24

import Combine
import Foundation
import Shared
import Data

final class ExploreViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    var isFirstOnAppear: Bool = true
}

extension ExploreViewModel: OnAppearProtocol {
    func fetchAllData() {
    }
}
