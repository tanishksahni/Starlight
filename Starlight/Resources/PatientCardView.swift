//
//  PatientCardView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 31/05/24.
//

import SwiftUI

struct PatientCardView: View {
    var data: Patient
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Image("image")
                    .resizable()
                    .clipShape(Rectangle())
                    .cornerRadius(10)
                    .frame(width: 65, height: 65)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .lastTextBaseline) {
                        Text("\(data.userId.firstName) \(data.userId.lastName)")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.primary)
                        Spacer()
                        Text(Authentication().patientIDSuffix(data.patientID) ?? "")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    
                    Text("\(Authentication().calculateAge(from: data.dob))  \(data.userId.gender)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(12)
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
//        .shadow(radius: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray, lineWidth: 0.25)
        )
    }
}
