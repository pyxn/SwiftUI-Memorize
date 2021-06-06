//
//  MemorizeModel.swift
//  Memorize
//
//  Created by Pao Yu on 2021-05-24.
//

import Foundation

struct MemorizeModel<CardContent> where CardContent: Equatable {
    
    // A Card is a custom data type that can represent a
    // card object with a face up and face down state.
    // They are created in pairs.
    struct Card: Identifiable {
        let id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        let content: CardContent
    }
    
    private(set) var cards: Array<MemorizeModel.Card>
    
    private var indexOfLoneFaceUpCard: Int? {
        get { cards.indices.filter({ index in cards[index].isFaceUp }).loneItem }
        set { cards.indices.forEach({ index in cards[index].isFaceUp = (index == newValue) }) }
    }
    
    init(numberOfCardPairs: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for index in 0..<numberOfCardPairs {
            let content: CardContent = createCardContent(index)
            cards.append(Card(id: index * 2, content: content))
            cards.append(Card(id: index * 2 + 1, content: content))
        }
        cards.shuffle()
    }
    
    mutating func choose(_ card: MemorizeModel.Card) {
        
        // Trigger only when:
        // - selected card belongs to the original card array
        // - selected card is face down
        // - selected card has not been matched
        // Track index of the selected card
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            // Trigger only when:
            // - another card has already been tracked,
            //   this means two cards have now been selected.
            // Get the index of the other card
            if let potentialMatchIndex = indexOfLoneFaceUpCard {
                
                // Trigger only when:
                // - The content of the two cards are the same
                // Set both cards' match state to MATCHED
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                
                // Flip the selected card face up
                cards[chosenIndex].isFaceUp = true
                
                // Trigger only when:
                // - there are no cards being tracked
            } else {
                // Track the selected card
                indexOfLoneFaceUpCard = chosenIndex
            }
        }
    }
}
