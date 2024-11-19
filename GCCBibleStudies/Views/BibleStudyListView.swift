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
            Text("Searching for \(searchText)").navigationTitle("GCC Bible Studies")
            Toggle(isOn: $myStudies) {
                Text("My Studies")
            }
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
