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
    
    var body: some View {
        VStack {
            MainView()
        }.fullScreenCover(isPresented: $VM.isLoggedOut) {
            //
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
