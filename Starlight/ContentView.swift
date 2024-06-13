//
//  ContentView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 23/05/24.
//

import SwiftUI



struct ContentView: View {
    @ObservedObject var authentication = Authentication.shared
    var body: some View {
        Group{
            if APICore.shared.accessToken != nil {
                if authentication.userType == .patient {
                    MainPatientView()
                } else if authentication.userType == .doctor {
                    MainDoctorView()
                } else if authentication.userType == .user{
                    MainHospitalView()
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
//            else {
//                
//            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


