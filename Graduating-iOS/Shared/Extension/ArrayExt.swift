//  Author: hhhello0507
//  Created: 10/10/24


import Foundation

public extension Array {
    // If position parameter is nil then position is middle index
    func splitArray(position: Int? = nil) -> ([Element], [Element]) {
        let position = position ?? Int(ceil(Double(self.count) / 2.0))
        let firstHalf = Array(self[0..<position])
        let secondHalf = Array(self[position..<self.count])
        return (firstHalf, secondHalf)
    }
}
