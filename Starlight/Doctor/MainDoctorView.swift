//
//  MainDoctorView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI

struct MainDoctorView: View {
    var body: some View {
        TabView {
            DoctorsHomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            DoctorPatientsView()
                .tabItem {
                    Label("Appointment", systemImage: "mail.stack.fill")
                }
            DoctorPatientsView()
                .tabItem {
                    Label("Patients", systemImage: "person.2.fill")
                }
            DoctorProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}

#Preview {
    MainDoctorView()
}
