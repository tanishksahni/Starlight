//
//  PatientProfileView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI

struct PatientProfileView: View {
    var body: some View {
        NavigationView {
            List {
                // Profile Section
                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 65, height: 65)
                                .clipShape(Circle())
                            Spacer().frame(width: 20)
                            VStack(alignment: .leading) {
                                Text("Rajit Chaudhary")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text("rajit1129.be21@chitkara.edu.in")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                            }
                        }
                       
                        Divider()
                        HStack {
                            Text("Patient id")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                            Spacer()
                            Text("45678")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                        .padding(2)
                    }
                }
                
                // General Information Section
                Section(header: Text("General Information")) {
                    
                    HStack {
                        Text("D.O.B")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("01/01/2000")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, 2)
                    
                    HStack {
                        Text("Age")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("20")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, 2)
                    
                    HStack {
                        Text("Gender")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("Male")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, 2)
                }
                
                // Contact Information Section
                Section(header: Text("Contact Information")) {
                    HStack {
                        Text("Email")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("rajit@gmail.com")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, 2)
                    
                    HStack {
                        Text("Mobile no")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("123456789")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, 2)
                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    PatientProfileView()
}

