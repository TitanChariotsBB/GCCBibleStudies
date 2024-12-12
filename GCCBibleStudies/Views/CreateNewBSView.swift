//
//  CreateNewBSView.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 11/19/24.
//

import SwiftUI

struct CreateNewBSView: View {
    @EnvironmentObject var VM: ViewModel
    
    @Binding var showCreateNewBS: Bool
    @Binding var showconfetti: Bool
    
    enum Days: String, CaseIterable {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    enum Categories: String, CaseIterable {
        case men, women, all
    }
    
    @State var name: String = ""
    @State var location: String = ""
    @State var description: String = ""
    @State var bookOfTheBible: String = ""
    
    @State var date: Date = Date()
    
    @State var day: Days = .monday
    
    @State var category: Categories = .all
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Create New Bible Study").font(.largeTitle).bold().padding(.bottom, 40)
            Text("Enter details below:")
            TextField(text: $name) {
                Text("Bible study name")
            }.textFieldStyle(.roundedBorder)
                .frame(width:350)
            TextField(text: $description) {
                Text("Description")
            }.textFieldStyle(.roundedBorder)
                .frame(width:350)
            TextField(text: $bookOfTheBible) {
                Text("Book of the Bible")
            }.textFieldStyle(.roundedBorder)
                .frame(width:350)
            TextField(text: $location) {
                Text("Location on campus")
            }.textFieldStyle(.roundedBorder)
                .frame(width:350)
            HStack(spacing: 0) {
                Text("Meeting Day: ")
                Picker("Day", selection: $day) {
                    Text("Monday").tag(Days.monday)
                    Text("Tuesday").tag(Days.tuesday)
                    Text("Wednesday").tag(Days.wednesday)
                    Text("Thursday").tag(Days.thursday)
                    Text("Friday").tag(Days.friday)
                    Text("Saturday").tag(Days.saturday)
                    Text("Sunday").tag(Days.sunday)
                }
                DatePicker("Time: ", selection: $date, displayedComponents: [.hourAndMinute])
                Spacer()
            }
            
            HStack {
                Text("Category: ")
                Picker("Category", selection: $category) {
                    Text("Men's").tag(Categories.men)
                    Text("Women's").tag(Categories.women)
                    Text("All").tag(Categories.all)
                }
            }
            
            HStack {
                Spacer()
                Button {
                    let _ = print("showconfetti:",showconfetti)
                    let bibleStudyID = Int.random(in: 0..<1000000)
                    
                    VM.createNewBibleStudy(bibleStudy: BibleStudy(
                        id: bibleStudyID,
                        title: name,
                        location: location,
                        description: description,
                        bookOfTheBible: bookOfTheBible,
                        category: category.rawValue,
                        time: date.formatted(date: .omitted, time: .shortened),
                        day: day.rawValue,
                        organizer: (VM.currentUser?.fname ?? "Anonymous") + " " + (VM.currentUser?.lname ?? "User"),
                        organizerId: VM.currentUser?.id ?? 0,
                        participants: []
                    ))
                    
                    //reset fields
                    name = ""
                    location = ""
                    description = ""
                    bookOfTheBible = ""
                    date = Date()
                    day = .monday
                    category = .all
                    
                    showCreateNewBS = false
                    showconfetti = true
                    let _ = print("showconfetti:",showconfetti)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.blue).frame(width: 80, height: 40)
                        Text("Create").foregroundStyle(.white).bold()
                    }
                }
                
                Button {
                    showCreateNewBS = false
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.blue).frame(width: 80, height: 40)
                        Text("Cancel").foregroundStyle(.white).bold()
                    }
                }
            }
            Spacer()
            
        }.padding()
    }
}

#Preview {
    @State var showconfetti = false
    @State var showCreateNewBS: Bool = true
    CreateNewBSView(showCreateNewBS: $showCreateNewBS,showconfetti: $showconfetti).environmentObject(ViewModel())
}
