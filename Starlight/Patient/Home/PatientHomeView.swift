import SwiftUI
import HealthKit
import Charts

class HealthStore: ObservableObject {
    var healthStore = HKHealthStore()
    
    @Published var heartRates: [(Double, Date)] = []
    @Published var bloodPressureSystolic: String = ""
    @Published var bloodPressureDiastolic: String = ""
    @Published var spo2: String = ""
    @Published var bodyTemp: String = ""
    @Published var bloodGlucose: String = ""
    @Published var bmi: String = ""
    @Published var stepCount = ""
    
    init() {
        guard HKHealthStore.isHealthDataAvailable() else { fatalError("This app requires a device that supports HealthKit") }
        healthStore = HKHealthStore()
        requestHealthkitPermissions()
    }
    
    private func requestHealthkitPermissions() {
        let sampleTypesToRead: Set<HKSampleType> = [
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .bloodPressureSystolic)!,
            HKObjectType.quantityType(forIdentifier: .bloodPressureDiastolic)!,
            HKObjectType.quantityType(forIdentifier: .oxygenSaturation)!,
            HKObjectType.quantityType(forIdentifier: .bodyTemperature)!,
            HKObjectType.quantityType(forIdentifier: .bloodGlucose)!,
            HKObjectType.quantityType(forIdentifier: .bodyMassIndex)!,
            HKObjectType.quantityType(forIdentifier: .stepCount)!
        ]
        
        healthStore.requestAuthorization(toShare: nil, read: sampleTypesToRead) { (success, error) in
            print("Request Authorization -- Success: ", success, " Error: ", error ?? "nil")
        }
    }
}

struct PatientHomeView: View {
    @EnvironmentObject var healthStore: HealthStore
    @State private var heartRateSamples: [Double] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)){
                        HealthCardView(image: Image(systemName: "figure"), title: "BMI", subTitle: healthStore.bmi)
                            .frame(width: 210, height: 120)
                        HealthCardView(image: Image(systemName: "drop.fill"), title: "Blood Type", subTitle: "O+")
                            .frame(width: 210, height: 120)
                        HealthCardView(image: Image(systemName: "waveform.path.ecg"), title: "Blood Pressure", subTitle: "\(healthStore.bloodPressureSystolic)/\(healthStore.bloodPressureDiastolic) mmHg")
                            .frame(width: 210, height: 120)
                        HealthCardView(image: Image(systemName: "percent"), title: "Spo2", subTitle: "\(healthStore.spo2) %")
                            .frame(width: 210, height: 120)
                        HealthCardView(image: Image(systemName: "thermometer.variable.and.figure"), title: "Body Temp", subTitle: "\(healthStore.bodyTemp) C")
                            .frame(width: 210, height: 120)
                        HealthCardView(image: Image(systemName: "drop.fill"), title: "Blood Glucose", subTitle: "\(healthStore.bloodGlucose) mg/dl")
                            .frame(width: 210, height: 120)
                        
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Heart Rate")
                            HStack(alignment: .bottom) {
                                Text("\(String(format: "%.2f", healthStore.heartRates.last?.0 ?? 0))")
                                    .font(.system(size: 26))
                                Text("BPM")
                                    .font(.caption)
                                    .baselineOffset(2)
                            }
                            Image(systemName: "heart.fill")
                        }
                        Spacer()
                        Chart {
                            ForEach(healthStore.heartRates.indices, id: \.self) { index in
                                BarMark(x: PlottableValue.value("Hours", formatTimestamp(healthStore.heartRates[index].1)), y: PlottableValue.value("X", Int(healthStore.heartRates[index].0)))
                            }
                        }
                        .frame(width: 200, height: 100)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                }
                .padding()
                .onAppear(){
                    readHealthData()
                }
                .navigationTitle("Home")
            }
        }
    }
    
    private func formatTimestamp(_ timestamp: Date) -> Int {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: timestamp)
        return hour
    }
    
    private func readHealthData() {
        // Queries for health data...
    }
}

struct HealthCardView: View {
    var image: Image
    var title: String
    var subTitle: String
    
    var body: some View {
        ZStack{
            Color(uiColor: .systemGray6)
                .cornerRadius(15)
            VStack{
                HStack(alignment: .top){
                    VStack(alignment: .leading, spacing: 5){
                        Text(title)
                            .font(.system(size: 16))
                        Text(subTitle)
                            .font(.system(size: 16))
                            .bold()
                    }
                    Spacer()
                    
                    image
                        .foregroundColor(.blue)
                }
                .padding()
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
        .cornerRadius(15)
    }
}
