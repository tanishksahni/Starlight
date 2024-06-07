//
//  TimeSlotViewModel.swift
//  Starlight
//
//  Created by Tanishk Sahni on 07/06/24.
//

import Foundation

class DoctorSlotsViewModel: ObservableObject {
    @Published var timeSlots: [TimeSlot] = []
    
    func fetchDoctorSlots() {
        guard let url = URL(string: "\(APICore().BASEURL)/doctor/665971767e9cc67a59b29f0e/slots?date=2024-06-03") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer YOUR_AUTHORIZATION_TOKEN", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                do {
                    let timeSlotResponse = try decoder.decode(TimeSlotResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.timeSlots = timeSlotResponse.timeSlots
                    }
                } catch {
                    print("Error decoding response: \(error)")
                }
            } else if let error = error {
                print("HTTP Request failed: \(error)")
            }
        }.resume()
    }
}
