//
//  ContentView.swift
//  BetterRest
//
//  Created by Karnav Raval on 2021-05-30.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var optimalSleepTime: String {
        var result: String = "10:38 PM"
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep //sleepTime as a Date()
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            result = formatter.string(from: sleepTime)
        } catch {
            result = "error"
        }
        
        return result
    }
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 5) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    Stepper(value: $coffeeAmount, in: 1...20) {
                        if coffeeAmount == 1 {
                            Text("1 cup")
                        } else {
                            Text("\(coffeeAmount) cups")
                        }
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                
                Section(header: Text("Optimal Bedtime")) {
                    HStack {
                        Spacer()
                        Image(systemName: "moon.zzz.fill")
                            .font(.system(size: 25))
                            .foregroundColor(.purple)
                        Text(optimalSleepTime)
                            .font(.largeTitle)
                            .fontWeight(.medium)
                            .padding(.vertical)
                        Spacer()
                    }
                        
                }
                
            }
            .navigationTitle("BetterRest")
            .navigationBarItems(trailing: Button(action: calculateBedtime) {
                Text("Calculate")
            })
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    static var defaultWakeTime: Date {
        var componets = DateComponents()
        componets.hour = 7
        componets.minute = 0
        return Calendar.current.date(from: componets) ?? Date()
    }
    
    func calculateBedtime() {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep //sleepTime as a Date()
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is..."
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        showingAlert = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
