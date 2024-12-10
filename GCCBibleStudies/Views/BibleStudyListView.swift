//
//  BibleStudyListView.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 11/19/24.
//

import SwiftUI

struct BibleStudyListView: View {
    @EnvironmentObject var VM: ViewModel
    
    var body: some View {
        // I don't think I should have to wrap this in a NavigationStack,
        // but for some reason the search bar and navigation title don't
        // show without it
        NavigationStack {
            ScrollView {
                VStack(spacing:320) {
                    ForEach((VM.searchtext.isEmpty ? VM.allBibleStudies : VM.filteredBibleStudies).sorted(by: {$0.title < $1.title})) { bibleStudy in
                        BibleStudyView(bs: bibleStudy)
                    }
                }
            }
            .searchable(text: $VM.searchtext,placement: .automatic,prompt: Text("Search Bible Studies..."))
            .searchScopes($VM.searchscope, scopes: {
                ForEach(VM.allsearchscopes, id:\.self) {
                    scope in
                    Text(scope.title)
                        .tag(scope)
                }
            })
            .navigationTitle(VM.currentUser != nil ? "Welcome \(VM.currentUser!.fname)" : "Welcome Guest")
        }
        .onAppear() {
            VM.getBibleStudies()
        }
    }
}


#Preview {
    var VM = ViewModel()
    BibleStudyListView()
        .environmentObject(VM)
}
