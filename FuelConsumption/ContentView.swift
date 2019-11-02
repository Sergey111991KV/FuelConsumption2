//
//  ContentView.swift
//  FuelConsumption
//
//  Created by Сергей Косилов on 23.10.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var showingAlert = false
    @State private var beginingKilometres = ""
    @State private var endKilometres = ""
    var allKilometres: Double{
        if let begin = Double(beginingKilometres), let end = Double(endKilometres), end > begin{
            
            let all = end - begin
            return all
        } else{
            return 0
        }
    }
   
    @State private var beginingOil = ""
    @State private var endOil = ""
    var allOil : Double{
        if let begin = Double(beginingOil), let end = Double(endOil), begin > end{
            
            let all = begin - end
            return all
        } else{
            return 0
        }
    }
    
    @State private var timeOfDistanse = ""
    @State private var massa = ""
    @State private var nameOfTravel = ""
    

    var fuelConsumption: Double{
        if allOil != 0, allKilometres != 0 {
              let consumption = allOil / allKilometres * 100
              return consumption
        } else {
            return  0
        }
    }
    
    var speedOfCar: Double{
        
        let time = Double(timeOfDistanse) ?? 0
        
        if time != 0, allKilometres != 0 {
            let speed = allKilometres / time
            return speed
        }
        return 0
    }
    
     private func endEditing() {
           UIApplication.shared.endEditing()
       }
    var body: some View {
        NavigationView{
            List{
//MARK: - DISTANSE
                Section(header: Text("Distanse")){
                    HStack{
                        Image("distance")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100,height:100)
                        .onTapGesture {
                            self.endEditing()
                        }
                        VStack{
                            Text("Odometer start reading")
                            .onTapGesture {
                                self.endEditing()
                            }
                            HStack{
                                Spacer()
                                TextField("0", text: $beginingKilometres)
                                    .background(Color.gray.opacity(0.5))
                                    .keyboardType(.decimalPad)
                               .onTapGesture {
                                   self.endEditing()
                               }
                            }
                             
                            
                            Text("End odometer reading")
                            .onTapGesture {
                                self.endEditing()
                            }
                            HStack{
                                Spacer()
                                TextField("0", text: $endKilometres)
                                    .background(Color.gray.opacity(0.5))
                                    .keyboardType(.decimalPad)
                                .onTapGesture {
                                    self.endEditing()
                                }
                            }
                                Text("All kilometres \(allKilometres, specifier: "%.2f")")
                            .onTapGesture {
                                self.endEditing()
                            }
                        }
                    }
                }
//MARK: - OIL
                    Section(header: Text("Oil")){
                        HStack{
                            Image("barrel")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100,height:100)
                            .onTapGesture {
                                self.endEditing()
                            }
                            VStack{
                                Text("Begining Oil")
                                .onTapGesture {
                                    self.endEditing()
                                }
                                HStack{
                                    
                                    Spacer()
                                    TextField("0", text: $beginingOil)
                                        .background(Color.gray.opacity(0.5))
                                        .keyboardType(.decimalPad)
                                    .onTapGesture {
                                        self.endEditing()
                                    }
                                }
                                Text("End Oil")
                                .onTapGesture {
                                    self.endEditing()
                                }
                                HStack{
                                    
                                    Spacer()
                                    TextField("0", text: $endOil)
                                        .background(Color.gray.opacity(0.5))
                                        .keyboardType(.decimalPad)
                                    .onTapGesture {
                                        self.endEditing()
                                    }
                                }
                                Text("All Oil \(allOil, specifier: "%.2f")")
                                .onTapGesture {
                                    self.endEditing()
                                }
                            }
                        }
                    }
//MARK: - OPTIONS
                Section(header: Text("Massa&Time")){
                    VStack{
                    HStack{
                        VStack{
                            VStack{
                                Image("time")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100,height:100)
                                    .padding()
                                .onTapGesture {
                                    self.endEditing()
                                }
                                Text("Travel Time (Hour)")
                                .onTapGesture {
                                    self.endEditing()
                                }
                            }
                            HStack{
                                Spacer()
                                TextField("0", text: $timeOfDistanse)
                                    .background(Color.gray.opacity(0.5))
                                    .keyboardType(.decimalPad)
                                .onTapGesture {
                                    self.endEditing()
                                }
                                Spacer()
                            }}
                        VStack(alignment: .leading){
                            VStack{
                                Image("box")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100,height:100)
                                    .padding()
                                    .onTapGesture {
                                        self.endEditing()
                                }
                                Text("Cargo Weight (Kg)")
                                .onTapGesture {
                                    self.endEditing()
                                }
                            }
                            HStack{
                                
                                TextField("0", text: $massa)
                                    .background(Color.gray.opacity(0.5))
                                    .keyboardType(.decimalPad)
                                .onTapGesture {
                                    self.endEditing()
                                }
                            }
                        }
                        }
                
                HStack{
                    Text("Name of Travel")
                    .onTapGesture {
                        self.endEditing()
                    }
                    Spacer()
                    TextField("Write", text: $nameOfTravel).background(Color.gray.opacity(0.5))
                        .onTapGesture {
                            self.endEditing()
                    }
                }
            }
                }
                //MARK: - RESULT & SAVE
                Section{
                    HStack{
                        Spacer()
                        Text("Speed: \(speedOfCar, specifier: "%.2f")")
                        .onTapGesture {
                            self.endEditing()
                        }
                        Spacer()
                        Text("Сonsumption: \(fuelConsumption, specifier: "%.2f")")
                        .onTapGesture {
                            self.endEditing()
                        }
                        Spacer()
                    }
                    
                    ZStack{
                    HStack{
                        Spacer()
                        Button(action: {
                            if self.nameOfTravel != "" && self.fuelConsumption != 0 && self.speedOfCar != 0
                                /* && self.massa != ""*/
                            {
                                let trip = Trip(context: self.managedObjectContext)
                                trip.name = self.nameOfTravel
                                trip.consumption = self.fuelConsumption
                                trip.date = Date()
                                trip.speed = self.speedOfCar
                                trip.massa = Double(self.massa) ?? 0
                                do {
                                    try self.managedObjectContext.save()
                                    self.nameOfTravel = ""
                                    self.beginingOil = ""
                                    self.endOil = ""
                                    self.beginingKilometres = ""
                                    self.endKilometres = ""
                                    self.massa = ""
                                    self.timeOfDistanse = ""
                                } catch{
                                    print(error)
                                }
                            }else {
                                 self.showingAlert = true
                            }
                      
                        }){
                            Text("Save")
                            .titleStyle()
                        }
                         .alert(isPresented: $showingAlert) {
                                   Alert(title: Text("Cannot save"), message: Text("Fill in all the data"), dismissButton: .default(Text("OK")))
                               }
                        Spacer()
                    }
                }
                   
                }
                .navigationBarTitle("Calculate")
            }
       
        }
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.red)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
