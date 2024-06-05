//
//  ContentView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case login
    case signup
    
    var id: Int {
        hashValue
    }
}

struct ContentView: View {
    @State private var activeSheet: ActiveSheet? = .login
    @State private var showingLoginView: Bool
    private var authentication: Authentication
    
    init() {
        authentication = Authentication()
        showingLoginView = authentication.accessToken == nil
    }
    
    var body: some View {
        Group {
            if let userType = authentication.userType {
                switch userType {
                case .patient:
                    MainPatientView()
                case .doctor:
                    MainDoctorView()
                case .user:
                    MainHospitalView()
                }
            } else {
                // Show a loading view or some other default view until user type is determined
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        //        .sheet(isPresented: $showingLoginView) {
        //            LoginView(showingView: $activeSheet)
        //        }
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .login:
                LoginView(showingView: $activeSheet)
            case .signup:
                SignUpView(showingView: $activeSheet)
            }
        }
        .onAppear {
            // Check if user is logged in on appear
            if authentication.accessToken == nil {
                activeSheet = .login
            } else {
                showingLoginView = false
            }
        }
        
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//@State private var showingLoginView: Bool
//
//   init() {
//       // Initialize showingLoginView based on accessToken status
//       let authentication = Authentication()
//       showingLoginView = authentication.accessToken == nil
//   }
