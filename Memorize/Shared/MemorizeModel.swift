//
//  MemorizeModel.swift
//  Memorize
//
//  Created by Pao Yu on 2021-05-24.
//

import Foundation

struct MemorizeModel<CardContent> {
    
    private(set) var cards: Array<MemorizeModel.Card>
    
    init(numberOfCardPairs: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for index in 0..<numberOfCardPairs {
            let content: CardContent = createCardContent(index)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: MemorizeModel.Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
