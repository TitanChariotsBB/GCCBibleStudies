//
//  ProfileView.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 12/10/24.
//

import SwiftUI

struct ProfileView: View {
    @State var confquarterseconds:Int = 4
    @State var showconfetti:Bool = false
    @State var confopacity:Double = 0.0
    let countdown = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    
    var testing:Bool
    @EnvironmentObject var VM: ViewModel
    
    @State var showCreateForm: Bool = false

    
    @State var isShowingDialog: Bool = false
    
    @Binding var tabSelection: Int
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // empty text to push the rest of the VStack down
                    Text("").padding(.bottom)
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
                                DeleteBSButtonView(bs: bibleStudy, isShowingDialog: $isShowingDialog)
                            }.confirmationDialog("Are you sure you want to delete this bible study?", isPresented: $isShowingDialog) {
                                Button("Delete", role: .destructive) {
                                    VM.deleteBibleStudy(bibleStudyId: bibleStudy.id)
                                    isShowingDialog = false
                                }
                                Button("Cancel", role: .cancel) {
                                    isShowingDialog = false
                                }
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
                    // added this text and it seems to fix the scrolling issues
                    Text("").padding(.top,60)
                }
                .onAppear() {
                    if testing {
                        VM.currentUser = User(id: 8972, username: "Christian", passwordHash: "e7cf3ef4f17c3999a94f2c6f612e8a888e5b1026878e4e19398b23bd38ec221a", fname: "Christian", lname: "Abbott")
                    }
                    VM.getBibleStudies()
                }
                .sheet(isPresented: $showCreateForm) {
                    CreateNewBSView(showCreateNewBS: $showCreateForm,showconfetti: $showconfetti)
                }
                /*
                 found that this offset kept the view
                 at just about the right spot with the
                 confettimultipleview
                 */
                //.displayConfetti(active: $showconfetti)
                ConfettiMultipleView().onReceive(countdown) { _ in
                        //print(confquarterseconds)
                        if confquarterseconds > 0 && showconfetti {
                            if confquarterseconds == 4 {
                                confopacity = 1.0
                            }
                            else {
                                confopacity -= 0.25
                            }
                            confquarterseconds -= 1
                        }
                        else if confquarterseconds == 0 {
                            confquarterseconds = 4
                            showconfetti = false
                        }
                }
                .opacity(showconfetti ? confopacity : 0)
                .offset(y:-20)
            }
        }
    }
}

#Preview {
    @State var tabSelection = 1
    ProfileView(testing:true,tabSelection: $tabSelection).environmentObject(ViewModel())
}
