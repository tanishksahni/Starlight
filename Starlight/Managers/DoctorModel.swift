//
//  Doctor.swift
//  Starlight
//
//  Created by Tanishk Sahni on 03/06/24.
//

import Foundation
import SwiftUI

struct SlotsResponse: Codable{
    let timeSlots:[Slot]
}

class DoctorModel: ObservableObject {
    
    static let shared = DoctorModel()
    
    
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjA0ODk5OTBiOTdkZGFkZWNhMWVmMCIsInVzZXJFbWFpbCI6ImFkbWluQHRlc3QuY29tIiwidXNlclJvbGUiOiJhZG1pbiIsImlhdCI6MTcxNzc0NjA1MH0.ndcJmzCAmgZTISdMmcYvrrXED-jBNNl6o6-UrdVYQew"
    
    @Published var doctors: [Doctor] = []
    
    @ObservedObject var authentication = Authentication.shared
    
    @Published private(set) var accessToken: String? {
        didSet {
            APICore.shared.accessToken = accessToken
        }
    }
    
    
    //MARK: Register a doctor
    
    func registerDoctor(user: User, doctor: Doctor, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(APICore().BASEURL)/doctor/auth/register") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "firstName": user.firstName,
            "lastName": user.lastName,
            "email": user.email,
            "gender": user.gender.rawValue,
            // "dob": ISO8601DateFormatter().string(from: doctor.dob),
            "licenseNo": doctor.licenseNo,
            "specialization": doctor.specialization,
            "experienceYears": doctor.experienceYears ?? 0,
            "qualification": doctor.qualification,
            "duration": doctor.duration
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            print("Failed to serialize request body: \(error.localizedDescription)")
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed to register doctor: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Invalid response")
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            
            completion(.success(()))
        }
        
        task.resume()
    }
    
    
    
    //MARK: Get all doctors
    func fetchDoctors(completion: @escaping (Result<[Doctor], Error>) -> Void) {
        print("this is calling")
        guard let url = URL(string: "\(APICore().BASEURL)/doctor/") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type");
        print("token ", APICore.shared.accessToken)
        
//        request.setValue("Bearer \(APICore.shared.accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed to fetch doctors: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            
//            print("\(response)")
//            print("\(String(data: data  , encoding: .utf8))")
//            
            do {
                let doctors = try JSONDecoder().decode([Doctor].self, from: data)
                DispatchQueue.main.async {
                    self.doctors = doctors
                }
                print(doctors)
                completion(.success(doctors))
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchSlots(doctorId:String, date:Date, completion: @escaping ([Slot]?) -> Void){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        guard let url = URL(string: "\(APICore().BASEURL)/doctor/\(doctorId)/slots?date=\(dateString)") else {
            completion(nil)
            return
        }
        print("\(APICore().BASEURL)/doctor/\(doctorId)/slots?date=\(dateString)")
        // Create URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Add Authorization header with bearer token
        request.addValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        
        // Create URLSessionDataTask
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Check for errors
            guard error == nil else {
                completion(nil)
                return
            }
            
            // Check for response status code
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(nil)
                return
            }
            
            // Parse JSON data into [Doctor] array
            if let data = data {
                do {
                    // Decode the JSON data into an array of Doctor objects
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601 // Assuming dates are in ISO8601 format
                    let slotsResponse = try decoder.decode(SlotsResponse.self, from: data)
                    print(slotsResponse)
                    completion(slotsResponse.timeSlots)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
        
        // Start URLSessionDataTask
        task.resume()
    }
    
}


// MARK: SPECIALIZATION MODEL
class SpecializationModel: ObservableObject {
    static let shared = SpecializationModel()
    
    @Published var specializations: [Specialization] = []
    
    func categorizeDoctors(doctors: [Doctor]) {
        var categories: [String: [Doctor]] = [:]
        
        for doctor in doctors {
            if categories[doctor.specialization] == nil {
                categories[doctor.specialization] = []
            }
            categories[doctor.specialization]?.append(doctor)
        }
        
        let specializations = categories.map { key, value in
            Specialization(name: key, icon: getIcon(for: key), theme: getTheme(for: key), items: value)
        }
        
        self.specializations = specializations
    }
    
    private func getIcon(for specialization: String) -> String {
        switch specialization.lowercased() {
        case "general physicians": return "stethoscope"
        case "paediatricians": return "figure.child"
        case "cardiologist": return "heart.fill"
        case "orthopaedic": return "figure.walk"
        case "ent specialists": return "ear"
        case "pulmonologists": return "lungs.fill"
        case "neurologists": return "brain.head.profile"
        case "dentist": return "tooth"
        case "psychiatrists": return "brain"
        case "gynaecologist": return "female"
        default: return "star"
        }
    }
    
    func getTheme(for specialization: String) -> Theme {
        switch specialization.lowercased() {
        case "general physicians": return .green
        case "paediatricians": return .yellow
        case "cardiologist": return .red
        case "orthopaedic": return .blue
        case "ent specialists": return .orange
        case "pulmonologists": return .teal
        case "neurologists": return .indigo
        case "dentist": return .purple
        case "psychiatrists": return .pink
        case "gynaecologist": return .brown
        default: return .gray
        }
    }
    
    
    
    //MARK:  Working Info - Get Method

//    func getDocWorkinfo(doctorID: String, accessToken: String, completion: @escaping (Result<[Doctor], Error>) -> Void) {
//        
//    }

    
    //MARK:  Working Info - Put Method
    
//    func updateDoctorSlots(doctorID: String, accessToken: String, slotInfo: [String: Any], completion: @escaping (Result<Data?, Error>) -> Void) {
//        guard let url = URL(string: "\(APICore().BASEURL)/doctor/\(doctorID)/slots") else {
//            print("Invalid URL")
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "PUT"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//        
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: slotInfo, options: [])
//        } catch {
//            completion(.failure(error))
//            return
//        }
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            completion(.success(data))
//        }.resume()
//    }
}


