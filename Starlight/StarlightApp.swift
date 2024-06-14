//
//  StarlightApp.swift
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

@main
struct StarlightApp: App {
    @State private var activeSheet: ActiveSheet? = .none
    @ObservedObject var authentication = Authentication.shared
    @ObservedObject var apiCore = APICore.shared
    
    var body: some Scene {
        WindowGroup {
            if let accessToken = apiCore.accessToken {
                ContentView()
            } else {
                WelcomeView()
                    .onAppear {
                        if APICore.shared.accessToken == nil {
                            activeSheet = .login
                        } else {
                            activeSheet = .none
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
    }
}
