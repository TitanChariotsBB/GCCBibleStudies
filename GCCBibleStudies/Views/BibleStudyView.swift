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
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(radius: 5)
            VStack(alignment: .leading) {
                Text(bs.title).font(.title).bold()
                Text(bs.description)
                Text("Book: \(bs.bookOfTheBible)")
                /*if bs.bookOfTheBible != nil {
                 Text("Book: \(bs.bookOfTheBible)").font(.title2).padding(.bottom, 5)
                 }*/
                Text("Location: \(bs.location)")
                Text("Meeting time: \(meetingTime)")
                Text("Category: \(bs.category)")
                //                    Text("Organizer: \(bs.organizer)")
                //                    Text("Number of participants: \(bs.participants.count)")
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
                    NavigationLink(destination: {
                        BSDetailsView(bs: bs, joined: $joined)
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.blue).frame(width: 100, height: 30)
                            Text("Details").bold().foregroundStyle(.white)
                        }
                    })
                    Spacer()
                }
            }.padding(20)
        }.frame(height: 250)
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
