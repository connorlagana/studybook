//
//  ContentView.swift
//  Flashcards
//
//  Created by Connor Lagana on 9/9/20.
//  Copyright © 2020 Connor Lagana. All rights reserved.
//

import SwiftUI
import CoreData

private func fetchCards() {
    //fetching core data
    let persistentContainer = NSPersistentContainer(name: "Flashcards")
    persistentContainer.loadPersistentStores { (storeData, err) in
        if let err = err {
            print("failed something: \(err)")
        }
        
    }
    
    let context = persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<Flashcard>(entityName: "Flashcard")
    
    do {
        let cards = try context.fetch(fetchRequest)
        
        cards.forEach { (flash) in
            print(flash ?? "")
        }
        
    } catch let fetchErr {
        print("fetch error: \(fetchErr)")
    }
    
}

private func handleSave() {
    print("handling save...")
    
    //String must match .xcdatamodeld file name
    let persistentContainer = NSPersistentContainer(name: "Flashcards")
    
    persistentContainer.loadPersistentStores { (storeDescription, err) in
        
        if let err = err {
            fatalError("OOPS! Loading store failed: \(err)")
        }
        
        let context = persistentContainer.viewContext
        
        let card = NSEntityDescription.insertNewObject(forEntityName: "Flashcard", into: context)
        
        card.setValue("How big is the sun?", forKey: "question")
        card.setValue("Really big!", forKey: "answer")
        
        do {
            try context.save()
        } catch let saveErr {
            print("failed to save card: \(saveErr)")
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Penis")
            Text("Penis2")
            Button(action: handleSave) {
                Text("save")
                }
            Button(action: fetchCards) {
                Text("fetch")
                }
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
