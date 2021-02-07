//
//  VehicleList.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 27.01.2021.
//

import Foundation

struct VehiclesList: Decodable {
    let id: Int
    let title: String
    let location: Location
    let category: VehicleCategory
    let modelName: String
    let price: Int
    let dateFormatted: String
    let photo: String
    let properties: [Properties]
}

struct Location: Decodable {
    let cityName: String
    let townName: String
}

struct VehicleCategory: Decodable {
    let id: Int
    let name: String
}

struct Properties: Decodable {
    let name: String
    let value: String
}
