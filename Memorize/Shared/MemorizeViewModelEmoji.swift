//
//  MemorizeViewModel.swift
//  Memorize
//
//  Created by Pao Yu on 2021-05-24.
//

import SwiftUI

class MemorizeViewModelEmoji {
    
    // Type members
    static let emojis = ["🌏", "🌴", "✨", "❄️", "🌸", "🐙", "🐲", "🎖"]
    static func createMemoryGame() -> MemorizeModel<String> {
        return MemorizeModel<String>(numberOfCardPairs: 4) { index in emojis[index] }
    }
    
    // Instance members
    private var model: MemorizeModel<String> = createMemoryGame()
    var cards: Array<MemorizeModel<String>.Card> { return model.cards }
    
}
