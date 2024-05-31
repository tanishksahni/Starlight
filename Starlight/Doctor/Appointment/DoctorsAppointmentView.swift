//
//  DoctorsAppointmentView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 30/05/24.
//

import SwiftUI

struct DoctorsAppointmentView: View {
    @State private var searchText = ""
    @State private var selectedFilter: AppointmentFilter = .all
    
    
    
    enum AppointmentFilter: String, CaseIterable {
        case all = "All"
        case general = "General"
        case emergency = "Emergency"
    }
    
    // Mock data for appointments
    var appointments: [Appointment] = [
        Appointment(userName: "John Doe", userImage: UIImage(systemName: "person.fill")!, date: Date(), time: "9:00 AM", isEmergency: false),
        Appointment(userName: "Emma Stone", userImage: UIImage(systemName: "person.fill")!, date: Date(), time: "10:30 AM", isEmergency: true),
        Appointment(userName: "Michael Bay", userImage: UIImage(systemName: "person.fill")!, date: Date(), time: "1:45 PM", isEmergency: false),Appointment(userName: "John Doe", userImage: UIImage(systemName: "person.fill")!, date: Date(), time: "9:00 AM", isEmergency: false),
        Appointment(userName: "Emma Stone", userImage: UIImage(systemName: "person.fill")!, date: Date(), time: "10:30 AM", isEmergency: true),
        Appointment(userName: "Michael Bay", userImage: UIImage(systemName: "person.fill")!, date: Date(), time: "1:45 PM", isEmergency: false)
    ]
    
    var filteredAppointments: [Appointment] {
        switch selectedFilter {
        case .all:
            return appointments
        case .general:
            return appointments.filter { !$0.isEmergency }
        case .emergency:
            return appointments.filter { $0.isEmergency }
        }
    }
    var generalAppointments: [Appointment] {
        return appointments.filter { !$0.isEmergency }
    }
    
    var emergencyAppointments: [Appointment] {
        return appointments.filter { $0.isEmergency }
    }
    
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    
                    Picker("Filter", selection: $selectedFilter) {
                        ForEach(AppointmentFilter.allCases, id: \.self) { filter in
                            Text(filter.rawValue).tag(filter)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Spacer().frame(height: 12)
                    if selectedFilter == .all || selectedFilter == .emergency {
                        ForEach(appointments.filter { $0.isEmergency }) { appointment in
                            AppointmentCell(appointment: appointment)
                                .padding(.bottom, 12)
                        }
                        
                    }
                    
                    if selectedFilter == .all || selectedFilter == .general {
                        
                        ForEach(appointments.filter { !$0.isEmergency }) { appointment in
                            AppointmentCell(appointment: appointment)
                                .padding(.bottom, 12)
                        }
                    }
                    
                }
                .navigationBarTitle("Appointments")
                .navigationBarTitleDisplayMode(.large)
                .padding()
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing,
                                content: {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                        
                    })
                }
            }
            .searchable(text: $searchText)
        }
    }
}



struct AppointmentCell: View {
    var appointment: Appointment
    
    var body: some View {
        
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 45, height: 45)
                .padding(8)
                .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(appointment.userName)
                    .font(.system(size: 18, weight: .semibold))
                
                Text("\(appointment.date, formatter: itemFormatter) \(appointment.time)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                
                Text(appointment.isEmergency ? "Emergency" : "General")
                    .font(.subheadline)
                    .foregroundColor(appointment.isEmergency ? .red : .green)
            }
            Spacer()
            Button(action: {
                // Handle tapping the "i" button
            }) {
                Image(systemName: "info.circle")
                    .font(.title2)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray, lineWidth: 0.25)
        )
    }
}

// Replace with your own Appointment model
struct Appointment: Identifiable {
    let id = UUID()
    let userName: String
    let userImage: UIImage
    let date: Date
    let time: String
    let isEmergency: Bool
}

// Date formatter
let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
}()



#Preview {
    DoctorsAppointmentView()
}
