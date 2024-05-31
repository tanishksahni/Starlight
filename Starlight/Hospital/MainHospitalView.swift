//
//  SwiftUIView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI

struct MainHospitalView: View {
    var body: some View {
        TabView {
            HospitalHomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            HospitalDoctorsView()
                .tabItem {
                    Label("Doctors", systemImage: "stethoscope")
                }
            HospitalPatientsView()
                .tabItem {
                    Label("Patients", systemImage: "person.2.fill")
                }
            TestsView(isAdmin: true)
                .tabItem {
                    Label("Tests", systemImage: "cross.case.fill")
                }
            HospitalPaymentsView()
                .tabItem {
                    Label("Payments", systemImage: "indianrupeesign.circle.fill")
                }
            
            
        }
    }
}

#Preview {
    MainHospitalView()
}
