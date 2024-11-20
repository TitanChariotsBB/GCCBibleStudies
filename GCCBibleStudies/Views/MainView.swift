//
//  MainView.swift
//  GCCBibleStudies
//
//  Created by Nathanael Kuhns on 11/19/24.
//

import SwiftUI

struct MainView: View {
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
    MainView().environmentObject(ViewModel())
}
