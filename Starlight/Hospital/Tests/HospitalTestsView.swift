//
//  HospitalTestsView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI

struct HospitalTestsView: View {
    @State private var searchText = ""
    
    var filteredCategories: [TestCategory] {
        if searchText.isEmpty {
            return testCategories
        } else {
            return testCategories.map { category in
                let filteredItems = category.items.filter { test in
                    test.name.localizedCaseInsensitiveContains(searchText)
                }
                return TestCategory(id: category.id, name: category.name, icon: category.icon, items: filteredItems)
            }
            .filter { !$0.items.isEmpty } // Remove categories with no matching items
        }
    }
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(filteredCategories) { category in
                    Section(header: Text(category.name)) {
                        ForEach(category.items) { test in
                            HStack {
                                Image(systemName: test.icon)
                                    .font(.title3)
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(test.themeColor)
                                Text(test.name)
                                    .font(.title3)
                                    .fontWeight(.regular)
                                Spacer()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Tests")
            .searchable(text: $searchText)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing, content: {
                    Image(systemName: "plus")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                })
            }
        }
    }
}
