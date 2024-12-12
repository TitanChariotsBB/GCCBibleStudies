//
//  ConfettiPieceView.swift
//  GCCBibleStudies
//
//  Created by Nathanael Kuhns on 12/11/24.
//

import SwiftUI

struct ConfettiPieceView: View {
    @State var animate = false
    @State var xSpeed = Double.random(in: 0.7...2)
    @State var zSpeed = Double.random(in: 1...2)
    @State var anchor = CGFloat.random(in: 0...1).rounded()
    
    var body: some View {
        Rectangle()
            .fill([Color.orange,Color.green,Color.blue,Color.red,Color.yellow,Color.purple].randomElement() ?? Color.green)
            .frame(width:20,height:20)
            .onAppear(perform: {animate = true})
            .rotation3DEffect(.degrees(animate ? 360:0), axis: (x:1,y:0,z:0))
            .animation(.linear(duration: xSpeed).repeatForever(autoreverses: false),value: animate)
            .rotation3DEffect(.degrees(animate ? 360:0), axis: (x:0,y:0,z:1),anchor: UnitPoint(x: anchor, y: anchor))
            .animation(.linear(duration:zSpeed).repeatForever(autoreverses: false), value: animate)
    }
}

#Preview {
    ConfettiPieceView()
}
