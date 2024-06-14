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
    //    @Published var BASEURL = "https://vena-server.onrender.com"
    
    //    @Published var BASEURL = "http://localhost:8000"
    //    @AppStorage("accessToken") var accessToken: String?
    
    
    //    private let accessTokenKey = "accessToken"
    private let accessTokenKey = "accessToken"
    private let userTypeKey = "userType"
    
    @Published var accessToken: String?
    //    {
    //        get {
    //            //              if let data = KeychainHelper.shared.read(forKey: accessTokenKey) {
    //            //                  let token = String(data: data, encoding: .utf8)
    //            //                  print("Read token from keychain: \(token ?? "nil")")
    //            //                  return token
    //            //              }
    //            //              print("No token found in keychain")
    //            //              return nil
    //            // Using UserDefaults instead
    //            return UserDefaults.standard.string(forKey: accessTokenKey)
    //        }
    //        set {
    //            //              if let token = newValue {
    //            //                  let data = Data(token.utf8)
    //            //                  KeychainHelper.shared.save(data, forKey: accessTokenKey)
    //            //                  print("Saved token to keychain: \(token)")
    //            //              } else {
    //            //                  KeychainHelper.shared.delete(forKey: accessTokenKey)
    //            //                  print("Deleted token from keychain")
    //            //              }
    //            // Using UserDefaults instead
    //            if let token = newValue {
    //                UserDefaults.standard.set(token, forKey: accessTokenKey)
    //                print("Saved token to UserDefaults: \(token)")
    //            } else {
    //                UserDefaults.standard.removeObject(forKey: accessTokenKey)
    //                print("Deleted token from UserDefaults")
    //            }
    //        }
    //    }
    
    init(){
        self.accessToken = UserDefaults.standard.string(forKey: accessTokenKey)
    }
    
    func saveToken(token: String){
        UserDefaults.standard.set(token, forKey: accessTokenKey)
    }
    
}


struct LoginResponse: Codable {
    let accessToken: String
    let patient: Patient?
    let doctor: Doctor?
    let user: User?
}

class Authentication: ObservableObject {
    
    @Published var primaryAdmin: User? = nil
    @Published var currentDoctor: Doctor? = nil
    @Published var currentPatient: Patient? = nil
    static let shared = Authentication()
    @Published var isLoading: Bool = true
    
    //@Published private(set) var accessToken: String?
    @Published private(set) var accessToken: String? {
        didSet {
            DispatchQueue.main.async {
                print("Setting accessToken in APICore: \(self.accessToken ?? "nil")")
                APICore.shared.accessToken = self.accessToken
                APICore.shared.saveToken(token: self.accessToken ?? "")
            }
        }
    }
    
    private let userTypeKey = "userType"
    
    //    @Published private(set) var userType: UserType {
    //        didSet {
    //            DispatchQueue.main.async {
    //                UserDefaults.standard.set(self.userType.rawValue, forKey: self.userTypeKey)
    //                print("UserType set to: \(self.userType.rawValue)")
    //            }
    //        }
    //    }
    //
    //    init() {
    //        self.userType = UserType(rawValue: UserDefaults.standard.string(forKey: userTypeKey) ?? "") ?? .user
    //        loadUserData()
    //    }
    @Published private(set) var userType: UserType? {
        didSet {
            DispatchQueue.main.async {
                if let userType = self.userType {
                    UserDefaults.standard.set(userType.rawValue, forKey: self.userTypeKey)
                    print("UserType set to: \(userType.rawValue)")
                }
                self.isLoading = false
            }
        }
    }
    
    init() {
           self.userType = UserType(rawValue: UserDefaults.standard.string(forKey: userTypeKey) ?? "")
           loadUserData()
       }
       
    enum UserType: String {
        case patient
        case doctor
        case user
    }
    
    func setAccessToken(_ token: String?) {
        print("Updating accessToken: \(token ?? "nil")")
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
                    if let patient = loginResponse.patient {
                        self.userType = .patient
                        self.currentPatient = patient
                        self.saveUserInformation(user: patient, userType: .patient)
                    } else if let doctor = loginResponse.doctor {
                        self.userType = .doctor
                        print("doctor logged in")
                        self.currentDoctor = doctor
                        self.saveUserInformation(user: doctor, userType: .doctor)
                    } else if let user = loginResponse.user {
                        self.userType = .user
                        self.primaryAdmin = user
                        self.saveUserInformation(user: user, userType: .user)
                    }
                    print("dfsfsdf\n\n")
                    print(self.userType?.rawValue)
                    self.setAccessToken(loginResponse.accessToken)
                    completion(.success(loginResponse))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func saveUserInformation<T: Codable>(user: T, userType: UserType) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: userType.rawValue)
            print("User information saved for type \(userType.rawValue)")
        } else {
            print("Failed to save user information for type \(userType.rawValue)")
        }
    }
    
    // Load current user data from UserDefaults
    func loadUserData() {
        let userTypes: [UserType] = [.patient, .doctor, .user]
        for userType in userTypes {
            if let userData = UserDefaults.standard.data(forKey: userType.rawValue) {
                let decoder = JSONDecoder()
                switch userType {
                case .patient:
                    if let patient = try? decoder.decode(Patient.self, from: userData) {
                        currentPatient = patient
                    }
                case .doctor:
                    if let doctor = try? decoder.decode(Doctor.self, from: userData) {
                        currentDoctor = doctor
                    }
                case .user:
                    if let user = try? decoder.decode(User.self, from: userData) {
                        primaryAdmin = user
                    }
                }
            }
        }
    }
    
    
    
    
    func calculateAge(from dobString: String, withFormat format: String = "yyyy-MM-dd") -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensure consistent date parsing
        
        guard let dateOfBirth = dateFormatter.date(from: dobString) else {
            print("Invalid date format")
            return nil
        }
        
        let calendar = Calendar.current
        let currentDate = Date()
        
        let components = calendar.dateComponents([.year], from: dateOfBirth, to: currentDate)
        
        return components.year
    }
    
    
    
    func formatDOB(dobString: String, fromFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ", toFormat: String = "MMMM dd, yyyy") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensure consistent date parsing
        
        // Set the original format of the DOB string
        dateFormatter.dateFormat = fromFormat
        guard let dateOfBirth = dateFormatter.date(from: dobString) else {
            print("Invalid date format")
            return nil
        }
        
        // Set the desired output format
        dateFormatter.dateFormat = toFormat
        let formattedDOB = dateFormatter.string(from: dateOfBirth)
        return formattedDOB
    }
    
    
    func patientIDSuffix(_ id: String) -> String? {
        guard id.count >= 6 else { return nil }
        return String(id.suffix(6))
    }
    
    
}
