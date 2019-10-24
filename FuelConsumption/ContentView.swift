//
//  ContentView.swift
//  FuelConsumption
//
//  Created by Сергей Косилов on 23.10.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var beginingKilometres = "0"
    @State private var endKilometres = "0"
    @State private var allKilometres = "0"
    @State private var massa = "0"
    @State private var beginingOil = "0"
    @State private var endOil = "0"
    @State private var time = "0"
    
    
    
    var body: some View {
        NavigationView{
            
            
            
        List{
            Section(header: Text("Distanse")){
            HStack{
             
           Image("distance")
                .resizable()
                .scaledToFit()
                .frame(width: 100,height:100)
                
                VStack{
            VStack{
              Text("Begining Kilometres")
                TextField("0", text: $beginingKilometres)
                    .keyboardType(.decimalPad)
                    
                 
            }
                VStack{
             
                
               Text("End Kilometres")
                               
                TextField("0", text: $beginingKilometres)
                               .keyboardType(.decimalPad)
            }
                
                Text("All kilometres \(allKilometres)")
            }
            }
            }
             Section(header: Text("111")){
                            Image("distance")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100,height:100)
                Text("Begining Oil")
                           
                         TextField("0", text: $beginingKilometres)
                           .keyboardType(.decimalPad)
                           
                           Text("End Oil")
                                          
                           TextField("0", text: $beginingKilometres)
                                          .keyboardType(.decimalPad)
                       }
            
             Section(header: Text("111")){
                           
                         Text("Begining Kilometres")
                           
                         TextField("0", text: $beginingKilometres)
                           .keyboardType(.decimalPad)
                           
                           Text("End Kilometres")
                                          
                           TextField("0", text: $beginingKilometres)
                                          .keyboardType(.decimalPad)
                       }
            Section{
                Button("Show Alert") {
                    
                }
            }
            
        }
        .navigationBarTitle("Fuel Consumption")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
