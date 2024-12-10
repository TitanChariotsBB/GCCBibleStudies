//
//  BibleStudyListView.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 11/19/24.
//

import SwiftUI

struct BibleStudyListView: View {
    @EnvironmentObject var VM: ViewModel
    
    @StateObject var SVM: SearchViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing:20) {
                ForEach(VM.bibleStudies) { bibleStudy in
                    BibleStudyView(bs: bibleStudy)
                }
            }
        }
        .searchable(text: $SVM.searchtext,placement: .automatic,prompt: Text("Search Bible Studies..."))
        .navigationTitle(VM.currentUser != nil ? "Welcome \(VM.currentUser!.fname)" : "Welcome Guest")
    }
}


#Preview {
    var VM = ViewModel()
    BibleStudyListView(SVM:SearchViewModel(viewmodel:VM))
        .environmentObject(VM)
}
