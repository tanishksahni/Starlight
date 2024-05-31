//
//  TestInCategoryView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 31/05/24.
//

import SwiftUI

struct TestInCategoryView: View {
    var categoryName: String
    var data: [MedicalTest]
    var gradColor: Color
    var body: some View {
        ZStack{
            
            LinearGradient(colors: [
                gradColor.opacity(0.5),
                gradColor.opacity(0.2),
                Color.clear,
                Color.clear,
                Color.clear
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            ScrollView{
                VStack{
                    ForEach(data){ data in
                        NavigationLink(destination: CompleteTestView()) {
                            TestInCategoryViewCard(test: data, gradColor: gradColor)
                        }
                        
                    }
                }
                
            }
            .padding()
            .navigationTitle(categoryName)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct TestInCategoryViewCard: View {
    var test: MedicalTest
    var gradColor: Color
    var body: some View {
        VStack{
            HStack(alignment: .center){
                VStack(alignment: .leading){
                    Text(test.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text(test.ageRange)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Text(test.price)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.black, lineWidth: 0.25))
        
        
    }
    
}


struct CompleteTestView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                Text("Test Information")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                
                HStack {
                    Text("Ages")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("All ages")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                .padding(.vertical ,8)
                
                Divider()
                
                HStack {
                    Text("Cost")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\u{20B9} 200")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                .padding(.vertical ,8)
                
                Divider()
                
                Text("Description")
                    .font(.headline)
                    .bold()
                    .padding(.vertical, 12)
                
                VStack(alignment: .leading) {
                    Text("The Urea Test is performed:")
                        .font(.body)
                    Text("1. To estimate the health of the kidneys")
                        .font(.body)
                    Text("2. To diagnose kidney diseases")
                        .font(.body)
                    Text("3. To monitor the efficiency of treatments being used for kidney diseases like dialysis")
                        .font(.body)
                }
                
                
                Text("Purpose")
                    .font(.headline)
                    .bold()
                    .padding(.vertical, 12)
                
                Text("The purpose of X-rays is to diagnose and monitor various medical conditions by creating images of the inside of the body. They are primarily used to detect fractures, infections, and tumors, and to examine the structure and integrity of bones and certain organs.")
                    .font(.body)
                
                
                
                
                Button(action: {
                    
                }) {
                    Text("Book Test Appointment")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("Blood Urea")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .scrollIndicators(.hidden)
    }
}

