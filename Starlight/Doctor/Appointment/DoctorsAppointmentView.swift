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
  
//    var filteredAppointments: [Appointment] {
//        switch selectedFilter {
//        case .all:
//            return appointments
//        case .general:
//            return appointments.filter { !$0.isEmergency }
//        case .emergency:
//            return appointments.filter { $0.isEmergency }
//        }
//    }
//    var generalAppointments: [Appointment] {
//        return appointments.filter { !$0.isEmergency }
//    }
//    
//    var emergencyAppointments: [Appointment] {
//        return appointments.filter { $0.isEmergency }
//    }
//    
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
//                    Picker("Filter", selection: $selectedFilter) {
//                        ForEach(AppointmentFilter.allCases, id: \.self) { filter in
//                            Text(filter.rawValue).tag(filter)
//                        }
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//                    
//                    Spacer().frame(height: 16)
//                    if selectedFilter == .all || selectedFilter == .emergency {
//                        ForEach(appointments.filter { $0.isEmergency }) { appointment in
//                            NavigationLink(destination: DoctorAppointmentCompleteView()) {
//                                AppointmentCell(appointment: appointment)
//                                    .padding(.bottom, 12)
//                            }
//                            
//                        }
//                        
//                    }
//                    
//                    if selectedFilter == .all || selectedFilter == .general {
//                        
//                        ForEach(appointments.filter { !$0.isEmergency }) { appointment in
//                            NavigationLink(destination: DoctorAppointmentCompleteView()) {
//                                AppointmentCell(appointment: appointment)
//                                    .padding(.bottom, 12)
//                            }
//                        }
//                    }
                    
                }
                
            }
            .scrollIndicators(.hidden)
            .navigationBarTitle("Appointments")
            .navigationBarTitleDisplayMode(.large)
            .padding()
            .searchable(text: $searchText)
        }
    }
}



struct AppointmentCell: View {
    //var appointment: Appointment
    
    var body: some View {
        
        HStack(spacing: 16) {
//            Image("image")
//                .resizable()
//                .clipShape(Rectangle())
//                .cornerRadius(10)
//                .frame(width: 65, height: 65)
//            
//            VStack(alignment: .leading, spacing: 4) {
//                Text(appointment.userName)
//                    .font(.headline)
//                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                    .foregroundColor(.primary)
//                
//                Text("\(appointment.date, formatter: itemFormatter) \(appointment.time)")
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//                
//                
//                Text(appointment.isEmergency ? "Emergency" : "General")
//                    .font(.subheadline)
//                    .foregroundColor(appointment.isEmergency ? .red : .green)
//            }
//            Spacer()
//            Button(action: {
//                // Handle tapping the "i" button
//            }) {
//                Image(systemName: "info.circle")
//                    .font(.title2)
//                    .foregroundColor(.blue)
//            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray, lineWidth: 0.25)
        )
    }
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
