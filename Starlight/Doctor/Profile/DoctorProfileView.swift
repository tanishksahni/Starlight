//
//  DoctorProfileVie.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI

struct DoctorProfileView: View {
    
    private var doctor = Authentication().currentDoctor
    
    var body: some View {
        NavigationStack{
            List {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 65, height: 65)
                            .clipShape(Circle())
                        Spacer().frame(width: 20)
                        VStack(alignment: .leading) {
                            Text("\(doctor?.userId.firstName ?? "") \(doctor?.userId.lastName ?? "")")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text(doctor?.qualification ?? "")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                    }
                    
                    Divider()
                    
                    HStack{
                        Text("Doctor Id")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        Spacer()
                        Text(doctor?.id ?? "")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(2)
                }
                
                
                Section{
                    HStack{
                        Text("Specialization")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(doctor?.specialization ?? "")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    
                }
                Section {
                    
                    HStack{
                        Text("License Information")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(doctor?.licenseNo ?? "")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                }
                
                
                
                Section(header: Text("Contact Information")) {
                    
                    HStack{
                        Text("Email")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(doctor?.userId.email ?? "")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
//                    HStack{
//                        Text("Mobile")
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                        Spacer()
//                        Text("7900073075")
//                            .font(.subheadline)
//                            .foregroundColor(.primary)
//                    }
                    
                }
                Button(action: {
                    // Handle logout action here
                    Authentication.shared.currentDoctor = nil
                }) {
                    HStack {
                        Spacer()
                        Text("Logout")
                            .font(.subheadline)
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
            
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Profile")
    }
}
}

#Preview {
    DoctorProfileView()
}

