//
//  HospitalModel.swift
//  Starlight
//
//  Created by Jatin on 10/06/24.
//


import Foundation

struct FeeResponse: Codable {
    var fees: [Fees]
    var message: String
}

struct Fees: Codable {
    var id: String
    var type: String
    var name: String
    var amount: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case type
        case name
        case amount
    }
}

class HospitalModel: ObservableObject {
    
    static let shared = HospitalModel()
    
    @Published var fees: [Fees] = []
    
    func getFees(completion: @escaping (Result<FeeResponse, Error>) -> Void) {
        guard let url = URL(string: "\(APICore.shared.BASEURL)/admin/fees") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue("Bearer \(APICore.shared.accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
              //  let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                //completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decodedFees = try JSONDecoder().decode(FeeResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.fees = decodedFees.fees
                    }
                    completion(.success(decodedFees))
                    print(decodedFees.fees)
                } catch {
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func updateFees(newAmount: Int, id: String, completion: @escaping (Result<Void,Error>) -> Void){
        guard let url = URL(string: "\(APICore.shared.BASEURL)/admin/fees/\(id)") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.addValue("Bearer \(APICore.shared.accessToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Int] = [
            "amount" : newAmount
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
}
