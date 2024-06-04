//
//  Theme.swift
//  Starlight
//
//  Created by Tanishk Sahni on 03/06/24.
//

import SwiftUI

enum Theme: String {
    case red
    case indigo
    case green
    case yellow
    case blue
    case orange
    case purple
    case teal
    case pink
    case brown
    case gray
    
    var accentColor: Color {
        switch self {
        case .red, .green, .yellow, .blue, .orange, .teal, .pink: return .black
        case .indigo, .purple, .brown, .gray: return .white
        }
    }
    
    var mainColor: Color {
        Color(rawValue)
    }
    
    var name: String {
        rawValue.capitalized
    }
}

