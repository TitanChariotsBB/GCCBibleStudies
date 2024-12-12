//
//  BSDetailsView.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 12/10/24.
//

import SwiftUI

struct BSDetailsView: View {
    
    @EnvironmentObject var VM: ViewModel
    @State var joinButtonDisabled: Bool = true
    
    @State var showWebView: Bool = false
    
    var meetingTime: String {
        "\(bs.time) on \(bs.day.capitalized)s"
    }
    
    var bs: BibleStudy
    
    @Binding var joined: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(bs.title).font(.largeTitle).bold().padding(.bottom, 5)
            Text(bs.description).font(.title3).bold().padding(.bottom, 5)
            Text("Book: \(bs.bookOfTheBible)")
            Text("Location: \(bs.location)")
            Text("Meeting time: \(meetingTime)")
            Text("Category: \(bs.category)")
            Text("Organizer: \(bs.organizer)")
            Text("Number of participants: \(bs.participants.count)")
            
            Button {
                showWebView = true
            } label: {
                Text("Read up!").padding(.vertical, 5)
            }
            
            HStack {
                Spacer()
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
            }
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showWebView) {
            WebView(urlString: "https://www.biblegateway.com/quicksearch/?quicksearch=\(bs.bookOfTheBible)&version=ESV")
        }
    }
}

#Preview {
    @State var joined: Bool = false
    BSDetailsView(bs: BibleStudy(id: 0, title: "Romans Bible Study", location: "Hopeman 325", description: "A study of the Bible that focuses on the teachings of the Apostle Paul.", bookOfTheBible: "Romans", category: "Men's", time: "6:00 PM", day: "Tuesday", organizer: "Christian Abbott", organizerId: 0, participants: [0]), joined: $joined).environmentObject(ViewModel())
}
