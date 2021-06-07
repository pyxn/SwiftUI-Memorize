//
//  MemorizeGameView.swift
//  Shared
//
//  Created by Pao Yu on 2021-05-17.
//

import SwiftUI

struct MemorizeGameView: View {
    
    @ObservedObject var viewModel: MemorizeViewModelEmoji
    
    var body: some View {
        
        ScrollView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 55))]) {
                        ForEach(viewModel.cards) { card in
                            cardView(for: card)
                        }
                    }
                }
                Spacer()
            }
        }
        .padding()
    }
    
    @ViewBuilder private func cardView(for card: MemorizeViewModelEmoji.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else {
            CardView(card)
                .onTapGesture { viewModel.choose(card) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        let game = MemorizeViewModelEmoji()
        game.choose(game.cards.first!)
        return MemorizeGameView(viewModel: game)
            .preferredColorScheme(.light)
//        MemorizeGameView(viewModel: game)
//            .preferredColorScheme(.dark)
    }
}
