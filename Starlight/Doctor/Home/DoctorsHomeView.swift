//
//  DoctorsHomeView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI

struct DoctorsHomeView: View {
    var body: some View {
        NavigationStack{
            VStack{
                
                WorkingInfoCard()
                Spacer()
                
                
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    DoctorsHomeView()
}

struct WorkingInfoCard: View {
    @State var isPresentingEditingInfoCard = false
    var body: some View {
        
        VStack(spacing: 10) {
            HStack {
                Text("Working Info")
                    .foregroundColor(.black)
                    .bold()
                Spacer()
                
                Button(action: {
                    isPresentingEditingInfoCard.toggle()
                }) { 
                    Image(systemName: "ellipsis")
                        .foregroundColor(.blue)
                        .bold()
                }
                
                
                .sheet(isPresented: $isPresentingEditingInfoCard) {
                    DoctorEditWorkingInfoView()
                }
                
            }
            Divider()
            
            HStack {
                Text("Days")
                    .foregroundColor(.gray)
                Spacer()
                Text("Mon - Fri")
            }
            HStack {
                Text("Time")
                    .foregroundColor(.gray)
                Spacer()
                Text("9:00AM - 2:00PM")
                
            }
            HStack {
                Text("Slot Duration")
                    .foregroundColor(.gray)
                Spacer()
                Text("30 min")
                
            }
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        .safeAreaPadding()
    }
}
