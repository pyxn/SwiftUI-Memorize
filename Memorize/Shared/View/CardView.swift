//
//  CardView.swift
//  Memorize
//
//  Created by Pao Yu on 2021-05-23.
//

import SwiftUI

struct CardView: View {
    
    let card: MemorizeModel<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 13)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 2).foregroundColor(.blue)
                Text(card.content)
                    .font(.largeTitle)
                    .foregroundColor(.blue)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill().foregroundColor(.blue)
            }
        }
        .aspectRatio(1/1.618, contentMode: .fit)
    }
}
