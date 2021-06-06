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
                let shape = RoundedRectangle(cornerRadius: Constants.cornerRadius)
                if card.isFaceUp {
                    // Get ready to put a @ViewBuilder func here!
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: Constants.strokeWidth).foregroundColor(.blue)
                    Text(card.content)
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                } else if card.isMatched {
                    // Get ready to put a @ViewBuilder func here!
                    shape.opacity(Constants.opacity)
                } else {
                    // Get ready to put a @ViewBuilder func here!
                    shape.fill().foregroundColor(.blue)
                }
            }
            .aspectRatio(Constants.aspectRatio, contentMode: .fit)
    }
    
    init(_ card: MemorizeViewModelEmoji.Card) {
        self.card = card
    }
}
