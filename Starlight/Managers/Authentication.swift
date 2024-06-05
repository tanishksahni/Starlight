//
//  Authentication.swift
//  Starlight
//
//  Created by Tanishk Sahni on 02/06/24.
//

import Foundation
import SwiftUI

class APICore: ObservableObject {
    static let shared = APICore()
    @Published var BASEURL = "https://starlight-server-8nit.onrender.com"
    @AppStorage("accessToken") var accessToken: String?
}


struct LoginResponse: Codable {
    let accessToken: String
    let patient: Patient?
    let doctor: Doctor?
    let user: User?
}

class Authentication: ObservableObject {
    static let shared = Authentication()
    
    @Published private(set) var accessToken: String?
    @Published private(set) var userType: UserType? = .patient
    
    enum UserType {
        case patient 
        case doctor
        case user
    }
    
    
    func login(withEmail email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        guard let url = URL(string: "\(APICore().BASEURL)/auth/login") else { return }
        
        print("hey i am being called")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let loginDetails = ["email": email, "password": password]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: loginDetails, options: []) else { return }
        request.httpBody = httpBody
        print("hey i am being called")
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            print("hey i am being called")
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let loginResponse = try decoder.decode(LoginResponse.self, from: data)
                print("hey i am being called")
                
                // Determine user type based on the response
                if let patient = loginResponse.patient {
                    self.userType = .patient
                } else if let doctor = loginResponse.doctor {
                    self.userType = .doctor
                } else if let user = loginResponse.user {
                    self.userType = .user
                }
                
                DispatchQueue.main.async {
                    self.accessToken = loginResponse.accessToken
                    completion(.success(loginResponse))
                }
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    
    
    
    
    
}
