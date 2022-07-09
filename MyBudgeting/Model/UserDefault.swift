//
//  UserDefault.swift
//  MyBudgeting
//
//  Created by I Gede Bagus Wirawan on 24/05/22.
//

import SwiftUI

    struct budgetPercentage: Identifiable {
        var id = UUID()
        var budgetName: String
        var percentage: Int
    }

    struct customBudget: Identifiable {
        var id = UUID()
        var nameBudget: String
        var percentage: [budgetPercentage]
    }

