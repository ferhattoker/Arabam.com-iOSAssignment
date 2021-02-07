//
//  Sort.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 28.01.2021.
//

import Foundation

struct Sort {
    let kind: SortKind
    let direction: SortDirections
}

enum SortKind: Int {
    case price = 0, date, year
}


enum SortDirections: Int {
    case ascending = 0, descending
}

