//
//  ConfettiMultipleView.swift
//  GCCBibleStudies
//
//  Created by Nathanael Kuhns on 12/11/24.
//

import SwiftUI

struct ConfettiMultipleView: View {
    var count:Int = 30
    @State var ypos:CGFloat = 0
    var body: some View {
        ZStack {
            ForEach(0..<count,id:\.self) { _ in
                ConfettiPieceView().position(x:CGFloat.random(in: 0...UIScreen.main.bounds.width), y: ypos != 0 ? CGFloat.random(in: 0...UIScreen.main.bounds.height/2) : ypos
                )
            }
        }
        //.ignoresSafeArea()
        .onAppear {
            ypos = CGFloat.random(in: 0...UIScreen.main.bounds.height)
        }
        .frame(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}

#Preview {
    ConfettiMultipleView()
}
