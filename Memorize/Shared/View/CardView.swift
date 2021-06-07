//
//  CardView.swift
//  Memorize
//
//  Created by Pao Yu on 2021-05-23.
//

import SwiftUI

struct CardView: View {
    
    private let card: MemorizeViewModelEmoji.Card
    
    private struct Constants {
        static let cornerRadius:    CGFloat     = 13
        static let strokeWidth:     CGFloat     = 2
        static let aspectRatio:     CGFloat     = 1/1.618
        static let opacity:         Double      = 0
    }
    
    var body: some View {
            ZStack {
                if      card.isFaceUp  { showCardFaceUp()   }
                else if card.isMatched { hideCard()         }
                else                   { showCardFaceDown() }
            }
            .aspectRatio(Constants.aspectRatio, contentMode: .fit)
    }
    
    @ViewBuilder private func showCardFaceUp() -> some View {
        let shape = RoundedRectangle(cornerRadius: Constants.cornerRadius)
        shape.fill().foregroundColor(.white)
        shape.strokeBorder(lineWidth: Constants.strokeWidth).foregroundColor(.blue)
        PieView(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 110 - 90))
            .foregroundColor(.blue)
            .padding(5)
            .opacity(0.34)
        Text(card.content)
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
    
    @ViewBuilder private func showCardFaceDown() -> some View {
        let shape = RoundedRectangle(cornerRadius: Constants.cornerRadius)
        shape.fill().foregroundColor(.blue)
    }
    
    @ViewBuilder private func hideCard() -> some View {
        let shape = RoundedRectangle(cornerRadius: Constants.cornerRadius)
        shape.opacity(Constants.opacity)
    }
    
    init(_ card: MemorizeViewModelEmoji.Card) {
        self.card = card
    }
}
