//
//  MemorizeViewModel.swift
//  Memorize
//
//  Created by Pao Yu on 2021-05-24.
//

import SwiftUI

class MemorizeViewModelEmoji: ObservableObject {
    
    typealias Card = MemorizeModel<String>.Card
    
    // var objectWillChange: ObservableObjectPublisher
    
    // Type members
    private static let emojis: Array<String> = ["🌏", "🌴", "✨", "❄️", "🌸", "🐙", "🐲", "🎖"]
    private static func createMemoryGame() -> MemorizeModel<String> {
        return MemorizeModel<String>(numberOfCardPairs: 8) { index in emojis[index] }
    }
    
    // Instance members
    @Published private  var model: MemorizeModel<String> = createMemoryGame()
                        var cards: Array<Card> { return model.cards }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        // objectWillChange.send() - redundant if @Published keyword is used
        model.choose(card)
    }
    
}
