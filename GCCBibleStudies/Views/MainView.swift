//
//  MainView.swift
//  GCCBibleStudies
//
//  Created by Nathanael Kuhns on 11/19/24.
//

import SwiftUI

struct MainView: View {
    
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        TabView {
            if isLoggedIn {
                BibleStudyListView().tabItem {
                    Image(systemName: "list.bullet")
                    Text("Bible Studies")
                }
                
                CreateNewBSView().tabItem {
                    Image(systemName: "plus")
                    Text("New Bible Study")
                }
            } else {
                Text("Fetching bible studies...")
            }
        }
    }
}

#Preview {
    @State var isLoggedIn: Bool = true
    MainView(isLoggedIn: $isLoggedIn).environmentObject(ViewModel())
}
