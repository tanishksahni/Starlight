//
//  MedicalTest.swift
//  Starlight
//
//  Created by Tanishk Sahni on 31/05/24.
//

import SwiftUI
import Foundation


struct TestCategory: Identifiable {
    var id = UUID()
    var name: String
    var items: [MedicalTestCategory]
}

struct MedicalTest: Identifiable {
    var id = UUID()
    var name: String
    var ageRange: String
    var price: String
}

struct MedicalTestCategory: Identifiable {
    var id = UUID()
    var category: String
    var icon: String
    var color: Theme
    var tests: [MedicalTest]
}

let testCategories = [
    
    
    TestCategory(name: "Medical Diagnosing Imaging", items: [
        MedicalTestCategory(
            category: "X-Ray",
            icon: "xmark.circle",
            color: .teal,
            tests: [
                MedicalTest(name: "Chest X-Ray", ageRange: "All ages", price: "₹500" ),
                MedicalTest(name: "Abdominal X-Ray", ageRange: "All ages", price: "₹150"),
                MedicalTest(name: "Skeletal X-Ray", ageRange: "All ages", price: "₹800"),
                MedicalTest(name: "Dental X-Ray", ageRange: "All ages", price: "₹700"),
                MedicalTest(name: "Extremity X-Ray (e.g., Ankle, Wrist)", ageRange: "All ages", price: "₹400")
            ]
        ),
        MedicalTestCategory(
            category: "CT-Scan",
            icon: "wave.3.forward.circle",
            color: .poppy,
            tests: [
                MedicalTest(name: "Head CT Scan", ageRange: "All ages", price: "₹2000"),
                MedicalTest(name: "Abdominal CT Scan", ageRange: "All ages", price: "₹2500"),
                MedicalTest(name: "Chest CT Scan", ageRange: "All ages", price: "₹3000"),
                MedicalTest(name: "Pelvic CT Scan", ageRange: "All ages", price: "₹3500")
            ]
        ),
        MedicalTestCategory(
            category: "MRI",
            icon: "waveform.path.ecg",
            color: .magenta,
            tests: [
                MedicalTest(name: "Brain MRI", ageRange: "All ages", price: "₹2500"),
                MedicalTest(name: "Spine MRI", ageRange: "All ages", price: "₹3000"),
                MedicalTest(name: "Joint MRI (e.g., Knee, Shoulder)", ageRange: "All ages", price: "₹3500"),
                MedicalTest(name: "Pelvic MRI", ageRange: "All ages", price: "₹4000")
            ]
        ),
    ]),
    
    
    TestCategory(name: "Specialised Test", items: [
        MedicalTestCategory(
            category: "Neurological Tests",
            icon: "brain.head.profile",
            color: .sky,
            tests: [
                MedicalTest(name: "Electroencephalogram (EEG)", ageRange: "All ages", price: "₹2000"),
                MedicalTest(name: "Nerve Conduction Study (NCS)", ageRange: "All ages", price: "₹2500"),
                MedicalTest(name: "Electromyography (EMG)", ageRange: "All ages", price: "₹3000"),
                MedicalTest(name: "Visual Evoked Potential (VEP) Test", ageRange: "All ages", price: "₹3500")
            ]
        ),
        MedicalTestCategory(
            category: "Endoscopic Procedures",
            icon: "scope",
            color: .tan,
            tests: [
                MedicalTest(name: "Endoscopy", ageRange: "All ages", price: "₹2000"),
                MedicalTest(name: "Colonoscopy", ageRange: "All ages", price: "₹2500"),
                MedicalTest(name: "Cystoscopy", ageRange: "All ages", price: "₹3000"),
                MedicalTest(name: "Laryngoscopy", ageRange: "All ages", price: "₹3500"),
                MedicalTest(name: "Bronchoscopy", ageRange: "All ages", price: "₹4000")
            ]
        ),
        MedicalTestCategory(
            category: "Cardiac-Tests",
            icon: "heart.circle",
            color: .poppy,
            tests: [
                MedicalTest(name: "Electrocardiogram (ECG or EKG)", ageRange: "All ages", price: "₹500"),
                MedicalTest(name: "Echocardiogram", ageRange: "All ages", price: "₹1000"),
                MedicalTest(name: "Cardiac Stress Test", ageRange: "All ages", price: "₹1500"),
                MedicalTest(name: "Holter Monitor Test", ageRange: "All ages", price: "₹2000")
            ]
        ),
        MedicalTestCategory(
            category: "Cancer Screening",
            icon: "rectangle.stack.person.crop",
            color: .purple,
            tests: [
                MedicalTest(name: "Mammogram", ageRange: "All ages", price: "₹2000"),
                MedicalTest(name: "Pap Smear Test", ageRange: "All ages", price: "₹500"),
                MedicalTest(name: "Prostate Specific Antigen (PSA) Test", ageRange: "All ages", price: "₹1000"),
                MedicalTest(name: "Colon Cancer Screening (e.g., Colonoscopy, Fecal Occult Blood Test)", ageRange: "All ages", price: "₹1500")
            ]
        ),
    ]),
    
    
    TestCategory(name: "Laboratory Tests", items: [
        MedicalTestCategory(
            category: "Blood-Test",
            icon: "drop.fill",
            color: .poppy,
            tests: [
                MedicalTest(name: "Blood Glucose Test", ageRange: "All ages", price: "₹200"),
                MedicalTest(name: "Complete Blood Count (CBC)", ageRange: "All ages", price: "₹300"),
                MedicalTest(name: "Lipid Profile Test", ageRange: "All ages", price: "₹350"),
                MedicalTest(name: "Liver Function Test (LFT)", ageRange: "All ages", price: "₹400"),
                MedicalTest(name: "Kidney Function Test", ageRange: "All ages", price: "₹450"),
                MedicalTest(name: "Thyroid Function Test", ageRange: "All ages", price: "₹500"),
                MedicalTest(name: "Hemoglobin A1c Test", ageRange: "All ages", price: "₹600"),
                MedicalTest(name: "Rheumatoid Factor Test", ageRange: "All ages", price: "₹700"),
                MedicalTest(name: "Autoimmune Antibody Tests", ageRange: "All ages", price: "₹800"),
                MedicalTest(name: "Antinuclear Antibody (ANA) Test", ageRange: "All ages", price: "₹900"),
                MedicalTest(name: "Cortisol Test", ageRange: "All ages", price: "₹1000"),
                MedicalTest(name: "Thyroid Antibody Tests", ageRange: "All ages", price: "₹1100"),
                MedicalTest(name: "Glucose Tolerance Test", ageRange: "All ages", price: "₹1200"),
                MedicalTest(name: "Lactose Intolerance Test", ageRange: "All ages", price: "₹1300")
            ]
        ),
        MedicalTestCategory(
            category: "Pregnancy Tests",
            icon: "checkmark.shield",
            color: .magenta,
            tests: [
                MedicalTest(name: "Ultrasound", ageRange: "All ages", price: "₹500" ),
                MedicalTest(name: "Obstetric Ultrasound", ageRange: "All ages", price: "₹1000"),
                MedicalTest(name: "Doppler Ultrasound", ageRange: "All ages", price: "₹1500"),
                MedicalTest(name: "Nuchal Translucency Test", ageRange: "All ages", price: "₹2000")
            ]
        ),
    ])
]
