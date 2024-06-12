//
//  HospitalHomeView.swift
//  Starlight
//
//  Created by Jatin on 23/05/24.
//

import SwiftUI
import UIKit
import Charts
struct HospitalHomeView: View {
    @StateObject var model = HospitalModel()
    
    let viewMonths : [ViewMonth] = [
        .init(date: Date.from(year:2023, month: 1, day: 1), amount: 5),
        .init(date: Date.from(year:2023, month: 2, day: 2), amount: 12),
        .init(date: Date.from(year:2023, month: 3, day: 3), amount: 15),
        .init(date: Date.from(year:2023, month: 4, day: 4), amount: 20),
        .init(date: Date.from(year:2023, month: 5, day: 5), amount: 28),
    ]
    
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
                VStack(alignment:.leading, spacing: 20) {
                    // Total Revenue
                    HStack{
                        VStack(alignment: .leading,spacing:10) {
                            Text("Total Revenue")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                            
                            Text("₹25000")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundStyle(.blue)
                        }
                        
                        VStack(spacing:20) {
                            Chart{
                                ForEach(viewMonths) { viewmonth in LineMark(x: .value("Month", viewmonth.date, unit: .month),y:.value("Amount", viewmonth.amount))
                                    
                                    
                                }
                            }
                            .padding(.top,20)
                            .frame(width: .infinity,height:120)
                        }
                        Spacer()
                        
                    }
                    .padding()
                    .frame(width: 355,height:120)
                    .background(Color(UIColor.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 1)
                    
                    HStack(spacing:10){
                        VStack(alignment: .leading,spacing:15) {
                            Text("Patients")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                            
                            Text("500")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundStyle(.blue)
                        }
                        
                        .padding(.trailing,40)
                        .frame(width: 175,height:110)
                        .background(Color(UIColor.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 1)
                        
                        VStack(alignment: .leading,spacing:15) {
                            Text("Doctors")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                            
                            Text("50")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundStyle(.blue)
                        }
                        
                        .padding(.trailing,40)
                        .frame(width: 170,height:110)
                        .background(Color(UIColor.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 1)
                    }
                    HStack{
                        VStack(alignment:.leading){
                            HStack{
                                Text("Appointments")
                                    .font(.headline)
                                    .foregroundStyle(.secondary)
                                
                                Spacer()
//                                Image(systemName: "chevron.right")
//                                    .foregroundColor(.gray)
                            }
                            HStack(spacing:35){
                                VStack(alignment:.center, spacing: 10){
                                    Text("GENERAL")
                                        .foregroundStyle(.secondary)
                                        .font(.headline)
                                    Text("305")
                                        .font(.largeTitle)
                                        .foregroundStyle(.blue)
                                }
                                .frame(maxWidth: .infinity)
                                Divider()
                                VStack(alignment:.center, spacing: 10){
                                    Text("EMERGENCY")
                                        .font(.headline)
                                        .foregroundStyle(.secondary)
                                    
                                    Text("195")
                                        .frame(maxWidth: .infinity)
                                        .font(.largeTitle)
                                        .foregroundStyle(.blue)
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 1)
                    }
                    
                }
                .padding()
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


struct ViewMonth: Identifiable {
    let id = UUID()
    let date: Date
    let amount: Int
}
extension Date{
    static func from(year: Int, month:Int, day:Int) -> Date {
        let components = DateComponents(year:year , month:month, day:day)
        return Calendar.current.date(from:components)!
    }
}


