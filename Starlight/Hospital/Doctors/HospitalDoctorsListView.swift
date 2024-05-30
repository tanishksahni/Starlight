//
//  HospitalDoctorsListView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 30/05/24.
//

import SwiftUI

struct HospitalDoctorsListView: View {
    var gradColor: Color
    var body: some View {
        ZStack{
            LinearGradient(colors: [
                gradColor.opacity(0.5),
                gradColor.opacity(0.2),
                Color.white,
                Color.white,
                Color.white
            ],
                          
            startPoint: .top,
        endPoint: .bottom)
            .ignoresSafeArea()
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}


