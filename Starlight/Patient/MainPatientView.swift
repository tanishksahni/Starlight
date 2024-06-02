//
//  MainPatientView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case login
    case signup
    
    var id: Int {
        hashValue
    }
}

struct MainPatientView: View {
    @State private var activeSheet: ActiveSheet? = .signup
    @State private var isDoctor = false
    
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
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .login:
                LoginView(showingLoginView: $activeSheet, isDoctor: $isDoctor)
            case .signup:
                SignUpView(isSignup: $activeSheet)
            }
        }
    }
}
