//
//  LoginView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 01/06/24.
//


import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @Binding var showingLoginView: ActiveSheet?
    @Binding var isDoctor: Bool
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List {
                    Section {
                        VStack(alignment: .center) {
                            Image("logo")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .shadow(radius: 5)
                            
                            Text("Welcome Back to Starlight")
                                .multilineTextAlignment(.center)
                                .fontWeight(.bold)
                                .font(.largeTitle)
                                .padding(.top, 10)
                            
                            Text("Sign in with your email to use Starlight Management services securely.")
                                .multilineTextAlignment(.center)
                                .font(.subheadline)
                                .padding(.top, 10)
                        }
                        .listRowBackground(Color.clear)
                        .frame(maxWidth: .infinity)
                    }
                    .listRowBackground(Color.clear)
                    
                    Section {
                        TextField("Email", text: $email)
                        SecureField("Password", text: $password)
                    }
                    
                    Section {
                        VStack(alignment: .center) {
                            Text("Forgot password?")
                                .foregroundColor(.accentColor)
                            
                            if !isDoctor {
                                Button(action: {
                                    showingLoginView = .signup
                                }) {
                                    Text("Don't have an account? Sign Up")
                                        .foregroundColor(.accentColor)
                                }
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                    .frame(maxWidth: .infinity)
                    .listSectionSpacing(0)
                }
                .listRowBackground(Color.clear)
                
                Button(action: {
                    showingLoginView = nil
                }) {
                    Text("Continue")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.bottom, 20)
                .padding(.horizontal)
            }
        }
        .interactiveDismissDisabled()
    }
}
