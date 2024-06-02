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
    
    @State private var bloodGroup = ""
    @State private var address = ""
    @State private var dob = Date()
    @State private var selectedGender = ""
    
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
                isSignup = .none
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
}
