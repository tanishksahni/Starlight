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
                
                
                
                // MARK: HealthKit Data
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
        let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        let spo2Type = HKObjectType.quantityType(forIdentifier: .oxygenSaturation)!
        let bloodPressureType = HKObjectType.correlationType(forIdentifier: .bloodPressure)!
        let bodyTemperatureType = HKObjectType.quantityType(forIdentifier: .bodyTemperature)!
        let bloodGlucoseType = HKObjectType.quantityType(forIdentifier: .bloodGlucose)!
        let bmiType = HKObjectType.quantityType(forIdentifier: .bodyMassIndex)!
        let pulseOximetryType = HKObjectType.quantityType(forIdentifier: .oxygenSaturation)!
        let ecgType = HKObjectType.electrocardiogramType()
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let sampleQuery = HKSampleQuery(
            sampleType: heartRateType,
            predicate: get24hPredicate(),
            limit: HKObjectQueryNoLimit,
            sortDescriptors: [sortDescriptor],
            resultsHandler: { (query, results, error) in
                guard let samples = results as? [HKQuantitySample] else {
                    print(error!)
                    return
                }
                for sample in samples {
                    let mSample = sample.quantity.doubleValue(for: HKUnit(from: "count/min"))
                    let timestamp = sample.startDate
                    print("Heart rate : \(mSample) at \(timestamp)")
                    healthStore.heartRates.append((mSample, timestamp)) // Append heart rate and timestamp to the array
                }
            })
        
        let spo2Query = HKSampleQuery.init(sampleType: spo2Type,
                                           predicate: get24hPredicate(),
                                           limit: HKObjectQueryNoLimit,
                                           sortDescriptors: [sortDescriptor],
                                           resultsHandler: { (query, results, error) in
            guard let samples = results as? [HKQuantitySample] else {
                print(error!)
                return
            }
            for sample in samples {
                let mSample = sample.quantity.doubleValue(for: HKUnit.percent()) * 100
                print("SpO2 : \(mSample)")
                healthStore.spo2 = String(mSample)
            }
        })
        
        let bloodPressureQuery = HKSampleQuery(
            sampleType: bloodPressureType,
            predicate: get24hPredicate(),
            limit: HKObjectQueryNoLimit,
            sortDescriptors: [sortDescriptor],
            resultsHandler: { (query, results, error) in
                guard let correlationSamples = results as? [HKCorrelation] else {
                    print("Failed to fetch blood pressure samples: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                for correlation in correlationSamples {
                    let systolicSamples = correlation.objects(for: HKObjectType.quantityType(forIdentifier: .bloodPressureSystolic)!)
                    let diastolicSamples = correlation.objects(for: HKObjectType.quantityType(forIdentifier: .bloodPressureDiastolic)!)
                    
                    if let systolicSample = systolicSamples.first as? HKQuantitySample,
                       let diastolicSample = diastolicSamples.first as? HKQuantitySample {
                        let systolicValue = Int(systolicSample.quantity.doubleValue(for: HKUnit.millimeterOfMercury()))
                        let diastolicValue = Int(diastolicSample.quantity.doubleValue(for: HKUnit.millimeterOfMercury()))
                        print("Blood Pressure - Systolic: \(systolicValue), Diastolic: \(diastolicValue)")
                        healthStore.bloodPressureDiastolic = "\(diastolicValue)"
                        healthStore.bloodPressureSystolic = "\(systolicValue)"
                        
                    }
                }
            })
        
        
        let bodyTemperatureQuery = HKSampleQuery.init(sampleType: bodyTemperatureType,
                                                      predicate: get24hPredicate(),
                                                      limit: HKObjectQueryNoLimit,
                                                      sortDescriptors: [sortDescriptor],
                                                      resultsHandler: { (query, results, error) in
            guard let samples = results as? [HKQuantitySample] else {
                print(error!)
                return
            }
            for sample in samples {
                let mSample = sample.quantity.doubleValue(for: HKUnit.degreeCelsius())
                print("Body Temperature : \(mSample)")
                healthStore.bodyTemp = String(mSample)
            }
        })
        
        let bloodGlucoseQuery = HKSampleQuery.init(sampleType: bloodGlucoseType,
                                                   predicate: get24hPredicate(),
                                                   limit: HKObjectQueryNoLimit,
                                                   sortDescriptors: [sortDescriptor],
                                                   resultsHandler: { (query, results, error) in
            guard let samples = results as? [HKQuantitySample] else {
                print(error!)
                return
            }
            for sample in samples {
                let mSample = sample.quantity.doubleValue(for: HKUnit(from: "mg/dL"))
                print("Blood Glucose : \(mSample)")
                healthStore.bloodGlucose = String(mSample)
            }
        })
        
        let bmiQuery = HKSampleQuery.init(sampleType: bmiType,
                                          predicate: nil,
                                          limit: HKObjectQueryNoLimit,
                                          sortDescriptors: [sortDescriptor],
                                          resultsHandler: { (query, results, error) in
            guard let samples = results as? [HKQuantitySample] else {
                print(error!)
                return
            }
            for sample in samples {
                let mSample = sample.quantity.doubleValue(for: HKUnit.count())
                print("BMI : \(mSample)")
                healthStore.bmi = String(mSample)
            }
        })
        
        let pulseOximetryQuery = HKSampleQuery.init(sampleType: pulseOximetryType,
                                                    predicate: get24hPredicate(),
                                                    limit: HKObjectQueryNoLimit,
                                                    sortDescriptors: [sortDescriptor],
                                                    resultsHandler: { (query, results, error) in
            guard let samples = results as? [HKQuantitySample] else {
                print(error!)
                return
            }
            for sample in samples {
                let mSample = sample.quantity.doubleValue(for: HKUnit.percent())
                print("Pulse Oximetry : \(mSample)")
            }
        })
        
        healthStore.healthStore.execute(spo2Query)
        healthStore.healthStore.execute(bloodPressureQuery)
        healthStore.healthStore.execute(bodyTemperatureQuery)
        healthStore.healthStore.execute(bloodGlucoseQuery)
        healthStore.healthStore.execute(bmiQuery)
        healthStore.healthStore.execute(pulseOximetryQuery)
        healthStore.healthStore.execute(sampleQuery)
    }
    
    private func get24hPredicate() ->  NSPredicate{
        let today = Date()
        let startDate = Calendar.current.date(byAdding: .hour, value: -24, to: today)
        let predicate = HKQuery.predicateForSamples(withStart: startDate,end: today,options: [])
        return predicate
    }
    
}




// MARK: Healthkit data display  HealthCardView
struct HealthCardView: View {
    var image: Image
    var title: String
    var subTitle: String
    
    var body: some View {
        ZStack{
            Color(uiColor: .systemGray6)
                .cornerRadius(15)
            VStack(alignment: .leading){
                HStack(alignment: .top){
                    Text(title)
                        .font(.subheadline)
                    
                    Spacer()
                    
                    image
                }
                
                
                Spacer()
                
                Text(subTitle)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .bold()
            }
            .padding()
            
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
        .cornerRadius(15)
    }
}
