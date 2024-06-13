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
                VStack(alignment:.leading, spacing: 20) {
                    HStack{
                        VStack(alignment: .leading,spacing:10) {
                            Text("Total Revenue")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text("₹25000")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.blue)
                        }
                        Spacer()
                        
                        VStack(spacing:20) {
                            Chart{
                                ForEach(viewMonths) { viewmonth in LineMark(x: .value("Month", viewmonth.date, unit: .month),y:.value("Amount", viewmonth.amount))
                                    
                                }
                            }
                            .frame(width: 160)
                        }
                        
                    }
                    .padding()
                    .frame(width:.infinity ,height:150)
                    .background(Color(UIColor.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    
                    HStack(spacing:10){
                        HStack{
                            VStack(alignment: .leading,spacing:15) {
                                Text("Patients")
                                    .font(.headline)
                                    .foregroundStyle(.secondary)
                                Spacer()
                                Text("500")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.blue)
                            }
                            
                            
                            Spacer()
                        }
                        .padding()
                        .frame(height:110)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .background(Color(UIColor.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        
                        HStack {
                            VStack(alignment: .leading,spacing:15) {
                                Text("Doctors")
                                    .font(.headline)
                                    .foregroundStyle(.secondary)
                                Spacer()
                                Text("50")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.blue)
                            }
                            
                            
                            Spacer()
                        }
                        .padding()
                        .frame(height:110)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .background(Color(UIColor.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
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
                            HStack(spacing:25){
                                VStack(alignment:.center, spacing: 10){
                                    HStack {
                                        Text("GENERAL")
                                            .foregroundStyle(.secondary)
                                        .font(.headline)
                                        Spacer()
                                    }
                                    Spacer()
                                    Text("305")
                                        .bold()
                                        .font(.title)
                                        .foregroundStyle(.blue)
                                }
                                .frame(maxWidth: .infinity)
                                Divider()
                                VStack(alignment:.center, spacing: 10){
                                    HStack {
                                        Text("EMERGENCY")
                                            .font(.headline)
                                        .foregroundStyle(.secondary)
                                        Spacer()
                                    }
                                    Spacer()
                                    Text("195")
                                        .bold()
                                        .frame(maxWidth: .infinity)
                                        .font(.title)
                                        .foregroundStyle(.blue)
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
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
                    
                }
                .navigationTitle("Home")
                .safeAreaPadding(.all)
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


