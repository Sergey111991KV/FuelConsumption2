//
//  ListObject.swift
//  FuelConsumption
//
//  Created by Сергей Косилов on 24.10.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//


import SwiftUI
import CoreData

struct ListObject: View {

    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Trip.entity(), sortDescriptors:
           [
               NSSortDescriptor(keyPath: \Trip.name, ascending: true)


       ]) var trips: FetchedResults<Trip>

    
var body: some View {
   NavigationView{
        List{
            Section {
                ForEach(self.trips, id: \.self) { trip in
                    TripItemView(name: trip.name ?? "jj", date: "\(trip.date)", speed: trip.speed, consumption: trip.consumption, massa: trip.massa)
                }
            }
        }
   }

.navigationBarTitle("List of Trips")
    }
}

struct TripItemView: View {
    
    var name = ""
    var date = ""
    var speed: Double = 0
    var consumption: Double = 0
    var massa: Double = 0
    
    
    var body: some View{
        HStack{
            VStack(alignment: .leading){
                Text(name).font(.headline)
                Text(date).font(.caption)
            }
            VStack{
                Text("\(speed) km/h")
                Text(String(consumption))
                Text(String(massa))
            }
        }
    }
    
}

struct ListObject_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        ListObject()
    }
}
}
