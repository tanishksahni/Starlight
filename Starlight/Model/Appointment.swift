//
//  Appointment.swift
//  Starlight
//
//  Created by Tanishk Sahni on 31/05/24.
//

import Foundation
import SwiftUI

enum AppointmentFilter: String, CaseIterable {
    case all = "All"
    case general = "General"
    case emergency = "Emergency"
}

struct Appointment: Identifiable, Codable {
    let id: String
    let feesType: FeesType?
    let doctorId: Doctor?
    let patientId: Patient?
    let desc: String
    let dateAndTime: Date
    let status: String
    
    enum CodingKeys: String, CodingKey{
        case id = "_id"
        case feesType
        case doctorId
        case patientId
        case desc
        case dateAndTime
        case status
    }
    
    init(id: String? = nil, feesType: FeesType, doctorId: Doctor? = nil, patientId: Patient? = nil, desc: String, dateAndTime: Date, status: String) {
        self.id = id ?? UUID().uuidString
        self.feesType = feesType
        self.doctorId = doctorId
        self.patientId = patientId
        self.desc = desc
        self.dateAndTime = dateAndTime
        self.status = status
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.feesType = try? container.decode(FeesType.self, forKey: .feesType)
        self.doctorId = try? container.decode(Doctor.self, forKey: .doctorId)
        self.patientId = try? container.decode(Patient.self, forKey: .patientId)
        self.desc = try container.decode(String.self, forKey: .desc)
        self.status = try container.decode(String.self, forKey: .status)
        
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
struct TimeSlot: Codable, Identifiable {
    let id: String
    let from: Date
    let to: Date
    let date: Date
    let isBooked: Bool

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case from
        case to
        case date
        case isBooked
    }
}

struct TimeSlotResponse: Codable {
    let timeSlots: [TimeSlot]
}

struct FetchAppointmentsResponse: Codable{
    let message: String
    let appointments: [Appointment]
}
