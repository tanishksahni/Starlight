//
//  TypeView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 13/06/24.
//

import SwiftUI

struct WelcomeView: View {
    @State private var navigateToContentView = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                Text("Welcome to Starlight")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("Your health companion app")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing], 40)
                
                Spacer()
                
                NavigationLink(
                    destination: ContentView(),
                    isActive: $navigateToContentView
                ) {
                    Button(action: {
                        navigateToContentView = true
                    }) {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding([.leading, .trailing], 40)
                    }
                }
                
                Spacer()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    WelcomeView()
}
