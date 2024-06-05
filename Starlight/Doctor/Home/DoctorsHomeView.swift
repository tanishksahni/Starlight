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
            ScrollView{
                VStack{
                    WorkingInfoCard()
                    
                    NavigationLink(destination: DoctorAppointmentCompleteView()) {
                        CurrentAppointmentCard()
                    }
                   
                        
                    
                    Spacer()
                    
                }
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
                   Text("Edit")
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


struct CurrentAppointmentCard: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .lastTextBaseline) {
                Text("GENERAL")
                    .fontWeight(.heavy)
                    .font(.subheadline)
                    .foregroundColor(.orange)
                
                Spacer()
                
                Text("\(formattedDate())")
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            HStack(spacing: 16) {
                Image("image")
                    .resizable()
                    .clipShape(Rectangle())
                    .cornerRadius(10)
                    .frame(width: 65, height: 65)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .lastTextBaseline) {
                        Text("Harsh Goyal")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.primary)
                        Spacer()
                        Text("#23242")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    
                    Text("20 MALE")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
            }
            Divider()
                .padding(.vertical,4)
            VStack(alignment: .leading) {
                Text("Description")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("The most common health issues are physical inactivity and food, obesity, tobacco, substance abuse,")
                    .font(.caption)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .lineLimit(2)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        .safeAreaPadding()
        
    }
    func formattedDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        return formatter.string(from: date)
    }
}
