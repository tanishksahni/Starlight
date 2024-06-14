//
//  DoctorsHomeView.swift
//  Starlight
//
//  Created by Akshat Gulati on 04/06/24.
//

import SwiftUI

struct DoctorsHomeView: View {
    @State private var currentAppointment: Appointment? = nil
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    DoctorBanner()
                    Spacer().frame(height: 16)
                    //Current Appointment Starts Here
                    Spacer().frame(height: 16)
                    Text("Current Appointment")
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                    NavigationLink(destination: DoctorAppointmentCompleteView(appointment: currentAppointment)) {
                        CurrentAppointmentCard(appointment: currentAppointment)
                    }
                    WorkingInfoCard()
                    
                }
            }
            .navigationTitle("Summary")
        }
        .onAppear{
            DoctorModel.shared.fetchAppointments(){appointments in
                if let appointments = appointments{
                    self.currentAppointment = appointments.first
                    print(appointments)
                    print("appointments fetched")
                }
            }
        }
    }
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
                    DoctorEditWorkingInfoView(isPresentingEditingInfoCard: $isPresentingEditingInfoCard)
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
    var appointment: Appointment? = nil
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
                AsyncImage(url: URL(string: appointment?.patientId?.userId.image ?? "")){
                    image in image
                        .resizable()
                        .scaledToFit()
                        .clipShape(Rectangle())
                        .cornerRadius(10)
                        .frame(width: 65, height: 65)
                }placeholder: {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(.black)
                        .clipShape(Circle())
                        .scaledToFill()
                        .frame(width: 65, height: 65)
                }
//                Image("Image")
//                    .resizable()
//                    .clipShape(Rectangle())
//                    .cornerRadius(10)
//                    .frame(width: 65, height: 65)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .lastTextBaseline) {
                        Text("\(appointment?.patientId?.userId.firstName ?? "") \(appointment?.patientId?.userId.lastName ?? "")")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.primary)
                        Spacer()
                        Text("\(appointment?.patientId?.patientID ?? "")")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    
                    Text("\(appointment?.patientId?.userId.gender.rawValue ?? "")")
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
                Text("\(appointment?.desc ?? "")")
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
        .safeAreaPadding(.horizontal, 16)
        //        .safeAreaPadding()
        
    }
    func formattedDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        return formatter.string(from: date)
    }
}



struct DoctorBanner: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Total Patients Served")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                Spacer()
                Text("100")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding()
            .frame(maxWidth: .infinity )
            .background(
                LinearGradient(colors: [
                    Color.green.opacity(0.75),
                    Color.green.opacity(0.6),
                ], startPoint: .top, endPoint: .bottomTrailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .frame(height: 130)
            
            // 2nd Row
            HStack {
                // 1st Horizontal Cell
                VStack(alignment: .leading) {
                    HStack {
                        Text("Today")
                            .foregroundColor(.white)
                            .font(.title3)
//                            .fontWeight(.bold)
                        
                        Spacer()
                        Text("4 June")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text("10")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(colors: [
                        Color.blue.opacity(0.75),
                        Color.blue.opacity(0.6),
                    ], startPoint: .top, endPoint: .bottomTrailing)
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(height: 120)
                
                
                // 2nd Horizontal Cell
                HStack{
                    VStack(alignment: .leading) {
                        Text("Pending")
                            .foregroundColor(.white)
                            .font(.title3)
                            
                        Spacer()
                        Text("10")
                            .font(.title)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    Spacer()
                }
                
                .padding()
                .frame(maxWidth: .infinity)
               
                .background(
                    LinearGradient(colors: [
                        Color.orange.opacity(0.75),
                        Color.orange.opacity(0.6),
                    ], startPoint: .top, endPoint: .bottomTrailing)
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(height: 120)
                
                
            }
        }
        .padding(.horizontal, 16)
    }
}
