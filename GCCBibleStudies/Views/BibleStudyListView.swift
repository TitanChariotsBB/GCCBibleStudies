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
