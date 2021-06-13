//
//  CardView.swift
//  Memorize
//
//  Created by Pao Yu on 2021-05-23.
//

import SwiftUI

struct CardView: View {
    
    private let card: MemorizeViewModelEmoji.Card
    private let shape: RoundedRectangle = RoundedRectangle(cornerRadius: Constants.cornerRadius)
    
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
    
    init(_ card: MemorizeViewModelEmoji.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            
            if      card.isFaceUp   { showCardFaceUp()   }
            else if card.isMatched  { showCardHidden()   }
            else                    { showCardFaceDown() }
            
            Text(card.content)
                .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                .font(Font.system(size: Constants.fontSize))
                .scaleEffect()
                .foregroundColor(.blue)
                .opacity(card.isFaceUp ? 1 : 0)
        }
        .aspectRatio(Constants.aspectRatio, contentMode: .fit)
    }
    
    @ViewBuilder private func showCardFaceUp() -> some View {
        shape.fill().foregroundColor(.white)
        shape.strokeBorder(lineWidth: Constants.strokeWidth).foregroundColor(.blue)
        PieView(startAngle: Angle(degrees: Constants.pieAngleStart), endAngle: Angle(degrees: Constants.pieAngleEnd))
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
}
