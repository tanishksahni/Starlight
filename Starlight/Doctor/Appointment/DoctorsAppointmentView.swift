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
    @State private var appointments: [Appointment] = []
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
                ForEach(appointments) { appointment  in
                    AppointmentCell(appointment: appointment, isFirst: false)
                }
                
            }
            .scrollIndicators(.hidden)
            .navigationBarTitle("Appointments")
            .navigationBarTitleDisplayMode(.large)
            .padding()
            .searchable(text: $searchText)
        }
        .onAppear{
            DoctorModel.shared.fetchAppointments(){appointments in
                if let appointments = appointments{
                    self.appointments = appointments
                    print(appointments)
                    print("appointments fetched")
                }
            }
        }
    }
}



struct AppointmentCell: View {
    let appointment: Appointment
    var isFirst: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.gray)
                VStack(alignment: .leading) {
                    Text(appointment.patientId?.userId.firstName ?? "")
                        .font(.headline)
                    Text(formattedDate(appointment.dateAndTime))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                
                NavigationLink(destination: DoctorAppointmentCompleteView(appointment: appointment)) {
                    Image(systemName: "info.circle")
                        .foregroundColor(.blue)
                }
                
            }
            if isFirst {
                Text("Patient Details")
                    .font(.subheadline)
                    .bold()
                    .padding(.top, 10)
                Text(appointment.desc)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
            }
        }
        .padding()
        .background(Color(UIColor.white))
        .cornerRadius(15)
        .onAppear{
            print("Appoitment card is shown")
        }
        //.shadow(radius: 10)
        //.padding(.horizontal)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
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
