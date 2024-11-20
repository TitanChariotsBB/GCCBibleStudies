//
//  BibleStudyListView.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 11/19/24.
//

import SwiftUI

struct BibleStudyListView: View {
    @State var searchText: String = ""
    @State var myStudies: Bool = false
    var body: some View {
        NavigationStack {
            Toggle(isOn: $myStudies) {
                Text("Show only studies I've joied")
            }.padding()
            ScrollView {
                ForEach(0..<5) { idx in
                    BibleStudyView()
                }
            }
        }.searchable(text: $searchText)
    }
}

#Preview {
    BibleStudyListView()
}
