//
//  ContentView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var authentication = Authentication.shared
    @ObservedObject var apiCore = APICore.shared
    
    var body: some View {
        Group {
            if authentication.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                if let accessToken = apiCore.accessToken, let userType = authentication.userType {
                    switch userType {
                    case .patient:
                        MainPatientView()
                    case .doctor:
                        MainDoctorView()
                    case .user:
                        MainHospitalView()
                    }
                }
            }
        }
        .onAppear {
            print("User Type: \(authentication.userType?.rawValue ?? "No user type")")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
