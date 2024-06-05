//
//  PatientSetupView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 02/06/24.
//

import SwiftUI
import Foundation

struct PatientSetupView: View {
    @Binding var isSignup: ActiveSheet?
    @State var firstName: String
    @State var lastName: String
    @State var email: String
    @State var password: String
    @State private var address = ""
    @State private var dob = Date()
    @State private var selectedGender = ""
    
//    @AppStorage("accessToken") private var accessToken: String?
    
    
    let genders = ["Male", "Female", "Other"]
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            List {
                Section(header: Text("Personal Details")) {
                    Picker("Gender", selection: $selectedGender) {
                        ForEach(genders, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    DatePicker("Date of Birth", selection: $dob, displayedComponents: .date)
                    
                    TextField("Address", text: $address)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                }
                
            }
            .listRowBackground(Color.clear)
            
            Button(action: {
                // Handle the action when the button is pressed
//                isSignup = .none
                savePatient()
            }) {
                Text("Done")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .listRowBackground(Color.clear)
            .padding(.horizontal)
            .padding(.bottom, 16)
        }
        .navigationTitle("Setup Account")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    private func savePatient() {
        let user = User(
            id: "",
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            gender: Gender(rawValue: selectedGender.lowercased()) ?? .other
        )
        
        // Convert dob string to Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dobString = dateFormatter.string(from: dob)
        
        
        // Create a Patient object
        let patient = Patient(
            id: "",
            userId: user,
            hospitalId: "",
            dob: dobString,
            address: address,
            patientID: ""
        )
        
        // Register the patient using the API
        
        
        PatientModel().registerPatient(patient: patient) { result in
            switch result {
            case .success:
                print("Patient added successfully")
                isSignup = .none
            case .failure(let error):
                print("Failed to add patient: \(error.localizedDescription)")
            }
        }
    }
    
}
