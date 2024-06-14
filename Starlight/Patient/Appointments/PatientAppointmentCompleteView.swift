//
//  PatientAppointmentCompleteView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 01/06/24.
//
//

import SwiftUI

struct PatientAppointmentCompleteView: View {
    
    var appointment: Appointment
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    AsyncImage(url: URL(string: appointment.doctorId?.userId.image ?? "")){
                        image in image
                            .resizable()
                            .scaledToFit()
                            .clipShape(Rectangle())
                            .cornerRadius(8)
                            .frame(width: 80, height: 80)
                    }placeholder: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .foregroundColor(.black)
                            .clipShape(Circle())
                            .scaledToFill()
                            .frame(width: 65, height: 65)
                    }
//                    Image("image")
//                        .resizable()
//                        .clipShape(Rectangle())
//                        .cornerRadius(8)
//                        .frame(width: 80, height: 80)
                    Spacer().frame(width: 20)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(appointment.doctorId?.userId.firstName ?? "") \(appointment.doctorId?.userId.lastName ?? "")")
                            .font(.title2)
                            .fontWeight(.medium)
                        Text(appointment.doctorId?.qualification ?? "")
                            .font(.subheadline)
                    }
                }
                VStack(spacing: 10) {
                    HStack {
                        Text("Licence no.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(appointment.doctorId?.licenseNo ?? "")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, 8)
                    Divider()
                    HStack {
                        Text("Specialization")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(appointment.doctorId?.specialization ?? "")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, 8)
                    Divider()
                    HStack {
                        Text("Experience")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(appointment.doctorId?.experienceYears.map(String.init) ?? "0")")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, 8)
                    Divider()
                    HStack {
                        Text("Date of Appointment")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        let dateTime = separateDateAndTime(from: appointment.dateAndTime)
                        Text("\(dateTime.date, formatter: dateFormatter)")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, 8)
                    Divider()
                    HStack {
                        Text("Time of Appointment")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        let dateTime = separateDateAndTime(from: appointment.dateAndTime)
                        Text(dateTime.time)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, 8)
                    Divider()
                }
                
                Spacer().frame(height: 20)
                VStack(alignment: .leading) {
                    Text("Diagnosis")
                        .font(.headline)
                        .fontWeight(.semibold)

                        Text(appointment.diagnosis ?? "No diagnosis available")
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            .padding(.vertical, 10)
                        
                        Divider()
                            .padding(.bottom,16)
                    
                    
                    Text("Prescription")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                        Text(appointment.prescription ?? "No prescription available")
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            .padding(.vertical, 16)
                    
                
                }
            }
            .navigationTitle("Appointment Information")
            .navigationBarTitleDisplayMode(.inline)
        }
        .padding()
        .scrollIndicators(.hidden)
    }
}

// Function to separate date and time
func separateDateAndTime(from date: Date) -> (date: Date, time: String) {
    let outputTimeFormat = "HH:mm"
    
    // Create DateFormatter instance for time
    let timeOutputFormatter = DateFormatter()
    timeOutputFormatter.dateFormat = outputTimeFormat
    timeOutputFormatter.timeZone = TimeZone.current

    // Get the time string
    let timeString = timeOutputFormatter.string(from: date)
    
    // Extract date components
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: date)
    let dateOnly = calendar.date(from: components)!
    
    return (date: dateOnly, time: timeString)
}

// DateFormatter for displaying date
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MM-yyyy"
    return formatter
}()

