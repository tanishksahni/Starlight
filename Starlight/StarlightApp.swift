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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    if APICore.shared.accessToken == nil {
                        activeSheet = .login
                    }
                    else {
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
