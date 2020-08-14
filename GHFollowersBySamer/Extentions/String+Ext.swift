//
//  String+Ext.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/12/20.
//  Copyright © 2020 samer. All rights reserved.
//

import Foundation

extension String {
    
    func convertToString() -> Date? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormater.locale = Locale(identifier: "en_US_POSIX")
        dateFormater.timeZone = .current
        
        return dateFormater.date(from: self)
    }
    
    
    func convertToDisplayFormate() -> String {
        guard let date = self.convertToString() else { return "N/A" }
       
        return  date.convertToMounthYearFormate()
        
    }
}
