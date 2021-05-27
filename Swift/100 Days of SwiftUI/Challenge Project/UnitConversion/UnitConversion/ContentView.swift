//
//  ContentView.swift
//  UnitConversion
//
//  Created by Karnav Raval on 2021-05-26.
//

import SwiftUI

enum Unit: String {
    case celsius
    case fahrenheit
    case kelvin
}

struct ContentView: View {

    @State private var inputUnit = Unit.celsius
    @State private var outputUnit = Unit.fahrenheit
    @State private var quantity = ""
    
    var interimQuantity: Double {
        // converts the input quantity to an interim quantity for further computation
        var result: Double
        
        switch inputUnit {
        case .celsius:
            result = Double(quantity) ?? 0.0
        case .fahrenheit:
            result = ((Double(quantity) ?? 0.0) - 32) * (5/9)
        case .kelvin:
            result = (Double(quantity) ?? 0.0) - 273.15
        }
        
        return result
    }
    
    var convertedQuantity: Double {
        // computes the output temperature quantity
        var result: Double
        
        switch outputUnit {
        case .celsius:
            result = interimQuantity
        case .kelvin:
            result = interimQuantity + 273.15
        case .fahrenheit:
            result = (interimQuantity * (9/5)) + 32
        }
        
        return result
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input")) {
                    TextField("temperature", text: $quantity)
                        .keyboardType(.decimalPad)
                    
                    Picker("Input Unit", selection: $inputUnit) {
                        Text("Celsius").tag(Unit.celsius)
                        Text("Fahrenheit").tag(Unit.fahrenheit)
                        Text("Kelvin").tag(Unit.kelvin)
                    }
                        .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Output")) {
                    Text("\(convertedQuantity, specifier: "%.2f")")
                    
                    Picker("Output Unit", selection: $outputUnit) {
                        Text("Celsius").tag(Unit.celsius)
                        Text("Fahrenheit").tag(Unit.fahrenheit)
                        Text("Kelvin").tag(Unit.kelvin)
                    }
                        .pickerStyle(SegmentedPickerStyle())
                }
                
            }
            .navigationBarTitle("Unit Conversion ")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
