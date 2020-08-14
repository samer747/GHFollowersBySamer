//
//  Date+Ext.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/12/20.
//  Copyright © 2020 samer. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToMounthYearFormate() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMM yyyy"
        return dateFormater.string(from: self)
    }
    
}
