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
            PatientHomeView()
                .tabItem {
                    Label("Home", systemImage: "heart.fill")
                }
            PatientsDoctorsView()
                .tabItem {
                    Label("Doctors", systemImage: "stethoscope")
                }
            PatientPharmacyView()
                .tabItem {
                    Label("Pharmacy", systemImage: "pill.fill")
                }
            PatientTestsView()
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
