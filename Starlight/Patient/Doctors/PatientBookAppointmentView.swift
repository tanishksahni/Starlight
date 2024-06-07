import SwiftUI

struct PatientBookAppointmentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedDay: String? = nil
    @State private var selectedSlot: Slot? = nil
    @State private var isAppointmentConfirmed = false // Track appointment confirmation
    @State var selectedDate: Date = Date()
    @State private var isLoading: Bool = true
    var doctor: Doctor? = nil
    
    @State private var desc: String = ""
    @State private var appointmentType: FeesType? = nil
    
    @State private var fees: [FeesType] = []
    
    @Binding var isShowingBookAppointmentView: Bool
    @Binding var isShowingConfirmationForAppointment: Bool
     
    
    private let weekdays = [("Sunday", "S"), ("Monday", "M"), ("Tuesday", "T"), ("Wednesday", "W"), ("Thursday", "T"), ("Friday", "F"), ("Saturday", "S")]
    
    // Sample time slots data
    @State private var timeSlots: [Slot]? = nil
    
    private func getCurrentWeekDates() -> [Date] {
        var calendar = Calendar.current
        calendar.firstWeekday = 1 // Sunday
        let today = Date()
        let startOfToday = calendar.startOfDay(for: today)
        
        let weekInterval = calendar.dateInterval(of: .weekOfYear, for: startOfToday)!
        
        return (0..<7).compactMap {
            if let date = calendar.date(byAdding: .day, value: $0, to: weekInterval.start) {
                return calendar.startOfDay(for: date)
            }
            return nil
        }
    }
    
    private func dateFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    private func dayOfWeek(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        let currentWeekDates = getCurrentWeekDates()
        let today = Calendar.current.startOfDay(for: Date())
        
        NavigationStack {
            List {
                Section(header: Text("Description")) {
                    TextEditor(text: $desc)
                        .multilineTextAlignment(.leading) // Ensures the text is left-aligned
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 90
                        )
                }
                
                

                Section {
                    Picker("Appointment Type", selection: $appointmentType) {
                        ForEach(fees) { data in
                            Text(data.name).tag(data as FeesType?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section {
                    HStack {
                        ForEach(Array(weekdays.enumerated()), id: \.offset) { index, day in
                            let date = currentWeekDates[index]
                            let isPast = date < today
                            
                            VStack {
                                Text(day.1)
                                    .font(.headline)
                                    .foregroundColor(selectedDay == dayOfWeek(date: date) ? .white : .black)
                                    .frame(width: 40, height: 40)
                                    .background(selectedDay == dayOfWeek(date: date) ? Color.blue : Color.clear)
                                    .clipShape(Circle())
                                    .onTapGesture {
                                        if (!isPast) {
                                            selectedDay = dayOfWeek(date: date)
                                            selectedSlot = nil // Clear selected slot when changing the day
                                            selectedDate = date
                                            isLoading = true
                                            self.selectedSlot = nil
                                            DoctorModel.shared.fetchSlots(doctorId: self.doctor?.id ?? "", date: date) { slots in
                                                self.timeSlots = slots
                                                print("Fetched slots: \(slots ?? [])")
                                            }
                                            isLoading = false
                                        }
                                    }
                                    .opacity(isPast ? 0.5 : 1.0)
                                
                                Text(dateFormatter(date: date))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                
                if let selectedDay = selectedDay {
                    let filteredSlots = timeSlots?.filter {
                        dayOfWeek(date: $0.dateAndTime) == selectedDay && $0.isBooked == false
                    } ?? []
                    Section(header: Text("Time Slots for \(selectedDay)")) {
                        if isLoading {
                            VStack(alignment: .center) {
                                ProgressView()
                            }
                        }
                        ForEach(filteredSlots, id: \.id) { slot in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("From")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(slot.from)
                                        .font(.body)
                                }
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text("To")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(slot.to)
                                        .font(.body)
                                }
                                Spacer()
                                if selectedSlot?.id == slot.id {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if !slot.isBooked {
                                    selectedSlot = slot
                                }
                            }
                            .foregroundColor(slot.isBooked ? .gray : .primary)
                            .disabled(slot.isBooked)
                        }
                    }
                } else {
                    Section(header: Text("No date selected")) {
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Choose a day")
                        .font(.headline)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        // Handle Done action
                        PatientModel.shared.bookAppointment(doctorId:self.doctor?.id ?? "", description: self.desc.isEmpty ?"-":self.desc, dateAndTime: selectedSlot?.dateAndTime ?? Date(), appointmentType: self.appointmentType ?? fees[0]){message in
                            if let message = message{
                                print(message)
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                }
            }
            .onAppear {
                isLoading = true
                PatientModel.shared.fetchFees(){fees in
                    if let fees = fees {
                        self.fees = fees
                        print(fees)
                    }
                }
                
                DoctorModel.shared.fetchSlots(doctorId: self.doctor?.id ?? "", date: selectedDate) { slots in
                    self.timeSlots = slots
                    print("Fetched slots: \(slots ?? [])")
                }
                isLoading = false
            }
            
            
            
        }
        
        
    }
    
}


