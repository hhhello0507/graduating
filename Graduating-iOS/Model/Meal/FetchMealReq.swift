//
//  FetchMealReq.swift
//  Model
//
//  Created by hhhello0507 on 8/28/24.
//

import Foundation

public struct FetchMealReq: ReqProtocol {
    public let schoolId: Int
    
    public init(schoolId: Int) {
        self.schoolId = schoolId
    }
}
