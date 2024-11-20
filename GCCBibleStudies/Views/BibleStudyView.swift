//
//  BibleStudyView.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 11/18/24.
//

import SwiftUI

struct BibleStudyView: View {
    
    @State var joined: Bool = false
    
    var name: String
    var description: String
    var location: String
    var day: String
    var time: Date
    
    var meetingTime: String {
        "\(time.formatted(date: .omitted, time: .shortened)) on \(day)s"
    }
    var category: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name).font(.largeTitle).bold().padding(.bottom, 5)
            Text(description).font(.title2).padding(.bottom, 5)
            Text(location).font(.title2)
            Text(meetingTime).font(.title2)
            Text(category).font(.title2)
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
    BibleStudyView(name: "Romans Bible Study", description: "A study of the Bible that focuses on the teachings of the Apostle Paul.", location: "Hopeman 325", day: "Tuesday", time: Date(), category: "Men's").environmentObject(ViewModel())
}
