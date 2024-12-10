//
//  ViewModel.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 11/19/24.
//

import Foundation
import CryptoKit
import Combine
import UserNotifications

func hash(data: Data) -> String {
    let digest = SHA256.hash(data: data)
    let hashString = digest
        .compactMap { String(format: "%02x", $0) }
        .joined()
    return hashString
}

class ViewModel: ObservableObject {
    @Published var allBibleStudies: [BibleStudy] = []
    @Published var currentUser: User? = nil
    @Published var isLoggedOut: Bool = true
    
    var activeNotifications: [Int: String] = [:]
    
    let mm: MongoDBManager = MongoDBManager()
    
    init() {
        getBibleStudies()
        addsubscribers()
    }
    
    func getBibleStudies() {
        Task {
            if !mm.isConnected {
                await mm.connect()
            }
            let studies = await mm.getBibleStudies()
            print("Fetched \(studies.count) Bible studies")
            
            await MainActor.run {
                self.allBibleStudies = studies

                // want to only display categories that are present to the user in the filter menu
                let currentcategories = Set(allBibleStudies.map({ $0.category }))
                allsearchscopes = [.any] + Set(currentcategories.map({ SearchScopeOption.strtoop(str:$0) }))
            }
        }
    }
    
    func getBibleStudiesJoined() -> [BibleStudy] {
        if currentUser != nil {
            return allBibleStudies.filter() { $0.participants.contains(currentUser!.id) }
        } else {
            return []
        }
    }
    
    func getBibleStudiesCreated() -> [BibleStudy] {
        if currentUser != nil {
            return allBibleStudies.filter() { $0.organizerId == currentUser!.id }
        } else {
            return []
        }
    }
    
    func createNewBibleStudy(bibleStudy: BibleStudy) {
        if mm.isConnected {
            Task {
                await mm.createNewBibleStudy(bs: bibleStudy)
                
                let studies = await mm.getBibleStudies()
                
                await MainActor.run {
                    self.allBibleStudies = studies
                }
            }
        }
    }
    
    func joinBibleStudy(bibleStudyId: Int, userId: Int) {
        if mm.isConnected {
            Task {
                await mm.joinBibleStudy(bibleStudyId: bibleStudyId, userId: userId)
            }
        }
    }
    
    func leaveBibleStudy(bibleStudyId: Int, userId: Int) {
        if mm.isConnected {
            Task {
                await mm.leaveBibleStudy(bibleStudyId: bibleStudyId, userId: userId)
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
    
    
    
    // ===========================================================
    // Search Functionality
    // ===========================================================
    @Published var searchtext:String = ""
    @Published var filteredBibleStudies:[BibleStudy] = []
    var cancellables = Set<AnyCancellable>()
    
    // add subscribers to the search text
    func addsubscribers() {
        // access the published value of the search text so that everytime the text changes
        // this text changes as well
        // debounce makes it so that we just perform an action if the user has stopped typing
        // for at least 0.3 seconds
        $searchtext
            .combineLatest($searchscope)
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { (searchtext,searchscope) in
                self.filterBibleStudies(searchtext: searchtext, currentsearchscope: searchscope)
            }
            .store(in: &cancellables)
        
    }
    
    private func filterBibleStudies(searchtext:String,currentsearchscope:SearchScopeOption) {
        // give guard the condition we want to be true
        // guard else block runs if not boolean expression given
        guard !searchtext.isEmpty else {
            filteredBibleStudies = []
            searchscope = .any
            return
        }
        
        filteredBibleStudies = allBibleStudies.filter({ bibstud in
            return (currentsearchscope == .any || SearchScopeOption.strtoop(str:bibstud.category) == currentsearchscope) && (attrhas(attr: bibstud.title, has: searchtext) || attrhas(attr: bibstud.category, has: searchtext) || attrhas(attr: bibstud.day, has: searchtext) || attrhas(attr: bibstud.description, has: searchtext) || attrhas(attr: bibstud.location, has: searchtext) || attrhas(attr: bibstud.organizer, has: searchtext) || attrhas(attr: bibstud.time, has: searchtext))
        })
    }
    
    func attrhas(attr:String,has:String) -> Bool {
        print(attr.uppercased().contains(has.uppercased()))
        return attr.uppercased().contains(has.uppercased())
    }
    
    @Published var searchscope:SearchScopeOption = .any
    @Published var allsearchscopes:[SearchScopeOption] = []
    
    enum SearchScopeOption : Hashable{
        case any,everyone,men,women
        
        var title:String {
            switch(self) {
            case .any:
                return "Any"
            case .everyone:
                return "Everyone"
            case .men:
                return "Men"
            case .women:
                return "Women"
            }
        }
        
        static func strtoop(str:String) -> SearchScopeOption {
            switch(str.uppercased()) {
            case "ANY":
                return .any
            case "MEN", "MEN'S", "MENS":
                return .men
            case "WOMEN","WOMEN'S","WOMENS":
                return .women
            default:
                return .everyone
            }
        }
    }
}
