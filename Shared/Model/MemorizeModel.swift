//
//  Model.swift
//  Memorize
//
//  Created by Pao Yu on 2021-03-17.
//

import Foundation

struct MemorizeModel<CardContent> where CardContent: Equatable {
    
    // MARK: - Model Properties
    // Setting this is private to the MemorizeModel class, but reading it is available to public.
    private(set) var cards: Array<Card>
    
    private var cardFaceUpIndex: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.firstOfOneElementArray
        }
        set {
            for index in cards.indices {
                if index == newValue {
                    cards[index].isFaceUp = true
                } else {
                    cards[index].isFaceUp = false
                }
            }
        }
    }
    
    // MARK: - Initializers
    public init (pairsOfCards: Int, getCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<pairsOfCards {
            let content: CardContent = getCardContent(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
        cards.shuffle()
    }
    
    // MARK: - User Actions
    public mutating func choose(card: Card) {
        // print("card chosen: \(card)")
        if let chosenIndex: Int =   cards.firstIndex(matching: card),
                                    !cards[chosenIndex].isFaceUp,
                                    !cards[chosenIndex].isMatched {
            
            if let potentialMatchIndex = cardFaceUpIndex {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                cardFaceUpIndex = chosenIndex
            }
        }
    }
    
    // MARK: - Inner Types
    
    struct Card: Identifiable {
        public var id: Int
        public var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        public var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        public var content: CardContent
        
        // MARK: - Bonus Time
        // This could give matching bonus points if the user matches the card
        // before a certain amount of time passes during which the card is face up.
        
        // It can be zero which means there is no bonus available for this card.
        public var bonusTimeLimit: TimeInterval = 6
        
        // How long the card has been face up
        public var bonusTimeFaceUp: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // the last time this card was turned face up (and is still face up)
        public var lastFaceUpDate: Date?
        
        // the accumulated time this card has been face up in the past
        // not including the current time it's been face up if it is currently face up
        public var pastFaceUpTime: TimeInterval = 0
        
        // how much time is left before the bonus opportunity runs out
        public var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - bonusTimeFaceUp)
        }
        
        // percentage of bonus time remaining
        public var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        // whether the card was matched during the bonus time period
        public var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        public var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to the face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = bonusTimeFaceUp
            self.lastFaceUpDate = nil
        }
    }
}
