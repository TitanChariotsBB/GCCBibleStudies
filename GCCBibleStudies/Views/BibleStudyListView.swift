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
            if VM.currentUser != nil {
                Text("Welcome, \(VM.currentUser!.fname)").font(.largeTitle).bold()
            }
            Toggle(isOn: $myStudies) {
                Text("Show only studies I've joied")
            }.padding()
            ScrollView {
                ForEach(VM.bibleStudies) { bibleStudy in
                    BibleStudyView(bs: bibleStudy)
                }
            }
        }.searchable(text: $searchText)
    }
}

#Preview {
    BibleStudyListView().environmentObject(ViewModel())
}
