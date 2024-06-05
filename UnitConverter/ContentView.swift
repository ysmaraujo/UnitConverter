//
//  ContentView.swift
//  UnitConverter
//
//  Created by Yasmin araujo on 05/06/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = 0.0
    @State private var selectedUnitInput = "Celsius"
    @State private var selectedUnitOutput = "Fahrenheit"
    @FocusState private var unitIsFocused: Bool
    
    let temperatureUnit = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var convertUnit: Double {
     
        var outputValue = 0.0
        
        if selectedUnitInput == "Celsius" && selectedUnitOutput == "Fahrenheit" {
            outputValue = (inputValue * 1.8) + 32
        } else if selectedUnitInput == "Celsius" && selectedUnitOutput == "Kelvin" {
            outputValue = inputValue + 273.15
        }
        
        if selectedUnitInput == "Fahrenheit" && selectedUnitOutput == "Kelvin" {
            outputValue = (inputValue - 32) * 5/9 + 273
        } else if
            selectedUnitInput == "Fahrenheit" && selectedUnitOutput == "Celsius" {
                outputValue = (inputValue - 32) / 1.8
        }
        
        if selectedUnitInput == "Kelvin" && selectedUnitOutput == "Celsius" {
            outputValue = inputValue - 273.15
        } else if selectedUnitInput == "Kelvin" && selectedUnitOutput == "Fahrenheit" {
            outputValue = (inputValue * 9/5) - 459.67
        }
        
        
        return outputValue
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    ZStack {
                        Color.yellow
                        VStack {
                            Spacer(minLength: 10)
                            Text("from")
                                .font(.title2)
                                .foregroundStyle(.opacity(0.8))
                                .padding(.bottom)
                            TextField("Input", value: $inputValue, format: .number)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 80))
                                .frame(width: UIScreen.main.bounds.width, height: 40)
                                .keyboardType(.decimalPad)
                                .focused($unitIsFocused)
                    
                            Picker("Input unit", selection: $selectedUnitInput) {
                                ForEach(temperatureUnit, id: \.self) { unit in
                                    Text(unit)
                                }
                            }
                            .frame(height: 80)
                            .pickerStyle(.wheel)
                            .padding()
                        }
                        .padding()
                    }
                    
                    ZStack {
                        Color.white
                        VStack {
                            Text("to")
                                .font(.title2)
                                .foregroundStyle(.opacity(0.8))
                                .padding(.bottom)
                            Text("\(convertUnit.formatted())")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 80))
                                .frame(width: UIScreen.main.bounds.width, height: 40)
                            
                            Picker("Output unit", selection: $selectedUnitOutput) {
                                ForEach(temperatureUnit, id: \.self) { unit in
                                    Text(unit)
                                }
                            }
                            .frame(height: 80)
                            .pickerStyle(.wheel)
                            .padding()
                        }
                    }
                }
                ZStack {
                    Circle()
                        .stroke(Color.yellow, lineWidth: 2)
                        .background(Circle().foregroundStyle(.white))
                    .frame(width: 60, height: 60)
                    Image(systemName: "arrow.down.circle")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(.yellow)
                }
            }
            .ignoresSafeArea()
            .navigationTitle("Unit Converter")
            .toolbar {
                if unitIsFocused {
                    Button("Done") {
                        unitIsFocused = false
                    }
                }
            }
            .tint(.black)
            
        }
    }
}

#Preview {
    ContentView()
}
