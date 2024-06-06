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
    //    @AppStorage("accessToken") var accessToken: String?
    
    
    //    private let accessTokenKey = "accessToken"
    private let accessTokenKey = "accessToken"
    private let userTypeKey = "userType"
    
    var accessToken: String? {
        get {
            if let data = KeychainHelper.shared.read(forKey: accessTokenKey) {
                return String(data: data, encoding: .utf8)
            }
            return nil
        }
        set {
            if let token = newValue {
                let data = Data(token.utf8)
                KeychainHelper.shared.save(data, forKey: accessTokenKey)
            } else {
                KeychainHelper.shared.delete(forKey: accessTokenKey)
            }
        }
    }

}


struct LoginResponse: Codable {
    let accessToken: String
    let patient: Patient?
    let doctor: Doctor?
    let user: User?
}

class Authentication: ObservableObject {
    static let shared = Authentication()
    
    //@Published private(set) var accessToken: String?
    @Published private(set) var accessToken: String? {
        didSet {
            APICore.shared.accessToken = accessToken
        }
    }
    
    private let userTypeKey = "userType"
    
    @Published private(set) var userType: UserType {
        didSet {
            UserDefaults.standard.set(userType.rawValue, forKey: userTypeKey)
        }
    }
    
    init() {
        self.userType = UserType(rawValue: UserDefaults.standard.string(forKey: userTypeKey) ?? "") ?? .user
    }
    
    enum UserType: String {
        case patient
        case doctor
        case user
    }
    
    func setAccessToken(_ token: String?) {
        self.accessToken = token
    }
    
    func setUserType(_ type: UserType) {
        self.userType = type
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
                print(loginResponse)
                
                DispatchQueue.main.async {
                    if loginResponse.patient != nil {
                        self.userType = .patient
                        print("Patient")
                    } else if loginResponse.doctor != nil {
                        self.userType = .doctor
                        print("Doctor")
                    } else {
                        self.userType = .user
                        print("Admin")
                    }
                    print(self.userType)
                    self.accessToken = loginResponse.accessToken
                    completion(.success(loginResponse))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    
    
    
    
    
}
