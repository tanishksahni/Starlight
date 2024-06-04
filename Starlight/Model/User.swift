//
//  User.swift
//  Starlight
//
//  Created by Tanishk Sahni on 03/06/24.
//

import Foundation

enum Gender: String {
    case male, female, other
}

enum BloodGroup: String {
    case APlus = "A+"
    case AMinus = "A-"
    case BPlus = "B+"
    case BMinus = "B-"
    case ABPlus = "AB+"
    case ABMinus = "AB-"
    case OPlus = "O+"
    case OMinus = "O-"
}

enum Role: String {
    case admin, doctor, patient
}

struct User {
    var firstName: String
    var lastName: String = ""
    var email: String
    var password: String?
    var phone: String?
    var gender: Gender
    var profileImage: String?
    var bloodGroup: BloodGroup?
    var role: Role = .patient
    
    init(firstName: String, lastName: String = "", email: String, password: String? = nil, phone: String? = nil, gender: Gender, profileImage: String? = nil, bloodGroup: BloodGroup? = nil, role: Role = .patient) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.phone = phone
        self.gender = gender
        self.profileImage = profileImage
        self.bloodGroup = bloodGroup
        self.role = role
    }
}
