//
//  ContentView.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 11/18/24.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("needsAccount") var needsAccount: Bool = true
    
    @EnvironmentObject var VM: ViewModel
    
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        VStack {
            MainView(isLoggedIn: $isLoggedIn)
        }.fullScreenCover(isPresented: $VM.isLoggedOut) {
            isLoggedIn = true
        } content: {
            if needsAccount {
                CreateNewAccount()
            } else {
                UserLoginView()
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(ViewModel())
}
