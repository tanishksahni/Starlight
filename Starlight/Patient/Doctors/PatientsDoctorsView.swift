//
//  PatientsDoctorsView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI

struct PatientsDoctorsView: View {
    
    @State private var searchText = ""
    
    // MARK: DOCTOR CATEGORY FILTERING
//    var filteredCategories: [DoctorCategory] {
//        if searchText.isEmpty {
//            
//            return categories
//        } else {
//            
//            return categories.map { category in
//                let filteredItems = category.items.filter { doctor in
//                    doctor.name.localizedCaseInsensitiveContains(searchText)
//                }
//                return DoctorCategory(id: category.id, name: category.name, icon: category.icon, items: filteredItems)
//            }
//        }
//    }
    
    
    var body: some View {
        NavigationView {
            
            List {
//                ForEach(filteredCategories) { category in
//                    if !category.items.isEmpty {
//                        Section(header: Text(category.name)) {
//                            ForEach(category.items) { doctor in
//                                NavigationLink(destination: HospitalDoctorsListView(gradColor: doctor.themeColor.mainColor, category: doctor.name)){
//                                    HStack {
//                                        Image(systemName: doctor.icon)
//                                            .foregroundColor(doctor.themeColor.mainColor)
//                                            .font(.title3)
//                                            .frame(width: 40, height: 40)
//                                        Text(doctor.name)
//                                            .font(.title3)
//                                            .fontWeight(.regular)
//                                        //                                        Spacer()
//                                        //                                            .foregroundColor(.gray)
//                                    }
//                                    .padding(.vertical, 5)
//                                }
//                            }
//                        }
//                    }
//                }
            }
            
            // MARK: Navigation Part
            .navigationTitle("Doctors")
            
            .listStyle(InsetGroupedListStyle())
            
            .searchable(text: $searchText)
            
        }
    }
}

#Preview {
    PatientsDoctorsView()
}
