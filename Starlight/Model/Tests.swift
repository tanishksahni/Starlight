//
//  Tests.swift
//  Starlight
//
//  Created by Tanishk Sahni on 31/05/24.
//

import Foundation

import SwiftUI

struct TestCategory: Identifiable {
    var id = UUID()
    var name: String
    var icon: String
    var items: [Tests]
}

struct Tests: Identifiable {
    var id = UUID()
    var name: String
    var icon: String
    var themeColor: Color
}

let testCategories = [
    TestCategory(name: "Medical Diagnosing Imaging", icon: "camera.on.rectangle", items: [
        Tests(name: "X-Ray", icon: "xmark.circle", themeColor: .blue),
        Tests(name: "CT Scan", icon: "wave.3.forward.circle", themeColor: .green),
        Tests(name: "MRI", icon: "waveform.path.ecg", themeColor: .purple)
    ]),
    TestCategory(name: "Specialised Test", icon: "stethoscope", items: [
        Tests(name: "Neurological Test", icon: "brain.head.profile", themeColor: .orange),
        Tests(name: "Endoscopic Procedure", icon: "scope", themeColor: .red),
        Tests(name: "Cardiac Tests", icon: "heart.circle", themeColor: .pink),
        Tests(name: "Cancer Screening", icon: "rectangle.stack.person.crop", themeColor: .yellow)
    ]),
    TestCategory(name: "Laboratory Tests", icon: "testtube.2", items: [
        Tests(name: "Blood Test", icon: "drop.fill", themeColor: .red),
        Tests(name: "Pregnancy Test", icon: "checkmark.shield", themeColor: .blue)
    ])
]


