//
//  AppointmentResultView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 31/05/24.
//

import SwiftUI

struct DoctorPatientInfoView: View {
    var data: Patient
    @State private var patientAppointments: [Appointment]? = nil
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
    
                HStack {
                    AsyncImage(url: URL(string: "")){
                        image in image
                            .resizable()
                            .scaledToFit()
                            .clipShape(Rectangle())
                            .cornerRadius(8)
                            .frame(width: 80, height: 80)
                    }placeholder: {
                        Image(systemName: "person.circle.fill")
                                .resizable()
                                .clipShape(Circle())
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                    }
//                    Image("image")
//                        .resizable()
//                        .clipShape(Rectangle())
//                        .cornerRadius(8)
//                        .frame(width: 80, height: 80)
                    Spacer().frame(width: 20)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(data.userId.firstName) \(data.userId.lastName)")
                            .font(.title2)
                            .fontWeight(.medium)
                        Text(data.patientID)
                            .font(.subheadline)
                    }
                }
                VStack(spacing: 10) {
                    HStack {
                        Text("Age")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(Authentication().calculateAge(from: data.dob))")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical ,8)
                    Divider()
                    HStack {
                        Text("Gender")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                
                        Text("\(data.userId.gender)")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical ,8)
                    Divider()
                    HStack {
                        Text("Date of birth")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(Authentication().formatDOB(dobString: data.dob))")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical ,8)
                    Divider()
                    HStack {
                        Text("Total Appointments")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("4")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical ,8)
                    
                    Divider()
                }
                
                
                Text("Appointments")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 12)
                VStack(spacing: 12) {
                    ForEach(patientAppointments ?? []) { data in
                        NavigationLink(destination: AppointmentInfo(data: data)) {
                            AppointmentForPatientCard(data: data)
                        }
                        
                    }
                }
                
            }
            .navigationTitle("Patient Information")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .padding()
        .scrollIndicators(.hidden)
        .onAppear{
            PatientModel.shared.fetchAppointments(patientId:self.data.id){result in
                switch(result){
                case .success(let appointments):
                    self.patientAppointments = appointments
                    print(self.patientAppointments ?? [])
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
}


struct AppointmentInfo: View {
    var data: Appointment?
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                Text("Appointment Information")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                HStack {
                    Text("Date of Appointment")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(dateFormatter.string(from: data?.dateAndTime ?? Date()))
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                .padding(.vertical ,8)
                Divider()
                HStack {
                    Text("Time of Appointment")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(timeFormatter.string(from: data?.dateAndTime ?? Date()))
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                .padding(.vertical ,8)
                
                Divider()
                Spacer().frame(height: 20)
                Text("Diagnosis")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.bottom, 8)
                    .foregroundColor(.primary)
                
                Text(data?.diagnosis ?? "")
                    .font(.callout)
                    .foregroundColor(.primary)
                    .padding(.bottom,16)
                
                Text("Prescription")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.bottom, 8)
                    .foregroundColor(.primary)
                
                Text(data?.prescription ?? "")
                    .font(.callout)
                    .foregroundColor(.primary)
                    .padding(.bottom, 8)
            }
            .padding()
        }
    }
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    func formatdate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let dateObj = dateFormatter.date(from: date) else {
            print("Invalid date format")
            return "Invalid date"
        }
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let formattedDate = dateFormatter.string(from: dateObj)
        
        return formattedDate
    }
}

struct AppointmentForPatientCard: View {
    var data: Appointment?
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(data?.feesType?.type ?? "")
                    .fontWeight(.heavy)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                Text(formattedDate(date: data?.dateAndTime ?? Date()))
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(.primary)
            }
            Spacer()
            Text(data?.status ?? "")
                .foregroundColor(.green)
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12).stroke(Color.primary, lineWidth: 0.25)
        }
    }
    func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        return formatter.string(from: date)
    }
}
