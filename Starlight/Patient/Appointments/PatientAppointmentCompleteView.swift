//
//  PatientAppointmentCompleteView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 01/06/24.
//

import SwiftUI

struct PatientAppointmentCompleteView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Image("image")
                        .resizable()
                        .clipShape(Rectangle())
                        .cornerRadius(8)
                        .frame(width: 80, height: 80)
                    Spacer().frame(width: 20)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Naman Sharma")
                            .font(.title2)
                            .fontWeight(.medium)
                        Text("MBBS/MD")
                            .font(.subheadline)
                    }
                }
                VStack(spacing: 10) {
                    HStack {
                        Text("Licence no.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("231412")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical ,8)
                    Divider()
                    HStack {
                        Text("Specialization")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("Cardiologist")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical ,8)
                    Divider()
                    HStack {
                        Text("Experience")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("20+ yrs")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical ,8)
                    Divider()
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
                }
                
                Spacer().frame(height: 20)
                VStack(alignment: .leading) {
                    Text("Diagnosis")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text("Alzheimer disease is the most common form of dementia that can severely impair day-to-day function. Symptoms of Alzheimer include")
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        .padding(.vertical, 8)
                    
                    Divider()
                        .padding(.vertical ,8)
                    
                    Text("Prescription")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("Alzheimer’s disease is the most common form of dementia that can severely impair day-to-day function. Symptoms of Alzheimer’s include:")
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        .padding(.vertical, 12)
                    
                }
            }
            .navigationTitle("Appointment Information")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .padding()
        .scrollIndicators(.hidden)
        
    }
}


#Preview {
    PatientAppointmentCompleteView()
}

