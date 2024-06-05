//
//  Doctor.swift
//  Starlight
//
//  Created by Tanishk Sahni on 03/06/24.
//

import Foundation

class DoctorModel: ObservableObject {
    
    @Published var doctors: [Doctor] = []
    
    
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
        guard let url = URL(string: "\(APICore().BASEURL)/doctor/") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
    
}


// MARK: SPECIALIZATION MODEL
class SpecializationModel: ObservableObject {
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
            // Add more specializations and corresponding icons here
        default: return "star"
        }
        print("hEY hEY")
    }
    
    private func getTheme(for specialization: String) -> Theme {
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
            // Add more specializations and corresponding colors here
        default: return .gray
        }
    }
    
    
    
    
    
    
    
}
