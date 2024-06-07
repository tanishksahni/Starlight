//
//  HospitalPatientsView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI

struct HospitalPatientsView: View {
    
    @StateObject var patients = PatientModel()
    
    @State private var searchText = ""
    
    //    var filteredCards: [Patient] {
    //        if searchText.isEmpty {
    //            return patients
    //        } else {
    //            return patients.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    //        }
    //    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(patients.patients) { patient in
                        NavigationLink(destination: DoctorPatientInfoView(data: patient)) {
                            PatientCardView(data: patient)
                        }
                        
                        
                    }
                }
                .padding()
            }
            .navigationTitle("Patients")
            .searchable(text: $searchText, prompt: "Search patients")
            
        }
        .onAppear{
            patients.fetchPatients{ result in
                switch result {
                case .success(let doctors):
                    print("Hey getting patients for you")
                case .failure(let error):
                    print("Failed to fetch doctors: \(error.localizedDescription)")
                }}
        }
    }
}


#Preview {
    HospitalPatientsView()
}



