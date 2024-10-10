//  Author: hhhello0507
//  Created: 10/10/24


import Foundation

public extension Array {
    // If position parameter is nil then position is middle index
    func splitArray(position: Int? = nil) -> ([Element], [Element]) {
        let position = position ?? Int(ceil(Double(self.count) / 2.0))
        let calcedPosision = if self.count <= position {
            self.count
        } else {
            position
        }
        let firstHalf = Array(self[0..<calcedPosision])
        let secondHalf = Array(self[calcedPosision..<self.count])
        return (firstHalf, secondHalf)
    }
    
    static func from(_ tuple: (Element, Element)) -> Array<Element> {
        return [tuple.0, tuple.1]
    }
    
    static func from(_ tuple: (Element, Element, Element)) -> Array<Element> {
        return [tuple.0, tuple.1, tuple.2]
    }
}
