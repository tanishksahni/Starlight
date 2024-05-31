//
//  PatientAppointmentBookingConfirmationView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 31/05/24.
//

import SwiftUI

struct PatientAppointmentBookingConfirmationView: View {
    
    @Binding var isShowingConfirmationForAppointment: Bool
    var body: some View {
        NavigationView{
            ZStack {
                Color(red:242/255, green: 242/255, blue: 246/255)
                    .ignoresSafeArea() // Ignore just for the color
                VStack {
                    HStack {
                        Text("Your Appointment is Booked")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding()
                        Image(systemName: "checkmark.seal.fill")
                            .font(.title)
                            .foregroundColor(.green)
                    }
//                    
//                    Text("Details")
//                        .font(.title)
//                        .fontWeight(.bold)
                    
                    List{     ///
                        Section {
                            HStack(alignment: .top, spacing: 14) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .frame(width: 40, height: 40)
                                        .opacity(0.1)
                                    Image(systemName: "person.fill")
                                        .font(.headline)
                                }
                                VStack(alignment: .leading) {
                                    Text("Doctor's Name")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text("Dr. Rajesh Tiwari")
                                }
                            }
                        }
                        Section {
                            HStack(alignment: .top, spacing: 14) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .frame(width: 40, height: 40)
                                        .opacity(0.1)
                                    Image(systemName: "clock.fill")
                                        .font(.headline)
                                }
                                VStack(alignment: .leading) {
                                    Text("Date of Appointment")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    HStack {
                                        Text("January 2, 2024")
                                        Spacer()
                                        Text("10:00 AM")
                                            .fontWeight(.semibold)
                                    }
                                }
                            }
                        }
                        Section {
                            HStack(alignment: .top, spacing: 14) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .frame(width: 40, height: 40)
                                        .opacity(0.1)
                                    Image(systemName: "house.fill")
                                        .font(.headline)
                                }
                                VStack(alignment: .leading) {
                                    Text("Location")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text("Apollo Hospital")
                                }
                            }
                        }
                        Section {
                            HStack(alignment: .top, spacing: 14) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .frame(width: 40, height: 40)
                                        .opacity(0.1)
                                    Image(systemName: "creditcard.fill")
                                        .font(.headline)
                                }
                                VStack(alignment: .leading) {
                                    Text("Consultion Fee")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    HStack {
                                        Text("Rs. 500")
                                        Spacer()
                                        Text("Card")
                                    }
                                }
                            }
                        }
                    }
                    .listSectionSpacing(10)
                    
                }
            }
            .navigationTitle("Booking Information")
                .toolbarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing, content: {
                        Button(action: {
                            isShowingConfirmationForAppointment.toggle()
                        }) {
                            Text("Done")
                                .foregroundColor(.blue)
                                .fontWeight(.bold)

                        }
                    })
                }
        }
    }
}

