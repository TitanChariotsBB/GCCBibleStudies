//
//  MongoManager.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 12/4/24.
//

import Foundation
import MongoKitten

class MongoDBManager {
    
    var db: MongoDatabase?
    var isConnected: Bool = false
    
    func connect() async {
        do {
            db = try await MongoDatabase.connect(to: MONGO_DB_URL)
            isConnected = true
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getBibleStudies() async -> [BibleStudy] {
        if db == nil {
            return []
        }
        
        let bibleStudiesCollection = db!["BibleStudies"]
        
        do {
            let bibleStudies: [BibleStudy] = try await bibleStudiesCollection.find().decode(BibleStudy.self).drain()
            print(bibleStudies)
            return bibleStudies
        } catch {
            print("Error getting list of bible studies: \(error.localizedDescription)")
            return []
        }
    }
    
    func createNewBibleStudy(bs: BibleStudy) async {
        if db == nil {
            print("Error: database is nil")
        }
        
        let bibleStudiesCollection = db!["BibleStudies"]
        
        let newBibleStudy: Document = ["id": bs.id, "title": bs.title, "location": bs.location, "description": bs.description, "bookOfTheBible": bs.bookOfTheBible, "category": bs.category, "time": bs.time, "day": bs.day]
        
        do {
            try await bibleStudiesCollection.insert(newBibleStudy)
        } catch {
            print("Error inserting bible study: \(error.localizedDescription)")
        }
    }
    
    
}
