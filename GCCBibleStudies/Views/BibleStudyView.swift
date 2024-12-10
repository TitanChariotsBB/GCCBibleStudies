//
//  BibleStudyView.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 11/18/24.
//

import SwiftUI

struct BibleStudyView: View {
    @EnvironmentObject var VM: ViewModel
    @State var joinButtonDisabled: Bool = true
    @State var joined: Bool = false
    var bs: BibleStudy
    
    var meetingTime: String {
        "\(bs.time) on \(bs.day.capitalized)s"
    }
    
    var body: some View {
        // gp for geometry proxy
        GeometryReader { gp in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                VStack(alignment: .leading) {
                    Text(bs.title).font(.largeTitle).bold().padding(.bottom, 5)
                    Text(bs.description).font(.title2)
                    Text("Book: \(bs.bookOfTheBible)").font(.title2).padding(.vertical, 5)
                    /*if bs.bookOfTheBible != nil {
                     Text("Book: \(bs.bookOfTheBible)").font(.title2).padding(.bottom, 5)
                     }*/
                    Text(bs.location).font(.title2)
                    Text(meetingTime).font(.title2)
                    Text(bs.category).font(.title2)
                    Text("Organizer: \(bs.organizer)").font(.title2)
                    Text("Number of participants: \(bs.participants.count)")
                    HStack {
                        Button {
                           if VM.currentUser != nil {
                              if joined {
                                  VM.leaveBibleStudy(bibleStudyId: bs.id, userId: VM.currentUser!.id)
                              } else {
                                  VM.joinBibleStudy(bibleStudyId: bs.id, userId: VM.currentUser!.id)
                              }
                              joined.toggle()
                           }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.blue).frame(width: 80, height: 30)
                                if joined {
                                    Text("Leave").bold().foregroundStyle(.white)
                                } else {
                                    Text("Join").bold().foregroundStyle(.white)
                                }
                            }
                        }
                        
                        Button {
                            // onClick
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.blue).frame(width: 100, height: 30)
                                Text("Details").bold().foregroundStyle(.white)
                            }
                        }
                        Spacer()
                    }
                }.padding(.leading).padding(.bottom,10).padding(.top,5)
            }.padding(8)
        }
        .padding()
        .onAppear() {
            if VM.currentUser != nil {
                joined = bs.participants.contains(VM.currentUser!.id)
                print("You are a participant in \(bs.title)")
                joinButtonDisabled = false
            } else {
                print("Current user is nil. Unable to fetch joined status")
            }
        }
    }
}

#Preview {
    BibleStudyView(bs: BibleStudy(id: 0, title: "Romans Bible Study", location: "Hopeman 325", description: "A study of the Bible that focuses on the teachings of the Apostle Paul.", bookOfTheBible: "Romans", category: "Men's", time: "6:00 PM", day: "Tuesday", organizer: "Christian Abbott", organizerId: 0, participants: [0])).environmentObject(ViewModel())
}
