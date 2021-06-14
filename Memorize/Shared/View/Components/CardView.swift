//
//  CardView.swift
//  Memorize
//
//  Created by Pao Yu on 2021-05-23.
//

import SwiftUI

struct CardView: View {
    
    @State private var animatedBonusRemaining: Double = 0
    
    private let card: MemorizeGameEmoji.Card
    private let shape: RoundedRectangle = RoundedRectangle(cornerRadius: Constants.cornerRadius)
    
    init(_ card: MemorizeGameEmoji.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            
            if      card.isFaceUp   { showCardFaceUp()   }
            else                    { showCardFaceDown() }
            
            Text(card.content)
                .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
                .font(Font.system(size: Constants.fontSize))
                .scaleEffect()
                .foregroundColor(.blue)
                .opacity(card.isFaceUp ? 1 : 0)
                .scaleEffect(card.isFaceUp ? 1 : 0)
        }
        .aspectRatio(Constants.aspectRatio, contentMode: .fit)
        .rotation3DEffect(Angle.degrees(card.isFaceUp ? 0 : 180), axis: (0, 1, 0))
    }
    
    @ViewBuilder private func showCardFaceUp() -> some View {
        shape.fill().foregroundColor(.white)
        shape.strokeBorder(lineWidth: Constants.strokeWidth).foregroundColor(.blue)
        
        Group {
            if card.isConsumingBonusTime {
                PieView(startAngle: Angle(degrees: Constants.pieAngleStart), endAngle: Angle(degrees: (1 - animatedBonusRemaining) * 360 - 90))
                    .onAppear {
                        animatedBonusRemaining = card.bonusRemaining
                        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                            animatedBonusRemaining = 0
                        }
                    }
            } else {
                PieView(startAngle: Angle(degrees: Constants.pieAngleStart), endAngle: Angle(degrees: (1 - card.bonusRemaining) * 360 - 90))
            }
        }
            .foregroundColor(.blue)
            .padding(Constants.piePadding)
            .opacity(Constants.pieOpacity)
    }
    
    @ViewBuilder private func showCardFaceDown() -> some View {
        shape.fill().foregroundColor(.blue)
    }
    
    @ViewBuilder private func showCardHidden() -> some View {
        shape.opacity(Constants.opacity)
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (Constants.fontSize / Constants.fontScale)
    }
    
    private struct Constants {
        static let fontSize:        CGFloat     = 34
        static let fontScale:       CGFloat     = 1.618
        static let cornerRadius:    CGFloat     = 13
        static let strokeWidth:     CGFloat     = 2
        static let aspectRatio:     CGFloat     = 1/1.618
        static let opacity:         Double      = 0
        static let pieAngleStart:   Double      = 0 - 90
        static let pieAngleEnd:     Double      = 110 - 90
        static let piePadding:      CGFloat     = 5
        static let pieOpacity:      Double      = 0.34
    }
}

