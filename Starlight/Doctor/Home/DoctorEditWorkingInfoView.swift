//
//  DoctorEditWorkingInfoView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 30/05/24.
//

import SwiftUI

struct DoctorEditWorkingInfoView: View {
    @State private var selectedDay = "Everyday"
    @State private var selectedSlot = "15 min"
    @State private var selectedstart = "9:00 AM"
    @State private var selectedend = "9:00 AM"
    @State private var isTimeSlotPickerVisible = false
    
    let days = ["Everyday", "Mon-Fri"]
    let slots = ["45 min", "30 min", "15 min"]
    let start_times = ["9:00 AM" , "10:00 AM", "11:00 AM" , "12:00 PM", "1:00 PM" , "2:00 PM" , "3:00 PM" , "4:00 PM" , "5:00 PM" , "6:00 PM" , "7:00 PM"]
    let end_times = ["9:00 AM" , "10:00 AM", "11:00 AM" , "12:00 PM", "1:00 PM" , "2:00 PM" , "3:00 PM" , "4:00 PM" , "5:00 PM" , "6:00 PM" , "7:00 PM"]
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 50) {
                VStack {
                    Image(systemName: "calendar")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .fontWeight(.light)
                    
                    Text("Please select your working days")
                        .frame(width: 280)
                        .fontWeight(.semibold)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                }
                .padding(.bottom, 20)
                
                VStack {
                    HStack {
                        Text("Days")
                        Spacer()
                        
                        Picker("Days", selection: $selectedDay) {
                            ForEach(days, id: \.self) { day in
                                Text(day).tag(day)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    Divider()
                    HStack {
                        Text("Slots")
                        Spacer()
                        Picker("Slots", selection: $selectedSlot) {
                            ForEach(slots, id: \.self) { slot in
                                Text(slot).tag(slot)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    Divider()
                    HStack {
                        Text("Start Time")
                        Spacer()
                        Picker("Times", selection: $selectedstart) {
                            ForEach(start_times, id: \.self) { time in
                                Text(time).tag(time)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                    }
                    Divider()
                    HStack {
                        Text("End Time")
                        Spacer()
                        Picker("Times", selection: $selectedend) {
                            ForEach(end_times, id: \.self) { time in
                                Text(time).tag(time)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                    }
                }
                .padding(.horizontal, 20)
                
            }
            .navigationTitle("Update info")
            .toolbarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarLeading, content: {
                    Text("Cancel")
                        .foregroundColor(.blue)
                })
                ToolbarItem(placement: .topBarTrailing, content: {
                    Text("Done")
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                })
            }
        }
    }
}


#Preview {
    DoctorEditWorkingInfoView()
}
