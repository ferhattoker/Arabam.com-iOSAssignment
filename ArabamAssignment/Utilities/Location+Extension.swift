//
//  Location+Extension.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 30.01.2021.
//

import Foundation

extension Location {
    var toString: String {
        return self.townName + " • " + self.cityName
    }
}
