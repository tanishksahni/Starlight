//
//  PatientProfileView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI
import Foundation

struct PatientProfileView: View {
    
    @State private var showingLogoutAlert = false
    private var patient = Authentication().currentPatient
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
                                Text("\(patient?.userId.firstName ?? "") \(patient?.userId.lastName ?? "")")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text(patient?.userId.email ?? "")
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
                            Text(patient?.patientID ?? "")
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
                        // Convert dob string to Date
                        
                        
                        Text(formatdate(date: patient?.dob ?? "") ?? "")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, 2)
                    
                    HStack {
                        Text("Age")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("\(Authentication().calculateAge(from: formatdate(date: patient?.dob ?? "") ?? "") ?? 21)")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, 2)
                    
                    HStack {
                        Text("Gender")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(patient?.userId.gender.rawValue ?? "")
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
                        Text(patient?.userId.email ?? "")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, 2)
                    
                    //                    HStack {
                    //                        Text("Mobile no")
                    //                            .font(.subheadline)
                    //                            .foregroundColor(.gray)
                    //                        Spacer()
                    //                        Text(patient?.userId.c)
                    //                            .font(.subheadline)
                    //                            .foregroundColor(.primary)
                    //                    }
                    //                    .padding(.vertical, 2)
                }
                
                
                Button(action: {
                    showingLogoutAlert = true
                    // Restart the app by setting the root view controller
                    
                    
                }) {
                    HStack {
                        Spacer()
                        Text("Logout")
                            .font(.subheadline)
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
                .alert(isPresented: $showingLogoutAlert) {
                    Alert(
                        title: Text("Confirm Logout"),
                        message: Text("Are you sure you want to logout?"),
                        primaryButton: .destructive(Text("Logout")) {
////                            Authentication.shared.logout()
//                            if let window = UIApplication.shared.windows.first {
//                                window.rootViewController = UIHostingController(rootView: ContentView())
//                                window.makeKeyAndVisible()
//                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Profile")
        }
    }
    func formatdate(date: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let dateObj = dateFormatter.date(from: date) else {
            print("Invalid date format")
            return nil
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: dateObj)
        
        return formattedDate
    }
    
    
}

#Preview {
    PatientProfileView()
}

