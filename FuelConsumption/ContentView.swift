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
                        
                        VStack{
                            Text("Odometer start reading")
                            
                            HStack{
                                Spacer()
                                
                                TextField("0", text: $beginingKilometres)
                                    .keyboardType(.decimalPad)
                            }
                            Text("End odometer reading")
                            HStack{
                                Spacer()
                                TextField("0", text: $endKilometres)
                                    .keyboardType(.decimalPad)
                            }
                                Text("All kilometres \(allKilometres, specifier: "%.2f")")
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
                            VStack{
                                Text("Begining Oil")
                                HStack{
                                    
                                    Spacer()
                                    TextField("0", text: $beginingOil)
                                        .keyboardType(.decimalPad)
                                }
                                Text("End Oil")
                                HStack{
                                    
                                    Spacer()
                                    TextField("0", text: $endOil)
                                        .keyboardType(.decimalPad)
                                }
                                Text("All Oil \(allOil, specifier: "%.2f")")
                                
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
                                    
                                    
                                    Text("Travel Time (Hour)")
                                    
                                    
                                }
                                HStack{
                                    Spacer()
                                    TextField("0", text: $timeOfDistanse)
                                        .keyboardType(.decimalPad)
                                }
                            }
                            VStack(alignment: .leading){
                        VStack{
                            Image("box")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100,height:100)
                                .padding()
                            Text("Cargo Weight (Kilogram)")
                        }
                        
                        HStack{
                            Spacer()
                            TextField("0", text: $massa)
                                
                                .keyboardType(.decimalPad)
                        }
                    }
                   
                    
                }
                       }
                        HStack{
                        Text("Name of Travel")
                            Spacer()
                            TextField("Write", text: $nameOfTravel)
                            
                        }
                }
                //MARK: - RESULT & SAVE
                Section{
                    HStack{
                        Spacer()
                        Text("Speed: \(speedOfCar, specifier: "%.2f")")
                        Spacer()
                        Text("Сonsumption: \(fuelConsumption, specifier: "%.2f")")
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
                                    self.massa = "0"
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
            }
        .navigationBarTitle("Fuel Consumption")
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
