//
//  CardView.swift
//  Memorize
//
//  Created by Pao Yu on 2021-03-17.
//

import SwiftUI

struct CardView: View {
    
    @State private var animatedBonusRemaining: Double = 0
    
    public var card: MemorizeModel<String>.Card
    
    public var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    @ViewBuilder private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(-animatedBonusRemaining * 360 - 90), isClockwise: true)
                            .onAppear() {
                                startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(-card.bonusRemaining * 360 - 90), isClockwise: true)
                    }
                }
                    .padding(13)
                    .opacity(0.55)
                    .transition(AnyTransition.identity)
                    .foregroundColor(Color.white)
                Text(card.content)
                    .font(Font.system(size: getFontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 0.89).repeatForever(autoreverses: false) : Animation.default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
    private func getFontSize(for size: CGSize) -> CGFloat {
        return (min(size.width, size.height) / 1.618)
    }
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(Animation.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: MemorizeModel<String>.Card(id: 0, content: "👻"))
    }
}
