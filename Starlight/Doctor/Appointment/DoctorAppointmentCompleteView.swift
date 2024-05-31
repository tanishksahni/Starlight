//
//  DoctorAppointmentView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 31/05/24.
//

import SwiftUI

struct DoctorAppointmentCompleteView: View {
    @State private var diagnosis = ""
    @State private var prescription = ""
    @State private var tests = [String]()
    @State private var isTestSelectionPresented = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Patient Information")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                
                HStack {
                    Image("image")
                        .resizable()
                        .clipShape(Rectangle())
                        .cornerRadius(8)
                        .frame(width: 80, height: 80)
                    Spacer().frame(width: 20)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Naman Sharma")
                            .font(.title2)
                            .fontWeight(.medium)
                        Text("#sbhb12hb31")
                            .font(.subheadline)
                    }
                }
                
                
                
                
                VStack(spacing: 10) {
                    HStack {
                        Text("Age")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("21 yrs")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical ,8)
                    Divider()
                    HStack {
                        Text("Gender")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("Male")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical ,8)
                    Divider()
                    HStack {
                        Text("Date of birth")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("27/10/2002")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical ,8)
                    Divider()
                    HStack {
                        Text("Date of Appointment")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("24 May 2024")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical ,8)
                    Divider()
                    HStack {
                        Text("Time of Appointment")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("9:00 AM - 10:00 AM")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical ,8)
                    Divider()
                }
                
                
                
                HStack{
                    Text("View Previous Appointments")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: "arrow.up.right.circle")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.vertical, 20)
                
                VStack(alignment: .leading) {
                    Text("Diagnosis")
                        .font(.headline)
                        .fontWeight(.semibold)
                    TextEditor(text: $diagnosis)
                        .padding()
                        .frame(height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay{
                            RoundedRectangle(cornerRadius: 12).stroke(Color.black ,lineWidth: 0.5)
                        }
                        .padding(.bottom,16)
                    Text("Prescription")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    TextEditor(text: $prescription)
                        .padding()
                        .frame(height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay{
                            RoundedRectangle(cornerRadius: 12).stroke(Color.black ,lineWidth: 0.5)
                        }
                    
                    
                    
                    VStack(alignment: .leading) {
                        
                        HStack{
                            Text("Specified Test")
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            Button(action: {
                                isTestSelectionPresented.toggle()
                            }) {
                                Text("Add Tests")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.vertical)
                        
                        
                        ForEach(tests.indices, id: \.self) { index in
                            HStack {
                                Text(tests[index])
                                Spacer()
                                Button(action: {
                                    tests.remove(at: index)
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(5)
                        }
                        HStack(alignment: .center) {
                            Spacer(minLength: 20)
                            Text("Please add if there are any additional test are to be conducted.")
                                .font(.caption)
                                .foregroundColor(.orange)
                                .multilineTextAlignment(.center)
                            
                            Spacer(minLength: 20)
                        }
                        Button(action: {
                            
                        }) {
                            Text("Submit")
                                .padding()
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(.vertical)
                        
                        
                    }
                    
                }
            }
            .navigationTitle("Appointment Information")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isTestSelectionPresented) {
                TestSelectionView(selectedTests: $tests)
            }
        }
        .padding()
        .scrollIndicators(.hidden)
        
    }
}

struct TestSelectionView: View {
    @Binding var selectedTests: [String]
    @Environment(\.presentationMode) var presentationMode
    
    let allTests = ["Blood Test", "X-Ray", "MRI", "CT Scan", "Urine Test"]
    
    var body: some View {
        NavigationView {
            List(allTests, id: \.self) { test in
                Button(action: {
                    if !selectedTests.contains(test) {
                        selectedTests.append(test)
                    }
                }) {
                    HStack {
                        Text(test)
                        Spacer()
                        if selectedTests.contains(test) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationBarTitle("Select Tests", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    DoctorAppointmentCompleteView()
}
