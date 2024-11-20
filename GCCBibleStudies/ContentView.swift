//
//  ContentView.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 11/18/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LoginView()
    }
}

#Preview {
    ContentView().environmentObject(ViewModel())
}
