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
    var data: [Doctor]
    
    var body: some View {
      
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
                        ForEach(data) { doctor in
                            NavigationLink(destination: PatientDoctorProfileView(data: doctor)) {
                                DoctorCard(data: doctor)
                            }
                        }
                    }
                    .padding()
                }
                
            }
            .navigationTitle(category)
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)
            
        
        
    }
}



struct DoctorCard: View {
    var data: Doctor
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                AsyncImage(url: URL(string: data.userId.image ?? "")){
                    image in image
                        .resizable()
                        .scaledToFit()
                        .clipShape(Rectangle())
                        .cornerRadius(12)
                        .frame(width: 65, height: 65)
                }placeholder: {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(.black)
                        .clipShape(Circle())
                        .scaledToFill()
                        .frame(width: 65, height: 65)
                }
//                Image("image")
//                    .resizable()
//                    .frame(width: 65, height: 65)
//                    .clipShape(RoundedRectangle(cornerRadius: 12 ))
                
                Spacer().frame(width: 20)
                VStack(alignment: .leading) {
                    Text("\(data.userId.firstName) \(data.userId.lastName)")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text(data.qualification)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding(.bottom, 4)
            
            
            Divider()
                .padding(.bottom, 4)
            HStack {
                Text("\(data.schedule?.rawValue ?? "" )")
                    .font(.caption)
                Spacer()
                Text("\(data.workingHours?.first?.workingHours.from ?? "")-\(data.workingHours?.last?.workingHours.to ?? "")")
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
