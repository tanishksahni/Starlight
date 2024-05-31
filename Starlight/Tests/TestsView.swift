//
//  PatientTestsView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI


struct TestsView: View {
    @State  var isAdmin: Bool
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredCategories) { category in
                    Section(header: Text(category.name)) {
                        ForEach(category.items) { medicalCategory in
                            NavigationLink(destination: TestInCategoryView(categoryName: medicalCategory.category ,data: medicalCategory.tests, gradColor: medicalCategory.color.mainColor)){
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: medicalCategory.icon)
                                            .font(.title3)
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(medicalCategory.color.mainColor)
                                        Text(medicalCategory.category)
                                            .font(.title3)
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Tests")
            .searchable(text: $searchText)
            .toolbar{
                if isAdmin {
                    ToolbarItem(placement: .topBarTrailing, content: {
                        Image(systemName: "plus")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    })
                }
            }
        }
    }
    
    var filteredCategories: [TestCategory] {
        if searchText.isEmpty {
            return testCategories
        } else {
            return testCategories.map { category in
                let filteredItems = category.items.map { medicalCategory in
                    let filteredTests = medicalCategory.tests.filter { $0.name.contains(searchText) }
                    return MedicalTestCategory(id: medicalCategory.id, category: medicalCategory.category, icon: medicalCategory.icon, color: medicalCategory.color, tests: filteredTests)
                }.filter { !$0.tests.isEmpty }
                
                return TestCategory(id: category.id, name: category.name, items: filteredItems)
            }.filter { !$0.items.isEmpty }
        }
    }
}


