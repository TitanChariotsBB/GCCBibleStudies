//
//  ContentView.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 11/18/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BibleStudyListView().tabItem {
                Image(systemName: "list.bullet")
                Text("Bible Studies")
            }
            
            CreateNewBSView().tabItem {
                Image(systemName: "plus")
                Text("New Bible Study")
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(ViewModel())
}
