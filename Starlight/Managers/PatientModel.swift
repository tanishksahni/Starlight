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

struct BookAppointmentResponse: Codable{
    let message: String?
    let error: String?
}

struct PatientResponse: Codable {
    let message: String
    let patients: [Patient]
}

struct FeesTypeResponse: Codable{
    let fees: [FeesType]
}



struct GetAppointmentResponse: Codable {
    let message: String
    let appointments: [Appointment]
}





class PatientModel: ObservableObject {
    
    static let shared = PatientModel()
    @Published var appointments: [Appointment] = []
    @Published var patients: [Patient] = []
    @ObservedObject var authentication = Authentication.shared
    
    @Published private(set) var accessToken: String? {
        didSet {
            APICore.shared.accessToken = accessToken
            APICore.shared.saveToken(token: accessToken ?? "")
        }
    }
    
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
                print("User created successfully: \(registerResponse.message)")
                print("User created successfully: \(registerResponse.patient)")
                completion(.success(()))
            } catch {
                print("Error decoding response: \(error)")
                completion(.failure(error))
            }
        }
        
        // Start the data task
        task.resume()
    }
    
    
    //MARK: Get all patient
    func fetchPatients(completion: @escaping (Result<[Patient], Error>) -> Void) {
        guard let url = URL(string: "\(APICore().BASEURL)/patient/") else {
            print("Invalid URL")
            return
        }
        print("I am getting all patients for you.")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjA0ODk5OTBiOTdkZGFkZWNhMWVmMCIsInVzZXJFbWFpbCI6ImFkbWluQHRlc3QuY29tIiwidXNlclJvbGUiOiJhZG1pbiIsImlhdCI6MTcxNzc0NjA1MH0.ndcJmzCAmgZTISdMmcYvrrXED-jBNNl6o6-UrdVYQew"
//        request.setValue("Bearer \(APICore.shared.accessToken)", forHTTPHeaderField: "Authorization")
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed to fetch patients: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let patients = try JSONDecoder().decode(PatientResponse.self, from: data)
                DispatchQueue.main.async {
                    self.patients = patients.patients
                }
                print(patients)
                completion(.success(patients.patients))
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchFees(completion: @escaping ([FeesType]?) -> Void) {
        // Create URL
        guard let url = URL(string: "\(APICore().BASEURL)/admin/fees") else {
            completion(nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Add Authorization header with bearer token
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
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
                    //                    let decoder = JSONDecoder()
                    //                    decoder.dateDecodingStrategy = .iso8601 // Assuming dates are in ISO8601 format
                    let fees = try JSONDecoder().decode(FeesTypeResponse.self, from: data)
                    completion(fees.fees)
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
    
    func bookAppointment(doctorId: String, description: String, dateAndTime:Date, appointmentType:FeesType, completion: @escaping (String?) -> Void){
        
        let url = URL(string: "\(APICore().BASEURL)/appointment")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(DoctorModel().token)", forHTTPHeaderField: "Authorization")

        
        let isoFormatter = ISO8601DateFormatter()
        let dateAndTimeString = isoFormatter.string(from: dateAndTime)
        
        // Encode the FeesType instance to JSON data
        let encoder = JSONEncoder()
        guard let feesTypeData = try? encoder.encode(appointmentType) else {
            completion("Failed to encode feesType")
            return
        }
        
        guard let feesTypeJsonObject = try? JSONSerialization.jsonObject(with: feesTypeData, options: []) as? [String: Any] else {
            completion("Failed to convert feesType to JSON object")
            return
        }

        let patientData: [String: Any] = [
            "desc": description,
            "dateAndTime": dateAndTimeString,
            "doctorId": doctorId,
            "patientId": authentication.currentPatient?.id ?? "" ,
            "feesType": appointmentType.id
        ]
        
        print(patientData)
        
        let jsonData = try! JSONSerialization.data(withJSONObject: patientData, options: [])
        request.httpBody = jsonData
        print(request.httpBody)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to create patient: \(error?.localizedDescription ?? "No data")")
                completion(nil)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                do {
                    let bookAppointmentResponse = try JSONDecoder().decode(BookAppointmentResponse.self, from: data)
                    print("Message: \(bookAppointmentResponse.message)")
                    print("Error \(bookAppointmentResponse.error)")
                    
                    // For the purpose of saving patient details, we assume the patient creation details are saved
                    // in local or dummy data as the response does not ?return Patient details.
                    
                    // Simulating created patient (as the response does not contain full Patient details)
                    completion(bookAppointmentResponse.message)
                } catch {
                    print("Failed to decode response: \(error.localizedDescription)")
                    completion(nil)
                }
            } else {
                print("Failed to create patient with status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                completion(nil)
            }
        }
        task.resume()
        
        
    }
    
    
    //MARK: Get all appointments
    func fetchAppointments( completion: @escaping (Result<[Appointment], Error>) -> Void) {
        guard let url = URL(string: "\(APICore().BASEURL)/appointment/patient/\(authentication.currentPatient?.id ?? "")") else {
            print("Invalid URL")
            return
        }
        print("I am getting all patients for you.")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjA0ODk5OTBiOTdkZGFkZWNhMWVmMCIsInVzZXJFbWFpbCI6ImFkbWluQHRlc3QuY29tIiwidXNlclJvbGUiOiJhZG1pbiIsImlhdCI6MTcxNzc0NjA1MH0.ndcJmzCAmgZTISdMmcYvrrXED-jBNNl6o6-UrdVYQew"
//        request.setValue("Bearer \(APICore.shared.accessToken)", forHTTPHeaderField: "Authorization")
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed to fetch appointments: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
//            print(String(data: data, encoding: .utf8))
            do {
                let appointment = try JSONDecoder().decode(GetAppointmentResponse.self, from: data)
                DispatchQueue.main.async {
                    self.appointments = appointment.appointments
                }
                print("This is appointment data")
                print(appointment)
                print("This is appointment data")
                completion(.success(appointment.appointments))
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
    
}

