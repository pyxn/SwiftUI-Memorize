//
//  MemorizeGame.swift
//  Shared
//
//  Created by Pao Yu on 2021-05-17.
//

import SwiftUI

struct MemorizeGame: View {
    
    @ObservedObject var viewModel: MemorizeGameEmoji
    @State private var dealt = Set<Int>()
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                gameContentView
                gameDeckView
            }
            gameControlView
        }
        .padding()
    }
    
    var gameContentView: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 55))]) {
                    ForEach(viewModel.cards) { card in
                        if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                            Color.clear
                        } else {
                            CardView(card)
                                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                                .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                                .zIndex(zIndex(of: card))
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.choose(card)
                                    }
                                }
                        }
                    }
                }
            }
            Spacer()
        }
    }
    
    var gameDeckView: some View {
        ZStack {
            ForEach(viewModel.cards.filter { isUndealt($0) }) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(maxHeight: 89)
        .onTapGesture {
            for card in viewModel.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var gameControlView: some View {
        HStack {
            Button(action: {
                withAnimation {
                    viewModel.shuffle()
                }
            }) { Text("SHUFFLE") }
            .buttonStyle(BorderedButtonStyle(tint: Color.blue))
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    viewModel.restart()
                    dealt = []
                }
            }) { Text("RESTART") }
            .buttonStyle(BorderedButtonStyle(tint: Color.blue))
        }
        
    }
    
    private func deal(_ card: MemorizeGameEmoji.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: MemorizeGameEmoji.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: MemorizeGameEmoji.Card) -> Animation {
        var delay: Double = 0.0
        if let index = viewModel.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (3 / Double(viewModel.cards.count))
        }
        return Animation.easeInOut(duration: 1).delay(delay)
    }
    
    private func zIndex(of card: MemorizeGameEmoji.Card) -> Double {
        -Double(viewModel.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = MemorizeGameEmoji()
        game.choose(game.cards.first!)
        return MemorizeGame(viewModel: game)
            .preferredColorScheme(.light)
    }
}
