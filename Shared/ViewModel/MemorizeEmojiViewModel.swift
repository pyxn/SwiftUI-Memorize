//
//  MemorizeEmojiViewModel.swift
//  Memorize
//
//  Created by Pao Yu on 2021-03-17.
//

import SwiftUI

class MemorizeEmojiViewModel: ObservableObject {
    
    @Published private var model: MemorizeModel<String> = MemorizeEmojiViewModel.createMemorizeEmojiGame()
    
    private static func createMemorizeEmojiGame() -> MemorizeModel<String> {
        let emojis: Array<String> = ["👻", "🤖", "🐶"]
        return MemorizeModel<String>(pairsOfCards: emojis.count, getCardContent: { (pairIndex: Int) -> String in
            return emojis[pairIndex]
        })
    }
        
    // MARK: - Access to the Model
    
    public var cards: Array<MemorizeModel<String>.Card> {
        model.cards
    }
    
    // MARK: - User Intent Functions
    
    public func choose(card: MemorizeModel<String>.Card) {
        model.choose(card: card)
    }
    
    public func resetGame() {
        model = MemorizeEmojiViewModel.createMemorizeEmojiGame()
    }
}
