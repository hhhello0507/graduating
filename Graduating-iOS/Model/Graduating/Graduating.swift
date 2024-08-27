//
//  Graduating.swift
//  Graduating
//
//  Created by hhhello0507 on 8/21/24.
//

import Foundation

public struct Graduating: ModelProtocol {
    public let id: Int
    public let graduatingDay: Date
    public let schoolId: Int
    
    public init(id: Int, graduatingDay: Date, schoolId: Int) {
        self.id = id
        self.graduatingDay = graduatingDay
        self.schoolId = schoolId
    }
}
