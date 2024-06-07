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
    var about: String?

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
        case about
    }
}


struct Specialization: Identifiable, Codable {
    var id = UUID()
    var name: String
    var icon: String
    var theme: Theme
    var items: [Doctor]
}

//struct WorkingHours: Codable {
//    let from: String
//    let to: String
//}

//enum Schedule: String, Codable, Identifiable, CaseIterable {
//    case everyDay = "EVERY_DAY"
//    case monSat = "MON_SAT"
//    case custom = "CUSTOM"
//    
//    var id: String { self.rawValue }
//}


struct Slot: Codable, Identifiable {
    let id: String
    let from: String
    let to: String
    let dateAndTime: Date
    let isBooked: Bool
    init(id: String? = nil, from: String, to: String, dateAndTime: Date, isBooked: Bool) {
        self.id = id ?? UUID().uuidString
        self.from = from
        self.to = to
        self.dateAndTime = dateAndTime
        self.isBooked = isBooked
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case from
        case to
        case dateAndTime
        case isBooked
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        from = try container.decode(String.self, forKey: .from)
        to = try container.decode(String.self, forKey: .to)
        isBooked = try container.decode(Bool.self, forKey: .isBooked)
        
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let dateString = try? container.decode(String.self, forKey: .dateAndTime),
           let date = dateFormatter.date(from: dateString) {
            self.dateAndTime = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .dateAndTime, in: container, debugDescription: "Expected date string to be ISO8601-formatted.")
        }
    }
    
}

struct FeesType: Identifiable, Codable, Hashable {
    let id : String
    let type : String
    let name : String
    let amount : Int
    
    enum CodingKeys: String, CodingKey{
        case id = "_id"
        case type
        case name
        case amount
    }
}
