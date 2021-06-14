//
//  MemorizeViewModel.swift
//  Memorize
//
//  Created by Pao Yu on 2021-05-24.
//

import SwiftUI

class MemorizeGameEmoji: ObservableObject {
    
    typealias Card = Memorize<String>.Card
    
    // var objectWillChange: ObservableObjectPublisher
    
    // Type members
    private static let emojis: Array<String> = ["🌏", "🌴", "✨", "❄️", "🌸", "🐙", "🐲", "🎖", "🎲", "🎱"]
    private static func createMemoryGame() -> Memorize<String> {
        return Memorize<String>(numberOfCardPairs: 10) { index in emojis[index] }
    }
    
    // Instance members
    @Published private  var model: Memorize<String> = createMemoryGame()
                        var cards: Array<Card> { return model.cards }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        // objectWillChange.send() - redundant if @Published keyword is used
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = MemorizeGameEmoji.createMemoryGame()
    }
}
