//
//  HospitalHomeView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI

struct HospitalHomeView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    FeesStructure()
                }
            }
            .navigationTitle("Home")
        }
       
        
    }
}

#Preview {
    HospitalHomeView()
}




struct FeesStructure: View {
    @State private var isEditing: Bool = false
    @State private var standardAppointmentText: String = "500"
    @State private var emergencyAppointmentText: String = "750"

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Appointment Charges")
                    .foregroundColor(.black)
                    .bold()
                Spacer()
                if isEditing{
                    Button(action: {
                        isEditing.toggle()
                    }){
                        Text("Done")
                    }
                }
                else {
                    Button(action: {
                        isEditing.toggle()
                    }){
                        Text("Edit")
                    }
                }
//                Image(systemName: isEditing ? "checkmark.circle.fill" : "pencil.circle.fill")
//                    .foregroundColor(.blue)
//                    .onTapGesture {
//                        isEditing.toggle()
//                    }
            }
            Divider()
            
            HStack {
                Text("Standard Appointment")
                    .foregroundColor(.gray)
                Spacer()
                if isEditing {
                    TextField("Standard Appointment", text: $standardAppointmentText)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 50)
                        
                } else {
                    Text("₹ \(standardAppointmentText)")
                }
            }
            HStack {
                Text("Emergency Appointment")
                    .foregroundColor(.gray)
                Spacer()
                if isEditing {
                    TextField("Emergency Appointment", text: $emergencyAppointmentText)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 50)
                        
                } else {
                    Text("₹ \(emergencyAppointmentText)")
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        .safeAreaPadding()
    }
}
