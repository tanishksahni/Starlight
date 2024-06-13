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
            if apiCore.accessToken != nil {
                if authentication.userType == .patient {
                    MainPatientView()
                } else if authentication.userType == .doctor {
                    MainDoctorView()
                } else if authentication.userType == .user {
                    MainHospitalView()
                }
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
