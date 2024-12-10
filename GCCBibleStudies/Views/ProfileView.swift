//
//  ProfileView.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 12/10/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var VM: ViewModel
    
    @State var showCreateForm: Bool = false
    
    @Binding var tabSelection: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            if VM.currentUser != nil {
                VStack(alignment: .leading) {
                    Text("Welcome, \(VM.currentUser!.fname)").font(.largeTitle).bold()
                    Text("Username: \(VM.currentUser!.username)")
                    Text("ID: \(VM.currentUser!.id)")
                }.padding()
                ScrollView {
                    Text("Bible studies you've created").font(.title2).bold()
                    ForEach(VM.getBibleStudiesCreated()) { bibleStudy in
                        BibleStudyView(bs: bibleStudy)
                    }
                    Button {
                        showCreateForm = true
                    } label: {
                        Text("Create new bible study")
                    }.padding(.bottom, 40)
                    
                    Text("Bible studies you're joined").font(.title2).bold()
                    ForEach(VM.getBibleStudiesJoined()) { bibleStudy in
                        BibleStudyView(bs: bibleStudy)
                    }
                    Button {
                        tabSelection = 1
                    } label: {
                        Text("Find bible studies to join")
                    }.padding(.bottom, 10)
                
                }
            } else {
                Text("You are not logged in. Please restart the app")
            }
        }
        .onAppear() {
            VM.getBibleStudies()
        }
        .sheet(isPresented: $showCreateForm) {
            CreateNewBSView(showCreateNewBS: $showCreateForm)
        }
    }
}

#Preview {
    @State var tabSelection = 1
    ProfileView(tabSelection: $tabSelection).environmentObject(ViewModel())
}
