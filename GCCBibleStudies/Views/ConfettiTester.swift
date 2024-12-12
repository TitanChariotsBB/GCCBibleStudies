//
//  ConfettiTester.swift
//  GCCBibleStudies
//
//  Created by Nathanael Kuhns on 12/11/24.
//

import SwiftUI

struct ConfettiTester: View {
    @State var showconfetti:Bool = false
    var body: some View {
        VStack {
            Button {
                showconfetti = true
            } label: {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
        }.displayConfetti(active: $showconfetti)
    }
}

#Preview {
    ConfettiTester()
}
