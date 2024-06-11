//
//  DoctorEditWorkingInfoView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 30/05/24.
//

import SwiftUI

struct DoctorEditWorkingInfoView: View {
    @State private var selectedDay = "EVERY_DAY"
    @State private var selectedSlot = 15
    @State private var selectedStart = "9:00 AM"
    @State private var selectedEnd = "9:00 AM"
    @State private var isTimeSlotPickerVisible = false
    
    @Binding var isPresentingEditingInfoCard: Bool
    
    var doctor = Authentication.shared.currentDoctor!
    
    let days = ["EVERY_DAY", "MON_SAT"]
    let slots = [15, 30, 45]
    let startTimes = ["9:00 AM", "10:00 AM", "11:00 AM", "12:00 PM", "1:00 PM", "2:00 PM", "3:00 PM", "4:00 PM", "5:00 PM", "6:00 PM", "7:00 PM"]
    let endTimes = ["9:00 AM", "10:00 AM", "11:00 AM", "12:00 PM", "1:00 PM", "2:00 PM", "3:00 PM", "4:00 PM", "5:00 PM", "6:00 PM", "7:00 PM"]

    var formattedSlots: [String] {
        return slots.map { "\($0) min" }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 50) {
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
                            .accentColor(.gray)
                        }
                        Divider()
                        HStack {
                            Text("Slots")
                            Spacer()
                            Picker("Slots", selection: $selectedSlot) {
                                ForEach(slots, id: \.self) { slot in
                                    Text("\(slot) min").tag(slot)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .accentColor(.gray)
                        }
                        Divider()
                        HStack {
                            Text("Start Time")
                            Spacer()
                            Picker("Times", selection: $selectedStart) {
                                ForEach(startTimes, id: \.self) { time in
                                    Text(time).tag(time)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .accentColor(.gray)
                        }
                        Divider()
                        HStack {
                            Text("End Time")
                            Spacer()
                            Picker("Times", selection: $selectedEnd) {
                                ForEach(endTimes, id: \.self) { time in
                                    Text(time).tag(time)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .accentColor(.gray)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .navigationTitle("Update info")
                .toolbarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            isPresentingEditingInfoCard.toggle()
                        }) {
                            Text("Cancel")
                                .foregroundColor(.blue)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            DoctorModel().updateWorkInfo(doctorId: doctor.id, from: selectedStart, to: selectedEnd, duration: selectedSlot, schedule: selectedDay) { result in
                                switch result {
                                case .success(let doctors):
                                    print("Hey, I got your response")
                                case .failure(let error):
                                    print("Failed to update information: \(error.localizedDescription)")
                                }
                            }
                            isPresentingEditingInfoCard.toggle()
                        }) {
                            Text("Done")
                                .foregroundColor(.blue)
                                .fontWeight(.bold)
                        }
                    }
                }
            }
        }
    }
}
