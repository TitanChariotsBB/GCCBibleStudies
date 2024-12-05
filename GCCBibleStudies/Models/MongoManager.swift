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
            print("Error: database is nil")
            return []
        }
        
        let bibleStudiesCollection = db!["BibleStudies"]
        
        do {
            let bibleStudies: [BibleStudy] = try await bibleStudiesCollection.find().decode(BibleStudy.self).drain()
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
    
    func getUser(username: String, passwordHash: String) async -> User? {
        if db == nil {
            print("Error: database is nil")
            return nil
        }
        
        let usersCollection = db!["Users"]
        
        do {
            let user: User? = try await usersCollection.findOne(["username": username, "passwordHash": passwordHash], as: User.self)
            
            if user == nil {
                print("Could not find \(username)")
                return nil
            } else {
                print("User \(user!.id): \(user!.fname) \(user!.lname)")
                return user!
            }
        } catch {
            print("Error finding user \(username): \(error.localizedDescription)")
            return nil
        }
    }
    
    func createUser(user: User) async {
        if db == nil {
            print("Error: database is nil")
        }
        
        let usersCollection = db!["Users"]
        
        let newUser: Document = ["id": user.id, "username": user.username, "passwordHash": user.passwordHash, "fname": user.fname, "lname": user.lname]
        
        do {
            try await usersCollection.insert(newUser)
        } catch {
            print("Error inserting bible study: \(error.localizedDescription)")
        }
    }
    
}
