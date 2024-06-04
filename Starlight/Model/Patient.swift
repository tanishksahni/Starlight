//
//  Patient.swift
//  Starlight
//
//  Created by Tanishk Sahni on 31/05/24.
//

import Foundation


//struct Patient: Identifiable {
//    var id = UUID()
//    var name: String
//    var identifier: String
//    var age: String
//    var gender: String
//    var imageName: String
//}
//
//let patients = [
//    Patient(name: "Arvind Kumar", identifier: "#32422", age: "20", gender: "Male", imageName: "image"),
//    Patient(name: "Rajit chaudhary", identifier: "#32423", age: "21", gender: "Male", imageName: "image"),
//    Patient(name: "Ananya Singh", identifier: "#32424", age: "30", gender: "Female", imageName: "image"),
//    Patient(name: "Maya Patel", identifier: "#32425", age: "28", gender: "Female", imageName: "image"),
//    Patient(name: "Ravi Kumar", identifier: "#32426", age: "35", gender: "Male", imageName: "image")
//]
//
//


import Foundation

struct Patient {
    var userId: UUID
    var hospitalId: UUID
    var dob: Date
    var height: Double? // Using Double for numerical fields to allow for decimal values
    var weight: Double?
    var sugar: Double?
    var address: String
    var patientID: String
    
    init(userId: UUID, hospitalId: UUID, dob: Date, height: Double? = nil, weight: Double? = nil, sugar: Double? = nil, address: String, patientID: String) {
        self.userId = userId
        self.hospitalId = hospitalId
        self.dob = dob
        self.height = height
        self.weight = weight
        self.sugar = sugar
        self.address = address.trimmingCharacters(in: .whitespacesAndNewlines) // Trimming whitespace
        self.patientID = patientID.trimmingCharacters(in: .whitespacesAndNewlines) // Trimming whitespace
    }
}
