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
                    TripItemView(name: trip.name ?? "Unname", date:  trip.date ?? Date(), speed: trip.speed, consumption: trip.consumption, massa: trip.massa)
                }.onDelete(perform: removeTrip)
            }
        }.navigationBarTitle("List of Trips")
   }
    }
    
    func removeTrip(at offsets: IndexSet) {
        for index in offsets{
            let man = trips[index]
            managedObjectContext.delete(man)
            do{
                try self.managedObjectContext.save()
            } catch{
                print(error)
            }
        }
    }
    
}

struct TripItemView: View {
    
    var name = ""
    var date = Date()
    var speed: Double = 0
    var consumption: Double = 0
    var massa: Double = 0
    var dateFormatter: DateFormatter {
        let date = DateFormatter()
        date.dateFormat = "yyyy-MM-dd"
        return date
    }
    
    
    var body: some View{
        HStack{
            VStack(alignment: .leading){
                Text(name).font(.headline)
                Text(dateFormatter.string(from: date)).font(.caption)
            }
            Spacer()
            VStack(alignment: .trailing){
                Text("speed: \(speed, specifier: "%.2f") km/h").font(.caption)
                    .foregroundColor(.red)
                Text("consumption: \(consumption, specifier: "%.2f")").font(.caption)
                    .foregroundColor(.red)
                Text("weight: \(massa,  specifier: "%.2f")").font(.caption)
                    .foregroundColor(.red)
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
