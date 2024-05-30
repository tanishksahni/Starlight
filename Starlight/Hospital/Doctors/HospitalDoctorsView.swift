//
//  ContentView.swift
//  list
//
//  Created by Rajit chaudhary on 29/05/24.
//
import SwiftUI

struct DoctorCategory: Identifiable {
    var id = UUID()
    var name: String
    var icon: String
    var items: [Doctor]
}

struct Doctor: Identifiable {
    var id = UUID()
    var name: String
    var icon: String
    var themeColor: Theme
}


struct HospitalDoctorsView: View {
    @State private var searchText = ""
    @State private var showingAddDoctorView = false
    
    
    let categories = [
        DoctorCategory(name: "General Health Care", icon: "", items: [
            Doctor(name: "General Physicians", icon: "person.2.fill", themeColor: .indigo),
            Doctor(name: "Paediatricians", icon: "figure.and.child.holdinghands", themeColor: .seafoam)
        ]),
        DoctorCategory(name: "Special Medical Care", icon: "", items: [
            Doctor(name: "Cardiologists", icon: "heart.fill", themeColor: .poppy),
            Doctor(name: "Orthopaedic", icon: "figure.walk", themeColor: .periwinkle),
            Doctor(name: "ENT Specialists", icon: "ear.fill", themeColor: .orange),
            Doctor(name: "Pulmonologists", icon: "lungs.fill", themeColor: .oxblood),
            Doctor(name: "Neurologists", icon: "brain.head.profile", themeColor: .buttercup)
        ]),
        DoctorCategory(name: "Dental Health", icon: "", items: [
            Doctor(name: "Dentists", icon: "mouth", themeColor: .teal)
        ]),
        DoctorCategory(name: "Mental Health", icon: "", items: [
            Doctor(name: "Psychiatrists", icon: "brain", themeColor: .lavender)
        ]),
        DoctorCategory(name: "Women Health", icon: "", items: [
            Doctor(name: "Gynaecologists", icon: "leaf.fill", themeColor: .purple)
        ])
    ]
    

    // MARK: DOCTOR CATEGORY FILTERING
    var filteredCategories: [DoctorCategory] {
        if searchText.isEmpty {
            
            return categories
        } else {
            
            return categories.map { category in
                let filteredItems = category.items.filter { doctor in
                    doctor.name.localizedCaseInsensitiveContains(searchText)
                }
                return DoctorCategory(id: category.id, name: category.name, icon: category.icon, items: filteredItems)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(filteredCategories) { category in
                    if !category.items.isEmpty {
                        Section(header: Text(category.name)) {
                            ForEach(category.items) { doctor in
                                NavigationLink(destination: HospitalDoctorsListView(gradColor: doctor.themeColor.mainColor)){
                                    HStack {
                                        Image(systemName: doctor.icon)
                                            .foregroundColor(doctor.themeColor.mainColor)
                                            .font(.title3)
                                            .frame(width: 40, height: 40)
                                        Text(doctor.name)
                                            .font(.title3)
                                            .fontWeight(.regular)
//                                        Spacer()
//                                            .foregroundColor(.gray)
                                    }
                                    .padding(.vertical, 5)
                                }
                            }
                        }
                    }
                }
            }
            
            // MARK: Navigation Part
            .navigationTitle("Doctors")
            
            .listStyle(InsetGroupedListStyle())
            
            .searchable(text: $searchText)
            
            .toolbar {
                
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddDoctorView = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $showingAddDoctorView) {
                AddDoctorView()
            }
        }
    }
}



// MARK: DoctorDetailView
struct DoctorDetailView: View {
    var doctor: Doctor
    
    var body: some View {
        Text("Details for \(doctor.name)")
            .font(.largeTitle)
            .navigationTitle(doctor.name)
    }
}

#Preview {
    HospitalDoctorsView()
}



enum Theme: String {
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
    
    var accentColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow: return .black
        case .indigo, .magenta, .navy, .oxblood, .purple: return .white
        }
    }
    
    var mainColor: Color {
        Color(rawValue)
    }
    
    var name: String {
        rawValue.capitalized
    }

}
