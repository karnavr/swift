//
//  ContentView.swift
//  WeSplit
//
//  Created by Karnav Raval on 2021-05-25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberofPeople = 2
    @State private var tipPercentage = 1
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        // calculate total per person here
        let peopleCount = Double(numberofPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount/100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal/peopleCount
        
        return amountPerPerson
    }
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount/100 * tipSelection
        
        let totalSum = orderAmount + tipValue
        
        return totalSum
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of people", selection: $numberofPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("tip percentage")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                        .pickerStyle(SegmentedPickerStyle())
                }
                
                
                Section(header: Text("total amount (total + tip)")) {
                    Text("$\(grandTotal, specifier: "%.2f")")
                }
                
                Section(header: Text("Total per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")").fontWeight(.semibold)
                }
                
                
            }
            
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
