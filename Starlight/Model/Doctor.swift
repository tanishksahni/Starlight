//
//  Doctor.swift
//  Starlight
//
//  Created by Tanishk Sahni on 03/06/24.
//

import Foundation

enum Schedule: String, Codable {
    case everyDay = "EVERY_DAY"
    case monSat = "MON_SAT"
    case custom = "CUSTOM"
}

enum Day: String, Codable {
    case monday = "MONDAY"
    case tuesday = "TUESDAY"
    case wednesday = "WEDNESDAY"
    case thursday = "THURSDAY"
    case friday = "FRIDAY"
    case saturday = "SATURDAY"
    case sunday = "SUNDAY"
}

struct WorkingHours: Codable {
    var day: Day
    var from: String
    var to: String
}

struct Doctor: Codable, Identifiable {
    var id: String
    var userId: User
    var hospitalId: String?
    var licenseNo: String
    var isVerified: Bool = false
    var specialization: String
    var experienceYears: Int? // Using Double for numerical fields to allow for decimal values
    var qualification: String
    var isAvailable: Bool = true
    var schedule: Schedule? 
    var workingHours: [WorkingHours]?
    var duration: Double = 30
    
//    init(userId: UUID, hospitalId: UUID? = nil, licenseNo: String, isVerified: Bool = false, specialization: String, experienceYears: Int? = nil, qualification: String, isAvailable: Bool = true, schedule: Schedule? = nil, workingHours: [WorkingHours] = [], duration: Double = 30) {
//        self.userId = userId
//        self.hospitalId = hospitalId
//        self.licenseNo = licenseNo.trimmingCharacters(in: .whitespacesAndNewlines)
//        self.isVerified = isVerified
//        self.specialization = specialization.trimmingCharacters(in: .whitespacesAndNewlines)
//        self.experienceYears = experienceYears
//        self.qualification = qualification.trimmingCharacters(in: .whitespacesAndNewlines)
//        self.isAvailable = isAvailable
//        self.schedule = schedule
//        self.workingHours = workingHours
//        self.duration = duration
//    }
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId
        case hospitalId
        case licenseNo
        case isVerified
        case specialization
        case experienceYears
        case qualification
        case isAvailable
        case schedule
        case workingHours
        case duration
    }
}


struct Specialization: Identifiable, Codable {
    var id = UUID()
    var name: String
    var icon: String
    var theme: Theme
    var items: [Doctor]
}
