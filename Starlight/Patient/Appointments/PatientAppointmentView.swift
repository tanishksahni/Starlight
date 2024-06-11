//
//  PatientAppointmentView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 31/05/24.
//

import SwiftUI

struct PatientAppointmentView: View {
    
    @State private var searchText = ""
    
    @StateObject var patientModel = PatientModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(patientModel.appointments) { appointment in
                        NavigationLink(destination: PatientAppointmentCompleteView(appointment: appointment)) {
                            AppointmentCardView(appointment: appointment)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                patientModel.fetchAppointments { result in
                    switch result {
                    case .success:
                        print("Patients appointments fetched successfully")
                    case .failure(let error):
                        print("Failed to fetch appointments for patient: \(error.localizedDescription)")
                    }
                }
                print(patientModel.fetchAppointments)
            }
            .navigationTitle("Appointments")
            .searchable(text: $searchText, prompt: "Search Appointments")
            
        }
    }
}

struct AppointmentCardView: View {
    var appointment: Appointment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image("image")
                    .resizable()
                    .frame(width: 65, height: 65)
                    .cornerRadius(10)
                Spacer().frame(width: 20)
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(appointment.doctorId?.userId.firstName ?? "") \( appointment.doctorId?.userId.lastName ?? "")")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Spacer()
                        Text("\( appointment.doctorId?.specialization ?? "")".uppercased(with: .autoupdatingCurrent))
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(SpecializationModel.shared.getTheme(for: appointment.doctorId?.specialization ?? "").mainColor)
                    }
                    Text(appointment.doctorId?.qualification ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            Divider()
                .padding(.vertical, 2)
            HStack {
                
                HStack {
                    let dateTime = separateDateAndTime(from: appointment.dateAndTime)
                    Text(dateTime.date)
                        .font(.caption)
                        .foregroundColor(.primary)
                    Spacer()
                    Text(dateTime.time)
                        .font(.caption)
                        .foregroundColor(.primary)
                }
            }
        }
        .padding(12)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 1)
//        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        
        
    }
    
    func separateDateAndTime(from date: Date) -> (date: String, time: String) {
        // Define output formats for date and time
        let outputDateFormat = "yyyy-MM-dd"
        let outputTimeFormat = "HH:mm:ss"
        
        // Create DateFormatter instances for date and time
        let dateOutputFormatter = DateFormatter()
        dateOutputFormatter.dateFormat = outputDateFormat
        dateOutputFormatter.timeZone = TimeZone.current
        
        let timeOutputFormatter = DateFormatter()
        timeOutputFormatter.dateFormat = outputTimeFormat
        timeOutputFormatter.timeZone = TimeZone.current
        
        // Get the date and time strings
        let dateString = dateOutputFormatter.string(from: date)
        let timeString = timeOutputFormatter.string(from: date)
        
        return (date: dateString, time: timeString)
    }
}

#Preview {
    PatientAppointmentView()
}
