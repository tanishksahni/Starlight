//
//  DoctorAppointmentView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 31/05/24.
//

import SwiftUI
import Foundation

struct DoctorAppointmentCompleteView: View {
    @State private var diagnosis = ""
    @State private var prescription = ""
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    @State private var patientAppointments: [Appointment]? = nil

    //    @State private var tests = [String]()
    
    var appointment: Appointment?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Patient Information")
                    .font(.title2)
                    .fontWeight(.bold)
                
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
                        Text("\(appointment?.patientId?.userId.firstName ?? "") \(appointment?.patientId?.userId.lastName ?? "")")
                            .font(.title2)
                            .fontWeight(.medium)
                        Text("#\(appointment?.patientId?.patientID ?? "N/A")")
                            .font(.subheadline)
                    }
                }
                
                VStack(spacing: 10) {
                    PatientInfoRow(label: "Age", value: {
                        if let dob = appointment?.patientId?.dob {
                            let formattedDate = formatDOB(dobString: dob)
                            return "\(Authentication().calculateAge(from: formattedDate ?? ""))"  ?? ""
                        } else {
                            return "N/A"
                        }
                    }())
                    PatientInfoRow(label: "Gender", value: appointment?.patientId?.userId.gender.rawValue ?? "N/A")
                    PatientInfoRow(label: "Date of birth", value: formatdate(date: appointment?.patientId?.dob ?? ""))
                    PatientInfoRow(label: "Date of Appointment", value: dateFormatter.string(from: appointment?.dateAndTime ?? Date.now))
                    PatientInfoRow(label: "Time of Appointment", value: timeFormatter.string(from: appointment?.dateAndTime ?? Date()))
                }
                
                HStack {
                    Text("View Previous Appointments")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Spacer()
                    NavigationLink(destination: PastAppointmentView()){
                        Button(action:{
                            PatientModel.shared.fetchAppointments(patientId:self.appointment?.patientId?.id){result in
                                switch(result){
                                case .success(let appointments):
                                    self.patientAppointments = appointments
                                    print(self.patientAppointments)
                                case .failure(let error):
                                    print(error)
                                }
                            }
                        }){
                            Image(systemName: "arrow.up.right.circle")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.vertical, 20)
                
                VStack(alignment: .leading) {
                    Text("Diagnosis")
                        .font(.headline)
                        .fontWeight(.semibold)
                    if appointment?.status == "scheduled" {
                        TextEditor(text: $diagnosis)
                            .padding()
                            .frame(height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.black, lineWidth: 0.5))
                            .padding(.bottom, 16)
                    } else {
                        Text(appointment?.diagnosis ?? "No diagnosis available")
                            .padding()
                            .frame(height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.black, lineWidth: 0.5))
                            .padding(.bottom, 16)
                    }
                    
                    Text("Prescription")
                        .font(.headline)
                        .fontWeight(.semibold)
                    if appointment?.status == "scheduled" {
                        TextEditor(text: $prescription)
                            .padding()
                            .frame(height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.black, lineWidth: 0.5))
                    } else {
                        Text(appointment?.prescription ?? "No prescription available")
                            .padding()
                            .frame(height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.black, lineWidth: 0.5))
                    }
                    
                    if appointment?.status == "scheduled" {
                        Button(action: {
                            // Submit action
                            DoctorModel.shared.diagnosePatient(prescription: self.prescription, diagnose: self.diagnosis, appointmentId: self.appointment?.id ?? ""){result in
                                switch(result){
                                case .success(let response):
                                    print("diagnosed")
                                    self.alertMessage = "Prescription added"
                                    self.showAlert = true
                                
                                case .failure(let error):
                                    self.alertMessage = "Error: \(error.localizedDescription)"
                                    self.showAlert = true
                                    print("error in adding doctor's prescription and diagnosis.")
                                }
                            }
                        }) {
                            Text("Submit")
                                .padding()
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(.vertical)
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Appointment Information")
        .navigationBarTitleDisplayMode(.inline)
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
    
    func formatDOB(dobString: String, fromFormat: String = "yyyy-MM-dd", toFormat: String = "MMMM dd, yyyy") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensure consistent date parsing
        
        // Set the original format of the DOB string
        dateFormatter.dateFormat = fromFormat
        guard let dateOfBirth = dateFormatter.date(from: dobString) else {
            print("Invalid date format")
            return nil
        }
        
        // Set the desired output format
        dateFormatter.dateFormat = toFormat
        let formattedDOB = dateFormatter.string(from: dateOfBirth)
        return formattedDOB
    }
    
}

struct PatientInfoRow: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 8)
        Divider()
    }
}



//struct TestSelectionView: View {
//    @Binding var selectedTests: [String]
//    @Environment(\.presentationMode) var presentationMode
//
//    let allTests = ["Blood Test", "X-Ray", "MRI", "CT Scan", "Urine Test"]
//
//    var body: some View {
//        NavigationView {
//            List(allTests, id: \.self) { test in
//                Button(action: {
//                    if !selectedTests.contains(test) {
//                        selectedTests.append(test)
//                    }
//                }) {
//                    HStack {
//                        Text(test)
//                        Spacer()
//                        if selectedTests.contains(test) {
//                            Image(systemName: "checkmark")
//                                .foregroundColor(.blue)
//                        }
//                    }
//                }
//            }
//            .navigationBarTitle("Select Tests", displayMode: .inline)
//            .navigationBarItems(trailing: Button("Done") {
//                presentationMode.wrappedValue.dismiss()
//            })
//        }
//    }
//}

