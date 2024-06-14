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
                AsyncImage(url: URL(string: data.userId.image ?? "")){
                    image in image
                        .resizable()
                        .scaledToFit()
                        .clipShape(Rectangle())
                        .cornerRadius(10)
                        .frame(width: 65, height: 65)
                }placeholder: {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(.black)
                        .clipShape(Circle())
                        .scaledToFill()
                        .frame(width: 65, height: 65)
                }
                
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
                    
                    Text("\(calculateAge(from: data.dob) ?? 0)  \(data.userId.gender)")
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
        .onAppear{
            print(data.dob)
        }
    }
    func calculateAge(from dobString: String) -> Int? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let dateOfBirth = dateFormatter.date(from: dobString) else {
            print("Invalid date format")
            return nil
        }

        let calendar = Calendar.current
        let currentDate = Date()

        let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: currentDate)

        return ageComponents.year
    }
}

#Preview{
    PatientCardView(data: Patient(id: "dasdf", userId: User(id: "sdf", firstName: "Aman", lastName: "aman", email: "sfd", password: "sdf", phone: "sdf", gender: .female, bloodGroup: .ABMinus, role: .doctor), hospitalId: "sdf", dob: "sdfs", height: 34, weight: 43, address: "sdfs", patientID: "sdfsdf"))
}
