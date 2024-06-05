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
    var workingHours: WorkingHoursTime
    
    private enum CodingKeys: String, CodingKey {
        case day
        case workingHours
    }
}

struct WorkingHoursTime: Codable {
    var from: String
    var to: String
    
    private enum CodingKeys: String, CodingKey {
        case from
        case to
    }
}

struct Doctor: Codable, Identifiable {
    var id: String
    var userId: User
    var hospitalId: String?
    var licenseNo: String
    var isVerified: Bool = false
    var specialization: String
    var experienceYears: Int? 
    var qualification: String
    var isAvailable: Bool = true
    var schedule: Schedule? 
    var workingHours: [WorkingHours]?
    var duration: Double = 30

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
