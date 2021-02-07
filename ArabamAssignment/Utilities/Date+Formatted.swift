//
//  Date+Formatted.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 1.02.2021.
//

import Foundation

extension Date {
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stringDate = dateFormatter.string(from: self)
        return stringDate
    }
    
    var displayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let stringDate = dateFormatter.string(from: self)
        return stringDate
    }
}
