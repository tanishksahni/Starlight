//
//  PatientBookAppointmentView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 30/05/24.
//

import SwiftUI

struct PatientBookAppointmentView: View {
    @Binding var isShowingBookAppointmentView: Bool
    @Binding var isShowingConfirmationForAppointment: Bool
    
    @State private var isSelectedDay: String = ""
    var body: some View {
        NavigationView{
            ScrollView{
                
                VStack(alignment: .leading) {
                    
                    Text("Choose a Day")
                        .font(.headline)
                    HStack(spacing :45){
                        Text("M")
                        Text("T")
                        Text("W")
                        Text("Th")
                        Text("F")
                        Text("S")
                    }
                    
                    //            .frame(width: 370, height: 45)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    
                    Spacer().frame(height: 25)
                    
                    VStack(alignment: .leading){
                        Text("Choose a time slot")
                            .font(.headline)
                        VStack{
                            HStack{
                                HStack{
                                    Text("From")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Text("9:00 AM")
                                }
                                Spacer()
                                HStack{
                                    Text("To")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    
                                    Text("10:00 AM")
                                }
                                
                                
                                
                                
                            }
                            //                    .frame(width: 370, height: 45)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            
                            HStack{
                                HStack{
                                    Text("From")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Text("10:00 AM")
                                }
                                Spacer()
                                HStack{
                                    Text("To")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    
                                    Text("11:00 AM")
                                }
                                
                                
                                
                                
                            }
                            //                    .frame(width: 370, height: 45)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        }
                        
                    }
                    
                }
                .padding()
            }
            .navigationTitle("Booking Information")
            .toolbarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarLeading, content: {
                    Button(action: {
                        isShowingBookAppointmentView = false
                    }) {
                        Text("Cancel")
                            .foregroundColor(.blue)
                    }
                    
                   
                })
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button(action: {
                        isShowingBookAppointmentView = false
                        isShowingConfirmationForAppointment.toggle()
                    }) {
                        Text("Done")
                            .foregroundColor(.blue)
                            .fontWeight(.bold)

                    }
                })
            }
        }
        .interactiveDismissDisabled()
    }
}


