//
//  Authentication.swift
//  Starlight
//
//  Created by Tanishk Sahni on 02/06/24.
//

import Foundation
import SwiftUI

class APICore: ObservableObject {
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
    
    @Published var accessToken: String? = APICore().accessToken
    
    func login(withEmail email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        guard let url = URL(string: "\(APICore().BASEURL)/auth/login") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let loginDetails = ["email": email, "password": password]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: loginDetails, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let loginResponse = try decoder.decode(LoginResponse.self, from: data)
                DispatchQueue.main.async {
                    self.accessToken = loginResponse.accessToken
                    completion(.success(loginResponse))
                }
                print("Hey U have logined")
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    
    
    
    
    
}
