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
    @State private var activeSheet: ActiveSheet?
    @ObservedObject var authentication = Authentication.shared
    var body: some View {
        Group{
            if let token = APICore.shared.accessToken {
                if authentication.userType == .patient {
                    MainPatientView()
                } else if authentication.userType == .doctor {
                    MainDoctorView()
                } else if authentication.userType == .user{
                    MainHospitalView()
                } else {
                    
                }
            }
        }
        .onAppear {
                if APICore.shared.accessToken == nil {
                    activeSheet = .login
                }
        }
        .sheet(item: $activeSheet) { sheet in
                switch sheet {
                case .login:
                    LoginView(showingView: $activeSheet)
                case .signup:
                    SignUpView(showingView: $activeSheet)
                }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


