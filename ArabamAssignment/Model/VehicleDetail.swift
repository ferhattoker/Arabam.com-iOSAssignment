//
//  VehicleDetail.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 27.01.2021.
//

import Foundation

struct VehicleDetail: Decodable {
    let id: Int
    let title: String
    let location: Location
    let category: VehicleCategory
    let modelName: String
    let price: Int
    let dateFormatted: String
    let photos: [String]
    let properties: [Properties]
    let text: String
    let userInfo: UserInfo
}

struct UserInfo: Decodable {
    let id: Int
    let nameSurname: String
    let phone: String
    let phoneFormatted: String
}


