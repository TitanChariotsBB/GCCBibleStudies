//
//  MainView.swift
//  GCCBibleStudies
//
//  Created by Nathanael Kuhns on 11/19/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var VM:ViewModel
    var body: some View {
        TabView {
            
            BibleStudyListView(SVM:SearchViewModel(viewmodel: VM)).tabItem {
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
    var VM = ViewModel()
    MainView().environmentObject(VM)
}
