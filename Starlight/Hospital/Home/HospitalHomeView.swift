//
//  HospitalHomeView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI

struct HospitalHomeView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    FeesStructure()
                }
            }
            .navigationTitle("Home")
        }
       
        
    }
}

#Preview {
    HospitalHomeView()
}


struct FeesStructure: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Appointment Charges")
                    .foregroundColor(.black)
                    .bold()
                Spacer()
                Image(systemName: "ellipsis")
                    .foregroundColor(.blue)
            }
            Divider()

            HStack {
                Text("Standard Appointment")
                    .foregroundColor(.gray)
                Spacer()
                Text("Rs. 500")
            }
            HStack {
                Text("Emergency Appointment")
                    .foregroundColor(.gray)
                Spacer()
                Text("Rs. 750")
                
            }
           
        }
        .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                .safeAreaPadding()
    }
}

