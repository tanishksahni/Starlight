//
//  PastAppointmentView.swift
//  Starlight
//
//  Created by Apple on 13/06/24.
//

import SwiftUI

struct PastAppointmentView: View {
    var appointmentData: [Appointment]?
    
    var body: some View {
        ScrollView {
            VStack {
                if let appointmentData = appointmentData, !appointmentData.isEmpty {
                    ForEach(appointmentData) { datum in
                        NavigationLink(destination: AppointmentInfo()) {
                            AppointmentForPatientCard()
                        }
                    }
                } else {
                    Text("No Appointments!")
                }
            }
        }
    }
}


#Preview {
    PastAppointmentView()
}
