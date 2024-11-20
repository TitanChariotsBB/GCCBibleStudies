//
//  BibleStudyListView.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 11/19/24.
//

import SwiftUI

struct BibleStudyListView: View {
    @EnvironmentObject var VM: ViewModel
    
    @State var searchText: String = ""
    @State var myStudies: Bool = false
    var body: some View {
        NavigationStack {
            Toggle(isOn: $myStudies) {
                Text("Show only studies I've joied")
            }.padding()
            ScrollView {
                ForEach(VM.bibleStudies) { bs in
                    BibleStudyView(name: bs.title, description: bs.description, bookOfTheBible: bs.bookOfTheBible, location: bs.location, day: bs.day, time: bs.time, category: bs.category)
                }
            }
        }.searchable(text: $searchText)
    }
}

#Preview {
    BibleStudyListView().environmentObject(ViewModel())
}
