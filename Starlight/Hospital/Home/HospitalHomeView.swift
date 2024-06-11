//
//  HospitalHomeView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI

struct HospitalHomeView: View {
    @StateObject var model = HospitalModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if let standardAppointment = model.fees.first(where: { $0.type == "standard" }),
                       let emergencyAppointment = model.fees.first(where: { $0.type == "emergency" }) {
                        FeesStructure(
                            standardAppointment: standardAppointment,
                            emergencyAppointment: emergencyAppointment,
                            onUpdate: { updatedFee, id in
                                model.updateFees(newAmount: updatedFee.amount, id: id) { result in
                                    switch result {
                                    case .success:
                                        print("Successfully updated fees")
                                        // Refresh the model or handle UI updates here if needed
                                    case .failure(let error):
                                        print("Failed to update fees: \(error.localizedDescription)")
                                    }
                                }
                            }
                        )
                        
                    } else {
                        Text("Loading fees...")
                            .padding()
                    }
                }
                .navigationTitle("Home")
            }
            .onAppear {
                model.getFees { result in
                    switch result {
                    case .success:
                        print("Successfully fetched fees")
                    case .failure(let error):
                        print("Failed to fetch fees: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

#Preview {
    HospitalHomeView()
}

struct FeesStructure: View {
    @State private var isEditing: Bool = false
    @State var standardAppointment: Fees
    @State var emergencyAppointment: Fees
    @State private var standardAppointmentText: String
    @State private var emergencyAppointmentText: String

    var onUpdate: (Fees, String) -> Void

    init(standardAppointment: Fees, emergencyAppointment: Fees, onUpdate: @escaping (Fees, String) -> Void) {
        _standardAppointment = State(initialValue: standardAppointment)
        _emergencyAppointment = State(initialValue: emergencyAppointment)
        _standardAppointmentText = State(initialValue: String(standardAppointment.amount))
        _emergencyAppointmentText = State(initialValue: String(emergencyAppointment.amount))
        self.onUpdate = onUpdate
    }

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Appointment Charges")
                    .foregroundColor(.black)
                    .bold()
                Spacer()
                Button(action: {
                    if isEditing {
                        // Update the values based on text fields
                        if let standardAmount = Double(standardAppointmentText) {
                            standardAppointment.amount = Int(standardAmount)
                            onUpdate(standardAppointment, standardAppointment.id)
                        }
                        if let emergencyAmount = Double(emergencyAppointmentText) {
                            emergencyAppointment.amount = Int(emergencyAmount)
                            onUpdate(emergencyAppointment, emergencyAppointment.id)
                        }
                    }
                    isEditing.toggle()
                }) {
                    Text(isEditing ? "Done" : "Edit")
                }
            }
            Divider()
            
            HStack {
                Text("Standard Appointment")
                    .foregroundColor(.gray)
                Spacer()
                if isEditing {
                    TextField("Standard Appointment", text: $standardAppointmentText)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 50)
                } else {
                    Text("₹ \(standardAppointment.amount)")
                }
            }
            
            HStack {
                Text("Emergency Appointment")
                    .foregroundColor(.gray)
                Spacer()
                if isEditing {
                    TextField("Emergency Appointment", text: $emergencyAppointmentText)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 50)
                } else {
                    Text("₹ \(emergencyAppointment.amount)")
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        .padding()
    }
}
