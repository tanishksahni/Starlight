//
//  MainDoctorView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI

struct MainDoctorView: View {
    @State private var showingLoginView = true
    @State private var isDoctor = true
    @State var isSignUp = false
    
    var body: some View {
        TabView {
            DoctorsHomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            DoctorsAppointmentView()
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
        .sheet(isPresented: $showingLoginView) {
            LoginView(showingLoginView: Binding(get: { showingLoginView ? .login : nil }, set: { showingLoginView = $0 != nil }), isDoctor: $isDoctor)
        }
    }
}

#Preview {
    MainDoctorView()
}


