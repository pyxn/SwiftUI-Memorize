//
//  MainView.swift
//  Shared
//
//  Created by Pao Yu on 2021-03-17.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject public var viewModel: MemorizeEmojiViewModel
    
    public var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card)
                    .onTapGesture {
                        withAnimation(Animation.linear(duration: 0.618)) {
                            viewModel.choose(card: card)
                        }
                    }
                    .padding(8)
            }
                .padding()
                .foregroundColor(Color.blue)
            Button(action: {
                withAnimation(Animation.easeInOut(duration: 0.618)) {
                    viewModel.resetGame()
                }
            }, label: { Text("NEW GAME") })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = MemorizeEmojiViewModel()
        game.choose(card: game.cards[0])
        return MainView(viewModel: game)
    }
}
