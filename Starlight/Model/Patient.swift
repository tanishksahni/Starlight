//
//  Patient.swift
//  Starlight
//
//  Created by Tanishk Sahni on 31/05/24.
//


import Foundation

struct Patient: Codable, Identifiable {
    var id: String
    var userId: User
    var hospitalId: String
    var dob: String
    var height: Double?
    var weight: Double?
    var address: String
    var patientID: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId
        case hospitalId
        case dob
        case height
        case weight
        case address
        case patientID
    }
}
