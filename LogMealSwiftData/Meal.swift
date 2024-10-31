//
//  Meal.swift
//  LogMealSwiftData
//
//  Created by Michelle Angela Aryanto on 30/10/24.
//

import Foundation
import SwiftData

@Model
class Meal{
    var ingredient: String
    var date: Date
    var servingQty: Double
    var servingUnit: String
    var reaction: String
    var notes: String
    
    init(ingredient: String, date: Date, servingQty: Double, servingUnit: String, reaction: String, notes: String) {
        self.ingredient = ingredient
        self.date = date
        self.servingQty = servingQty
        self.servingUnit = servingUnit
        self.reaction = reaction
        self.notes = notes
    }
}
