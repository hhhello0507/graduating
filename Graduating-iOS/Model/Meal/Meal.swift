//
//  Meal.swift
//  Model
//
//  Created by hhhello0507 on 8/28/24.
//

import Foundation

public struct Meal: ModelProtocol {
    
    public var id: Int
    public var mealType: MealType?
    public var calorie: Double
    public var menu: String
    public var mealInfo: String
    public var mealDate: Date
    public var schoolId: Int
    
    public init(
        id: Int, 
        mealType: MealType? = nil,
        calorie: Double,
        menu: String,
        mealInfo: String,
        mealDate: Date,
        schoolId: Int
    ) {
        self.id = id
        self.mealType = mealType
        self.calorie = calorie
        self.menu = menu
        self.mealInfo = mealInfo
        self.mealDate = mealDate
        self.schoolId = schoolId
    }
}
