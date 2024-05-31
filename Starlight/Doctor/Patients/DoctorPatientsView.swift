//
//  DoctorPatientsView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI

struct DoctorPatientsView: View {
    @State private var searchText = ""
    
    var filteredCards: [Patient] {
        if searchText.isEmpty {
            return patients
        } else {
            return patients.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(patients) { patient in
                        NavigationLink(destination: DoctorPatientInfoView()) {
                            PatientCardView(data: patient)
                        }
                        
                    }
                }
                .padding()
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Patients")
            .searchable(text: $searchText, prompt: "Search patients")
            
        }
    }
}

#Preview {
    DoctorPatientsView()
}
