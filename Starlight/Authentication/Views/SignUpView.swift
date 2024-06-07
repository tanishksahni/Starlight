//
//  SignUpView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 01/06/24.
//

import SwiftUI
import Foundation

struct SignUpView: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var password = ""
    @Binding var showingView: ActiveSheet?
    
    
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
                            
                            Text("Welcome")
                                .multilineTextAlignment(.center)
                                .fontWeight(.bold)
                                .font(.largeTitle)
                                .padding(.top, 10)
                            
                            Text("Join us today for seamless healthcare management!")
                                .multilineTextAlignment(.center)
                                .font(.subheadline)
                        }
                        .listRowBackground(Color.clear)
                        .frame(maxWidth: .infinity)
                    }
                    .listRowBackground(Color.clear)
                    
                    Section {
                        TextField("First Name", text: $firstName)
                        TextField("Last Name", text: $lastName)
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                        SecureField("Create Password", text: $password)
                    }
                    .padding(.top, 5)
                    
                    Section {
                        Button(action: {
                            showingView = .login
                        }) {
                            Text("Already have a Account? Log In")
                                .foregroundColor(.accentColor)
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listSectionSpacing(0)
                    .frame(maxWidth: .infinity)
                }
                NavigationLink(destination: PatientSetupView(isSignup: $showingView, firstName: firstName, lastName: lastName, email: email, password: password)) {
                    Text("Continue")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
                
            }
        }
        .interactiveDismissDisabled()
    }
}
