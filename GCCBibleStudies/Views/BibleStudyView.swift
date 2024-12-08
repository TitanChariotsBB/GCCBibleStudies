//
//  BibleStudyView.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 11/18/24.
//

import SwiftUI

struct BibleStudyView: View {
    
    @State var joined: Bool = false
    
    var bs: BibleStudy
    
    var meetingTime: String {
        "\(bs.time) on \(bs.day.capitalized)s"
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(bs.title).font(.largeTitle).bold().padding(.bottom, 5)
            Text(bs.description).font(.title2)
            Text(bs.bookOfTheBible).font(.title2).padding(.bottom, 5)
            Text(bs.location).font(.title2)
            Text(meetingTime).font(.title2)
            Text(bs.category).font(.title2)
            Text("Organizer: \(bs.organizer)").font(.title2)
            HStack {
                Button {
                    joined.toggle()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.blue).frame(width: 80, height: 30)
                        if joined {
                            Text("Joined").bold().foregroundStyle(.white)
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
            Spacer()
        }.padding()
    }
}

#Preview {
    BibleStudyView(bs: BibleStudy(id: 0, title: "Romans Bible Study", location: "Hopeman 325", description: "A study of the Bible that focuses on the teachings of the Apostle Paul.", bookOfTheBible: "Romans", category: "Men's", time: "6:00 PM", day: "Tuesday", organizer: "Christian Abbott")).environmentObject(ViewModel())
}
