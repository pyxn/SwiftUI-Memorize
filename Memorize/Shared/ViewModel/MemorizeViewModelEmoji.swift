//
//  MemorizeViewModel.swift
//  Memorize
//
//  Created by Pao Yu on 2021-05-24.
//

import SwiftUI

class MemorizeViewModelEmoji: ObservableObject {
    
    // var objectWillChange: ObservableObjectPublisher
    
    // Type members
    static let emojis = ["🌏", "🌴", "✨", "❄️", "🌸", "🐙", "🐲", "🎖"]
    static func createMemoryGame() -> MemorizeModel<String> {
        return MemorizeModel<String>(numberOfCardPairs: 8) { index in emojis[index] }
    }
    
    // Instance members
    @Published private var model: MemorizeModel<String> = createMemoryGame()
    var cards: Array<MemorizeModel<String>.Card> { return model.cards }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemorizeModel<String>.Card) {
        // objectWillChange.send() - redundant if @Published keyword is used
        model.choose(card)
    }
    
}
