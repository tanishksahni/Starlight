//
//  HospitalDoctorsListView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 30/05/24.
//

import SwiftUI

struct HospitalDoctorsListView: View {
 
    @State private var searchText = ""
    var gradColor: Color
    var category: String
    var body: some View {
        NavigationLink(destination: PatientDoctorProfileView()) {
            ZStack{
                LinearGradient(colors: [
                    gradColor.opacity(0.5),
                    gradColor.opacity(0.2),
                    Color.clear,
                    Color.clear,
                    Color.clear
                ], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                
                
                ScrollView {
                    VStack{
                        DoctorCard()
                        DoctorCard()
                    }
                    .padding()
                }
                
            }
            .navigationTitle(category)
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)
            
        }
        
    }
}



struct DoctorCard: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image("image")
                    .resizable()
                    .frame(width: 65, height: 65)
                    .clipShape(RoundedRectangle(cornerRadius: 12 ))
                
                Spacer().frame(width: 20)
                VStack(alignment: .leading) {
                    Text("Dr. Rajib Ghose")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text("MBBS")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    //                    Text("25+ yrs ")
                    //                        .foregroundColor(.gray)
                    //                        .italic()
                }
            }
            .padding(.bottom, 4)
            
            
            Divider()
                .padding(.bottom, 4)
            HStack {
                Text("Mon - Fri")
                    .font(.caption)
                Spacer()
                Text("9:00AM - 1:00PM")
                    .font(.caption)
            }
        }
        .foregroundColor(Color.primary)
        .padding(12)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.secondary.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}
