//
//  MainView.swift
//  GCCBibleStudies
//
//  Created by Nathanael Kuhns on 11/19/24.
//

import SwiftUI

struct MainView: View {
    
    @Binding var isLoggedIn: Bool
    
    @State var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            if isLoggedIn {
                BibleStudyListView().tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Bible Studies")
                }.tag(1)
                
                ProfileView(testing:false,tabSelection: $tabSelection).tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }.tag(2)
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
