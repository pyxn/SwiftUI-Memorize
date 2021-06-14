//
//  Memorize.swift
//  Memorize
//
//  Created by Pao Yu on 2021-05-24.
//

import Foundation

struct Memorize<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Memorize.Card>
    
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
    
    mutating func choose(_ card: Memorize.Card) {
        
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
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    
    /// A Card is a custom data type that can represent a
    /// card object with a face up and face down state.
    /// They are created in pairs.
    struct Card: Identifiable {
        let id: Int
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        let content: CardContent
        
        // MARK: - Bonus Time
        
        /// This could give matching bonus points if the user matches the card
        /// before a certain amount of time passes during which the card is face up
        
        /// can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        /// how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        /// the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        
        /// the accumulated time this card has been face up in the past
        /// i.e. not includin gthe current time it's been face up if it is currently so
        var pastFaceUpTime: TimeInterval = 0
        
        /// how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        /// percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        /// wheteher the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        /// whether we are currently face up, unmatched, and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        /// called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        /// called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
