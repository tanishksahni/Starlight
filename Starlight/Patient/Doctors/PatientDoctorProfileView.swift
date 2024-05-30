//
//  PatientDoctorProfileView.swift
//  Starlight
//
//  Created by Tanishk Sahni on 30/05/24.
//

import SwiftUI

struct PatientDoctorProfileView: View {
    @State private var isShowingBookAppointmentView = false
    let allDaySlots = [
        "26 May", "26 May", "26 May" , "26 May"
    ]
    let allTimeSlots = [
        "9:00AM", "10:00AM", "11:00AM", "12:00PM",  "13:00PM"
    ]
    
    var timeSlots: [[String]] {
        stride(from: 0, to: allTimeSlots.count, by: 4).map {
            Array(allTimeSlots[$0..<min($0 + 4, allTimeSlots.count)])
        }
    }
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                // Profile Image
                HStack {
                    Image("image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    VStack(alignment: .leading) {
                        Text("Dr. Rajesh Tiwari")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text("MBBS")
                            .font(.callout)
                            .foregroundColor(.secondary)
                        Text("17+ years")
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                    .padding(.leading, 10)
                }
                
                Divider()
                    .padding(.vertical)
                
                VStack(alignment: .leading){
                    Text("About Doctor")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, 16)
                    Text("I am Dr. Rajesh Tiwari. The application should also cater to the needs of a hospital including but not limited to managing shifts, medical inventory, patient history.")
                        .multilineTextAlignment(.leading)
                        .lineLimit(5)
                    
                   
                }
                Divider()
                    .padding(.vertical)
                
                //MARK:  Working days details
                
                VStack(alignment: .leading) {
                    Text("Working Days")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, 16)
                    
                    HStack {
                        Text("Days")
                        Spacer()
                        Text("Mon-Sat")
                    }
                    Divider()
                    HStack {
                        Text("Time")
                        Spacer()
                        Text("9:00 AM - 5:00 PM")
                    }
                }
                
                
                //MARK:  AVAILABLE days details
                Text("Available Time Slots")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.vertical)
                   
                
                HStack {
                    TagCloudView(tags: allTimeSlots)
                }
                
                .padding(.bottom)
                
                NavigationLink(destination: PatientBookAppointmentView()) {
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
                }
                .sheet(isPresented: $isShowingBookAppointmentView) {
                    PatientBookAppointmentView()
                }
               
            }
            .padding()
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
