//
//  Date+EndOfDay+StartOfDay.swift
//  fluid
//
//  Created by Ziyad Khalil on 5/8/19.
//  Copyright © 2019 Ziyad Khalil. All rights reserved.
//

import UIKit
extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    func getMonth() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: self)
    }
}
