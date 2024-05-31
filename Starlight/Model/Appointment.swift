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


var appointments: [Appointment] = [
    Appointment(userName: "John Doe", userImage: UIImage(systemName: "person.fill")!, date: Date(), time: "9:00 AM", isEmergency: false),
    Appointment(userName: "Emma Stone", userImage: UIImage(systemName: "person.fill")!, date: Date(), time: "10:30 AM", isEmergency: true),
    Appointment(userName: "Michael Bay", userImage: UIImage(systemName: "person.fill")!, date: Date(), time: "1:45 PM", isEmergency: false),Appointment(userName: "John Doe", userImage: UIImage(systemName: "person.fill")!, date: Date(), time: "9:00 AM", isEmergency: false),
    Appointment(userName: "Emma Stone", userImage: UIImage(systemName: "person.fill")!, date: Date(), time: "10:30 AM", isEmergency: true),
    Appointment(userName: "Michael Bay", userImage: UIImage(systemName: "person.fill")!, date: Date(), time: "1:45 PM", isEmergency: false)
]


struct Appointment: Identifiable {
    let id = UUID()
    let userName: String
    let userImage: UIImage
    let date: Date
    let time: String
    let isEmergency: Bool
}

struct PatientAppointment: Identifiable {
    let id = UUID()
    let doctorName: String
    let degree: String
    let specialty: String
    let date: String
    let time: String
    let imageName: String
    var themeColor: Color
}

let patientAppointments = [
    PatientAppointment(doctorName: "Arvind Kumar", degree: "MBBS", specialty: "Neurology", date: "23/3/2024", time: "12:00PM", imageName: "image", themeColor: .yellow),
    PatientAppointment(doctorName: "Priya Sharma", degree: "MD", specialty: "Cardiology", date: "25/3/2024", time: "2:00PM", imageName: "image",themeColor: .orange),
    PatientAppointment(doctorName: "Ravi ", degree: "MD", specialty: "Orthopedics", date: "27/3/2024", time: "10:00AM", imageName: "image", themeColor: .red),
    PatientAppointment(doctorName: "Naman Sharma ", degree: "MBBS", specialty: "Orthopedics", date: "27/3/2024", time: "10:00AM", imageName: "image", themeColor: .blue)
]
