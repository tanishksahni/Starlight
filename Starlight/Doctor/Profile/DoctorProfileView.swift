//
//  DoctorProfileVie.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI

struct DoctorProfileView: View {
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
                            Text("Rajit chaudhary")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Qualification: MBBS ")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                    }
                    
                    Divider()
                    
                    HStack{
                        Text("Date of Joining")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        Spacer()
                        Text("January 1, 2020")
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
                        Text("Cardiologist")
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
                        Text("7567537654362")
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
                        Text("rajit1129.be21@chitkara.edu.in")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    HStack{
                        Text("Mobile")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("7900073075")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    
                }
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    DoctorProfileView()
}

