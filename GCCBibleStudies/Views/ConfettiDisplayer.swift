// ended up not actually using this

import SwiftUI

struct ConfettiDisplayer: ViewModifier {
    @Binding var active:Bool {
        didSet {
            if active {
                opacity = 1
            }
        }
    }
    @State var opacity = 1.0 {
        didSet {
            if opacity == 0 {
                active = false
            }
        }
    }
    
    let animationtime = 3.0
    let fadetime = 2.0
    
    func body(content:Content) ->some View {
        let _ = print("body entered!")
        if #available(iOS 17.0, *) {
            let _ = print("body if entered")
            content
                .overlay(active ? ConfettiMultipleView().opacity(opacity) : nil)
                .sensoryFeedback(.success, trigger: active)
                .task {
                    await handleAnimationSequence()
                }
        }
        else {
            let _ = print("body else entered")
            content
                .overlay(active ? ConfettiMultipleView().opacity(opacity) : nil)
                .task {
                    await handleAnimationSequence()
                }
        }
    }
    
    private func handleAnimationSequence() async {
        do {
            print("handleAnimationCalled!")
            // what's happening right now is that for animation time the confetti will work
            // wait for animationtime seconds and then fade out
            try await Task.sleep(nanoseconds: UInt64(animationtime * 1_000_000_000))
            withAnimation(.easeOut(duration:fadetime)) {
                opacity = 0
            }
        }
        catch {print(error)}
    }
}

extension View {
    func displayConfetti(active: Binding<Bool>) -> some View {
        self.modifier(ConfettiDisplayer(active:active))
    }
}

/*#Preview {
    ConfettiDisplayer()
}*/
