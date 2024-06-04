//
//  ContentView.swift
//  list
//
//  Created by Rajit chaudhary on 29/05/24.
//
import SwiftUI

//
//struct Doctor: Identifiable {
//    var id = UUID()
//    var name: String
//    var icon: String
//    var themeColor: Theme
//}
//
//
//let categories = [
//    DoctorCategory(name: "General Health Care", icon: "", items: [
//        Doctor(name: "General Physicians", icon: "person.2.fill", themeColor: .indigo),
//        Doctor(name: "Paediatricians", icon: "figure.and.child.holdinghands", themeColor: .seafoam)
//    ]),
//    DoctorCategory(name: "Special Medical Care", icon: "", items: [
//        Doctor(name: "Cardiologists", icon: "heart.fill", themeColor: .poppy),
//        Doctor(name: "Orthopaedic", icon: "figure.walk", themeColor: .periwinkle),
//        Doctor(name: "ENT Specialists", icon: "ear.fill", themeColor: .orange),
//        Doctor(name: "Pulmonologists", icon: "lungs.fill", themeColor: .oxblood),
//        Doctor(name: "Neurologists", icon: "brain.head.profile", themeColor: .buttercup)
//    ]),
//    DoctorCategory(name: "Dental Health", icon: "", items: [
//        Doctor(name: "Dentists", icon: "mouth", themeColor: .teal)
//    ]),
//    DoctorCategory(name: "Mental Health", icon: "", items: [
//        Doctor(name: "Psychiatrists", icon: "brain", themeColor: .lavender)
//    ]),
//    DoctorCategory(name: "Women Health", icon: "", items: [
//        Doctor(name: "Gynaecologists", icon: "leaf.fill", themeColor: .purple)
//    ])
//]

struct HospitalDoctorsView: View {
    @State private var searchText = ""
    @State private var showingAddDoctorView = false
    
    @StateObject var doctorModel = DoctorModel()
    @StateObject var specializationModel = SpecializationModel()
    
    
    
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
                ForEach(specializationModel.specializations) { specialization in
                    
                    NavigationLink(destination: HospitalDoctorsListView(gradColor: specialization.theme.mainColor, category: specialization.name, data: specialization.items)){
                        HStack {
                            Image(systemName: specialization.icon)
                                .foregroundColor(specialization.theme.mainColor)
                                .font(.title3)
                                .frame(width: 40, height: 40)
                            Text(specialization.name)
                                .font(.title3)
                                .fontWeight(.regular)
                        }
                        .padding(.vertical, 5)
                    }
                    
                }
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
            .onAppear {
                doctorModel.fetchDoctors { result in
                    switch result {
                    case .success(let doctors):
                        specializationModel.categorizeDoctors(doctors: doctors)
                    case .failure(let error):
                        print("Failed to fetch doctors: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}


//
//// MARK: DoctorDetailView
//struct DoctorDetailView: View {
//    var doctor: Doctor
//
//    var body: some View {
//        Text("Details for \(doctor.name)")
//            .font(.largeTitle)
//            .navigationTitle(doctor.name)
//    }
//}

#Preview {
    HospitalDoctorsView()
}



