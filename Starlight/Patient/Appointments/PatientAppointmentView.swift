//
//  PatientAppointmentView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 31/05/24.
//

import SwiftUI

struct PatientAppointmentView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationView {
             ScrollView {
                 VStack(spacing: 10) {
                     ForEach(patientAppointments) { appointment in
                         NavigationLink(destination: PatientAppointmentCompleteView()) {
                             AppointmentCardView(appointment: appointment)
                         }
                       
                     }
                 }
                 .padding(.horizontal)
             }
             .navigationTitle("Appointments")
             .searchable(text: $searchText, prompt: "Search Appointments")
             
         }
     }
 }

 struct AppointmentCardView: View {
     let appointment: PatientAppointment
     
     var body: some View {
         VStack(alignment: .leading, spacing: 10) {
             HStack {
                 Image(appointment.imageName)
                     .resizable()
                     .frame(width: 65, height: 65)
                     .cornerRadius(10)
                 Spacer().frame(width: 20)
                 VStack(alignment: .leading) {
                     HStack {
                         Text(appointment.doctorName)
                             .font(.headline)
                             .foregroundColor(.primary)
                         Spacer()
                         Text(appointment.specialty.uppercased(with: .autoupdatingCurrent))
                             .font(.caption)
                             .fontWeight(.semibold)
                             .foregroundColor(appointment.themeColor)
                     }
                     Text(appointment.degree)
                         .font(.subheadline)
                         .foregroundColor(.gray)
                 }
                 Spacer()
             }
             Divider()
                 .padding(.vertical, 2)
             HStack {
                 
                 Text(appointment.date)
                     .font(.caption)
                     .foregroundColor(.primary)
                 Spacer()
                 Text(appointment.time)
                     .font(.caption)
                     .foregroundColor(.primary)
             }
         }
         .padding(12)
         .background(Color(UIColor.systemBackground))
         .cornerRadius(10)
         .shadow(radius: 1)

         
     }
 }

#Preview {
    PatientAppointmentView()
}
