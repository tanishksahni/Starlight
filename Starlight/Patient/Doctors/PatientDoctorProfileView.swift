//
//  PatientDoctorProfileView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 30/05/24.
//



import SwiftUI

struct PatientDoctorProfileView: View {
    @ObservedObject var authentication = Authentication.shared
    @State private var isShowingBookAppointmentView = false
    @State var isShowingConfirmationForAppointment = false

    @State private var fetchedTimeSlots: [Slot] = []
    private var slotinfo: [String]  = []
    
    var data: Doctor
    @State private var doctorDescription: String = ""

    func getRandomDoctorDescription() -> String {
        let descriptions = [
            "Hey Patients The application should also cater to the needs of a hospital including but not limited to managing shifts, medical inventory, patient history.",
            "I am your friend, specializing in cardiology with over 15 years of experience in treating heart diseases.",
            "I am an expert in orthopedic surgery, dedicated to helping patients recover from injuries and improve their mobility.",
            " A pediatrician committed to providing the best care for children's health and development.",
            "I am Doctor with extensive experience in neurology, focusing on brain and nervous system disorders."
        ]
        return descriptions.randomElement() ?? "I am a doctor with a passion for providing excellent healthcare."
    }

    init(data: Doctor) {
        self.data = data
        _doctorDescription = State(initialValue: getRandomDoctorDescription())
//        fetchTimeSlots(for: Date()) // Call fetchTimeSlots initially
    }

//    private func fetchTimeSlots(for date: Date) {
//        DoctorModel.shared.fetchSlots(doctorId: data.id, date: date) { slots in
//            if let slots = slots {
//                self.fetchedTimeSlots = slots
//            } else {
//                self.fetchedTimeSlots = []
//            }
//        }
//    }

//    private var slotInfo: [String] {
//        fetchedTimeSlots.map { $0. }
//       }
    
    func generateTimeSlots(duration: Int, timeInterval: String) -> [String] {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "HH:mm"
           
           let components = timeInterval.split(separator: "-").map { String($0).trimmingCharacters(in: .whitespaces) }
           
           guard components.count == 2,
                 let startTime = dateFormatter.date(from: components.first!),
                 let endTime = dateFormatter.date(from: components.last!) else {
               return []
           }
           
           var timeSlots: [String] = []
           var currentTime = startTime
           
           while currentTime.addingTimeInterval(TimeInterval(duration * 60)) <= endTime {
               let nextTime = currentTime.addingTimeInterval(TimeInterval(duration * 60))
               let timeSlot = "\(dateFormatter.string(from: currentTime)) - \(dateFormatter.string(from: nextTime))"
               timeSlots.append(timeSlot)
               currentTime = nextTime
           }
           
           return timeSlots
       }

    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Image("image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    VStack(alignment: .leading) {
                        Text("\(data.userId.firstName) \(data.userId.lastName)")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text(data.qualification)
                            .font(.callout)
                            .foregroundColor(.secondary)
                        Text("\(String(describing: data.experienceYears ?? 0)) years")
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                    .padding(.leading, 10)
                }

                Divider()
                    .padding(.vertical)

                VStack(alignment: .leading) {
                    Text("About Doctor")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, 16)
                    Text(doctorDescription)
                        .multilineTextAlignment(.leading)
                        .lineLimit(5)
                }

                Divider()
                    .padding(.vertical)

                VStack(alignment: .leading) {
                    Text("Working Days")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, 16)
                    HStack {
                        Text("Days")
                        Spacer()
                        Text("\(data.schedule?.rawValue ?? "")")
                    }
                    Divider()
                    HStack {
                        Text("Time")
                        Spacer()
                        //                        Text("\(slotinfo.first)-\(slotinfo.last)")
                        Text("\(data.workingHours?.first?.workingHours.from ?? "")- \(data.workingHours?.last?.workingHours.to ?? "")")
                    }
                    
                }

                Divider()
                    .padding(.vertical, 12)

                Text("Time Slots")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom)

                HStack {
                    TagCloudView(tags: generateTimeSlots(duration: Int(data.duration), timeInterval: "\(data.workingHours?.first?.workingHours.from ?? "")- \(data.workingHours?.last?.workingHours.to ?? "")"))
                }
                .padding(.bottom)

                if authentication.userType == .patient {
                    Button(action: {
                        isShowingBookAppointmentView.toggle()
                    }) {
                        Text("Book Appointment")
                            .padding()
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .sheet(isPresented: $isShowingBookAppointmentView) {
                        PatientBookAppointmentView(doctor: self.data, isShowingBookAppointmentView: $isShowingBookAppointmentView, isShowingConfirmationForAppointment: $isShowingConfirmationForAppointment)
                    }
                }
            }
            .padding()
        }
        .sheet(isPresented: $isShowingConfirmationForAppointment) {
            PatientAppointmentBookingConfirmationView(isShowingConfirmationForAppointment: $isShowingConfirmationForAppointment)
        }
    }
}




import SwiftUI

struct SkillBox: View {
    var title: String
    init(_ title: String) {
        self.title = title
    }
    init() {
        self.title = "Skill"
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(Font.system(size: 14))
        }
        .padding([.horizontal], 6)
        .padding([.vertical], 8)
        .background(Color(red: 214 / 255, green: 214 / 255, blue: 214 / 255, opacity: 0.39)).cornerRadius(5)
    }
}


#Preview {
    SkillBox()
}


struct TagCloudView: View {
    var tags: [String]
    
    @State private var totalHeight
    = CGFloat.zero       // << variant for ScrollView/List
    //    = CGFloat.infinity   // << variant for VStack
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)// << variant for ScrollView/List
        //.frame(maxHeight: totalHeight) // << variant for VStack
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.tags, id: \.self) { tag in
                self.item(for: tag)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.tags.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == self.tags.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }
    
    private func item(for text: String) -> some View {
        Text(text)
            .font(.body)
            .padding([.horizontal], 6)
            .padding([.vertical], 8)
            .background(Color(red: 214 / 255, green: 214 / 255, blue: 214 / 255, opacity: 0.39)).cornerRadius(5)
            .foregroundColor(Color.black)
            .cornerRadius(5)
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}