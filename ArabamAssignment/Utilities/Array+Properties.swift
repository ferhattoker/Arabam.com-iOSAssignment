//
//  Array+Properties.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 30.01.2021.
//

import Foundation

extension Array where Element == Properties {
    
    var toString: String {
        var stringValue = ""
        
        let properties = self.filter { !$0.value.isEmpty }
        let length = properties.count - 1
        
        for (idx, property) in properties.enumerated() {
            
            if idx == length {
                stringValue += property.value
                break
            }
            
            if property.name == "km" {
                stringValue += property.value + " KM" + " • "
            } else {
                stringValue += property.value + " • "
            }
        }
        return stringValue
    }
}
