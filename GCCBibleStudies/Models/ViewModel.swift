//
//  ViewModel.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 11/19/24.
//

import Foundation
import CryptoKit
import UserNotifications

func hash(data: Data) -> String {
    let digest = SHA256.hash(data: data)
    let hashString = digest
        .compactMap { String(format: "%02x", $0) }
        .joined()
    return hashString
}

class ViewModel: ObservableObject {
    @Published var bibleStudies: [BibleStudy] = []
    @Published var currentUser: User? = nil
    @Published var isLoggedOut: Bool = true
    
    var activeNotifications: [Int: String] = [:]
    
    let mm: MongoDBManager = MongoDBManager()
    
    init() {
        getBibleStudies()
    }
    
    func getBibleStudies() {
        Task {
            if !mm.isConnected {
                await mm.connect()
            }
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
                
                let studies = await mm.getBibleStudies()
                
                await MainActor.run {
                    self.bibleStudies = studies
                }
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
    
    func loginUser(username: String, password: String) {
        let inputData = password.data(using: .utf8)!
        let hashedPassword = hash(data: inputData)
        
        Task {
            if !mm.isConnected {
                await mm.connect()
            }
            let user = await mm.getUser(username: username, passwordHash: hashedPassword)
            
            if user != nil {
                print("Succesfully logged in!")
                await MainActor.run {
                    self.currentUser = user
                    self.isLoggedOut = false
                }
            } else {
                print("Error: unable to log in")
            }
        }
        
    }
    
    func createNotification(id: Int, title: String, day: String, time: String) {
        print("Attempting to create notification")
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "\(day) at \(time)"
        
        var dayInt: Int = 1
        
        if day == "Sunday" {
            dayInt = 1
        } else if day == "Monday" {
            dayInt = 2
        } else if day == "Tuesday" {
            dayInt = 3
        } else if day == "Wednesday" {
            dayInt = 4
        } else if day == "Thursday" {
            dayInt = 5
        } else if day == "Friday" {
            dayInt = 6
        } else {
            dayInt = 7
        }
        
        let timeList = time.components(separatedBy: ":")
        let hour: Int = Int(timeList[0]) ?? 12
        let minute: Int = Int(timeList[1]
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "M", with: "")
            .replacingOccurrences(of: "A", with: "")
            .replacingOccurrences(of: "P", with: "")) ?? 0
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.weekday = dayInt
        dateComponents.hour = hour - 1 // set alert 1 hour before
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        Task {
            do {
                try await notificationCenter.add(request)
                
                await MainActor.run {
                    activeNotifications[id] = uuidString // Keep track of the UUIDs of active notifications
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func deleteNotification(id: Int) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [activeNotifications[id] ?? ""])
    }
}
