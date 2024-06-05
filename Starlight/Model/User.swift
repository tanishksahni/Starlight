//
//  User.swift
//  Starlight
//
//  Created by Tanishk Sahni on 03/06/24.
//

import Foundation

enum Gender: String, Codable {
    case male, female, other
}

enum BloodGroup: String, Codable {
    case APlus = "A+"
    case AMinus = "A-"
    case BPlus = "B+"
    case BMinus = "B-"
    case ABPlus = "AB+"
    case ABMinus = "AB-"
    case OPlus = "O+"
    case OMinus = "O-"
}

enum Role: String, Codable {
    case admin, doctor, patient
}

struct User: Codable, Identifiable {
    var id: String
    var firstName: String
    var lastName: String = ""
    var email: String
    var password: String?
    var phone: String?
    var gender: Gender
//    var profileImage: String?
    var bloodGroup: BloodGroup?
    var role: Role = .patient
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstName
        case lastName
        case email
        case password
        case phone
        case gender
//        case profileImage
        case bloodGroup
        case role
    }
}
