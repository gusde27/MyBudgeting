//
//  Methods.swift
//  MyBudgeting
//
//  Created by I Gede Bagus Wirawan on 26/04/22.
//

import SwiftUI

struct Methods: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let description: String
    let simple_dec: String
    let url: URL
}

struct MethodsList {
    
    static let data = [
        Methods(imageName: "one",
              title: "50/30/20 Budgeting Method",
              description: "The method ala United States senator Elizabeth Warren is popular through her book All Your Worth: The Ultimate Lifetime Money Plan. Budgeting 50/30/20 advises you to break down your tax-free net income into three large sections. 50% of daily necessities and mandatory bills, 30% of entertainment and other desires, 20% of savings and investments",
              simple_dec:"The method ala United States senator Elizabeth Warren is popular through her book All Your Worth: The Ultimate Lifetime Money Plan.",
              url: URL(string: "https://www.jenius.com/highlight/detail/budgeting-50-30-20-dan-80-20-buat-kamu-si-minimalis")!),
        
        Methods(imageName: "two",
              title: "80/20 Budgeting Method",
              description: "The 80/20 method, also known as the Pareto principle, is a management strategy to help people focus more on the many important things that need to be done. A simpler 80/20 budget division is perfect for those of you who want to start paying attention to the budget, but are lazy to complicate things! 80% for current living expenses, 20% for future savings",
              simple_dec:"The 80/20 method, also known as the Pareto principle, is a management strategy to help people focus more on the many important things that need to be done.",
              url: URL(string: "https://www.jenius.com/highlight/detail/budgeting-50-30-20-dan-80-20-buat-kamu-si-minimalis")!),
        
        Methods(imageName: "three",
              title: "Li Ka-Shing Budgeting Method",
              description: "No matter how much you earn, always remember to divide it into five parts proportionately, said Li Ka-Shing. Li Ka-Shing's budgeting system suggests dividing the five incomes received each month. The five posts are 30% cost of living post, 20% socializing post, 15% personal development post, 10% vacation post, and 25% investment post.",
              simple_dec:"No matter how much you earn, always remember to divide it into five parts proportionately,” said Li Ka-Shing.",
              url: URL(string: "https://www.jenius.com/highlight/detail/budgeting-bagi-lima-ala-li-ka-shing")!),
        
    ]
}
