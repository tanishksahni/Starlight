//
//  MainPatientView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI

struct MainPatientView: View {
    var body: some View {
        TabView {
            PatientHomeView().environmentObject(HealthStore())
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            PatientsDoctorsView()
                .tabItem {
                    Label("Doctors", systemImage: "stethoscope")
                }
            PatientAppointmentView()
                .tabItem {
                    Label("Appointments", systemImage: "mail.stack.fill")
                }
            TestsView(isAdmin: false)
                .tabItem {
                    Label("Tests", systemImage: "cross.case.fill")
                }
            PatientProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}

#Preview {
    MainPatientView()
}
