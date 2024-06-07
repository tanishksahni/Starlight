//
//  AppointmentResultView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 31/05/24.
//

import SwiftUI

struct DoctorPatientInfoView: View {
    var data: Patient
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Patient Information")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                
                HStack {
                    Image("image")
                        .resizable()
                        .clipShape(Rectangle())
                        .cornerRadius(8)
                        .frame(width: 80, height: 80)
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
                    ForEach(0..<4) { index in
                        NavigationLink(destination: AppointmentInfo()) {
                            AppointmentForPatientCard()
                        }
                        
                    }
                }
                
                
                
            }
//            .navigationTitle("Patient Information")
//            .navigationBarTitleDisplayMode(.inline)
            
        }
        .padding()
        .scrollIndicators(.hidden)
        
    }
    
}


struct AppointmentInfo: View {
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
                    Text("24 May 2024")
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
                    Text("9:00 AM - 10:00 AM")
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
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make ")
                    .font(.callout)
                    .foregroundColor(.primary)
                    .padding(.bottom,16)
                
                Text("Prescription")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.bottom, 8)
                    .foregroundColor(.primary)
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make")
                    .font(.callout)
                    .foregroundColor(.primary)
                    .padding(.bottom, 8)
            }
            .padding()
        }
    }
}

struct AppointmentForPatientCard: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text("GENERAL")
                    .fontWeight(.heavy)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                Text(formattedDate())
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(.primary)
            }
            Spacer()
            Text("Completed")
                .foregroundColor(.green)
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12).stroke(Color.primary, lineWidth: 0.25)
        }
    }
    func formattedDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        return formatter.string(from: date)
    }
}
