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
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(appointments.indices, id: \.self) {index in
                        AppointmentCell(appointment: appointments[index], isFirst: false)
                    }
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
               
               HStack(spacing: 16) {
                   AsyncImage(url: URL(string: appointment.patientId?.userId.image ?? "")){
                       image in image
                           .resizable()
                           .scaledToFit()
                           .clipShape(Rectangle())
                           .cornerRadius(12)
                           .frame(width: 65, height: 65)
                   }placeholder: {
                       Image(systemName: "person.circle.fill")
                           .resizable()
                           .foregroundColor(.black)
                           .clipShape(Circle())
                           .scaledToFill()
                           .frame(width: 65, height: 65)
                   }
                   
                   VStack(alignment: .leading, spacing: 4) {
                       Text(appointment.patientId?.userId.firstName ?? "")
                           .font(.headline)
                           .fontWeight(.bold)
                           .foregroundColor(.primary)
                       
                       Text(formattedDate(appointment.dateAndTime))
                           .font(.caption)
                           .foregroundColor(.secondary)
                   }
                   Spacer()
                   NavigationLink(destination: DoctorAppointmentCompleteView(appointment: appointment)) {
                       Image(systemName: "info.circle")
                           .font(.title2)
                           .foregroundColor(.blue)
                   }
               }
               .padding()
               
               
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
           .background(Color(UIColor.white))
           .clipShape(RoundedRectangle(cornerRadius: 12))
           .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray, lineWidth: 0.25)
           )
           .onAppear{
               print("Appoitment card is shown")
           }
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
