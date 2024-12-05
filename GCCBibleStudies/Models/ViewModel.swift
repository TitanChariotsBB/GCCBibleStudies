//
//  ViewModel.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 11/19/24.
//

import Foundation
import CryptoKit

func hash(data: Data) -> String {
    let digest = SHA256.hash(data: data)
    let hashString = digest
        .compactMap { String(format: "%02x", $0) }
        .joined()
    return hashString
}

class ViewModel: ObservableObject {
    @Published var bibleStudies: [BibleStudy] = []
    let mm: MongoDBManager = MongoDBManager()
    
    init() {
        getBibleStudies()
    }
    
    func getBibleStudies() {
        Task {
            await mm.connect()
            let studies = await mm.getBibleStudies()
            
            await MainActor.run {
                self.bibleStudies = studies
            }
        }
    }
    
    func createNewBibleStudy(bibleStudy: BibleStudy) {
        if mm.isConnected {
            Task {
                await mm.createNewBibleStudy(bs: bibleStudy)
            }
        }
    }
    
    func createNewUser(username: String, password: String, fname: String, lname: String) {
        // Hash password
        let inputData = password.data(using: .utf8)!
        let hashedPassword = hash(data: inputData)
        
        let newUser = User(id: Int.random(in: 0..<10000), username: username, passwordHash: hashedPassword, fname: fname, lname: lname)
        
        if mm.isConnected {
            Task {
                await mm.createUser(user: newUser)
            }
        }
    }
}
