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
    
    var body: some View {
        VStack(alignment: .leading) {
            if VM.currentUser != nil {
                Text("Welcome, \(VM.currentUser!.fname)").font(.largeTitle).bold().padding()
            } else {
                Text("Welcome, Guest").font(.largeTitle).bold().padding()
            }
            NavigationStack {
                ScrollView {
                    ForEach(VM.bibleStudies) { bibleStudy in
                        BibleStudyView(bs: bibleStudy)
                    }
                }
            }.searchable(text: $searchText)
        }.onAppear() {
            VM.getBibleStudies()
        }
    }
}

#Preview {
    BibleStudyListView().environmentObject(ViewModel())
}
