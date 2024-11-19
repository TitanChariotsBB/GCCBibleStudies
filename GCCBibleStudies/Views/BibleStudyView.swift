//
//  BibleStudyView.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 11/18/24.
//

import SwiftUI

struct BibleStudyView: View {
    
    var name: String = "Bible Study Name"
    var location: String = "Location"
    var meetingTime: String = "Meeting Time"
    var category: String = "Category"
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name).font(.largeTitle).bold()
            Text(location).font(.title2)
            Text(meetingTime).font(.title2)
            Text(category).font(.title2)
            HStack {
                Button {
                    // onClick
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.blue).frame(width: 80, height: 30)
                        Text("Join").foregroundStyle(.white)
                    }
                }
                
                Button {
                    // onClick
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.blue).frame(width: 100, height: 30)
                        Text("Details").foregroundStyle(.white)
                    }
                }
                
                Spacer()
            }
            Spacer()
        }.padding()
    }
}

#Preview {
    BibleStudyView()
}
