//
//  PatientModel.swift
//  Starlight
//
//  Created by Tanishk Sahni on 04/06/24.
//

import Foundation
import SwiftUI
struct RegisterPatientResponse: Codable {
    let accessToken: String?
    let message: String
    let patient: Patient
}


class PatientModel: ObservableObject {
    @AppStorage("accessToken") var accessToken: String?
    
    // Function to register a patient
    func registerPatient(patient: Patient, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(APICore().BASEURL)/patient/auth/register") else { return }
        
        // Create the patient information dictionary
        let patientInfo: [String: Any] = [
            "firstName": patient.userId.firstName,
            "lastName": patient.userId.lastName,
            "email": patient.userId.email,
            "password": patient.userId.password ?? "",
            "hospitalId": "6658430fbbf58aa09949f466",
            "dob": patient.dob,
            "address": patient.address,
            "gender": patient.userId.gender.rawValue
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            // Serialize the patient information to JSON
            let jsonData = try JSONSerialization.data(withJSONObject: patientInfo, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error serializing JSON: \(error)")
            return
        }
        
        // Create a URLSession data task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making API request: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data in response")
                return
            }
            
            //print("Raw response: \(String(data: data, encoding: .utf8) ?? "No response data")")
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let registerResponse = try decoder.decode(RegisterPatientResponse.self, from: data)
                DispatchQueue.main.async {
                    if let token = registerResponse.accessToken {
                        self.accessToken = token
                    } else {
                        print("No access token in response")
                    }
                }
//                print("User created successfully: \(registerResponse.message)")
//                print("User created successfully: \(registerResponse.patient)")
                completion(.success(()))
            } catch {
                print("Error decoding response: \(error)")
                completion(.failure(error))
            }
        }
        
        // Start the data task
        task.resume()
    }
}

