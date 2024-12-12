//
//  ProfileView.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 12/10/24.
//

import SwiftUI

struct ProfileView: View {
    
    @State var confettiseconds:Int = 2
    @State var showconfetti:Bool = false
    let countdown = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var testing:Bool
    @EnvironmentObject var VM: ViewModel
    
    @State var showCreateForm: Bool = false

    
    @Binding var tabSelection: Int
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    if VM.currentUser != nil {
                        VStack(alignment: .leading) {
                            Text("Welcome, \(VM.currentUser!.fname)").font(.largeTitle).bold().padding(.vertical, 15)
                            Text("Username: \(VM.currentUser!.username)")
                            Text("ID: \(VM.currentUser!.id)")
                        }.padding()
                        ScrollView {
                            Text("Bible studies you've created").font(.title2).bold()
                            ForEach(VM.getBibleStudiesCreated()) { bibleStudy in
                                ZStack {
                                    BibleStudyView(bs: bibleStudy).padding(.horizontal, 15).padding(.bottom, 15)
                                    DeleteBSButtonView(bs: bibleStudy)
                                }
                            }
                            Button {
                                showCreateForm = true
                            } label: {
                                Text("Create new bible study")
                            }.padding(.bottom, 40)
                            
                            Text("Bible studies you're joined").font(.title2).bold()
                            ForEach(VM.getBibleStudiesJoined()) { bibleStudy in
                                BibleStudyView(bs: bibleStudy).padding(.horizontal, 15).padding(.bottom, 15)
                            }
                            Button {
                                tabSelection = 1
                            } label: {
                                Text("Find bible studies to join")
                            }.padding(.bottom, 10)
                            
                        }
                    } else {
                        Text("You are not logged in. Please restart the app.")
                    }
                }
                .onAppear() {
                    if testing {
                        VM.currentUser = User(id: 8972, username: "Christian", passwordHash: "e7cf3ef4f17c3999a94f2c6f612e8a888e5b1026878e4e19398b23bd38ec221a", fname: "Christian", lname: "Abbott")
                    }
                    VM.getBibleStudies()
                }
                .sheet(isPresented: $showCreateForm) {
                    CreateNewBSView(showCreateNewBS: $showCreateForm,showconfetti: $showconfetti)
                }.offset(y:50)
                /*
                 found that this offset kept the view
                 at just about the right spot with the
                 confettimultipleview
                 */
                //.displayConfetti(active: $showconfetti)
                ConfettiMultipleView().onReceive(countdown) { _ in
                        //print(confettiseconds)
                        if confettiseconds > 0 {
                            confettiseconds -= 1
                        }
                        else {
                            confettiseconds = 1
                            showconfetti = false
                        }
                }.opacity(showconfetti ? 1 : 0).offset(y:-50)
            }
        }
    }
}

#Preview {
    @State var tabSelection = 1
    ProfileView(testing:true,tabSelection: $tabSelection).environmentObject(ViewModel())
}
