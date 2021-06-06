//
//  MemorizeGameView.swift
//  Shared
//
//  Created by Pao Yu on 2021-05-17.
//

import SwiftUI

struct MemorizeGameView: View {
    
    @ObservedObject var viewModel: MemorizeViewModelEmoji
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 89))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card)
                            .onTapGesture { viewModel.choose(card) }
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let game = MemorizeViewModelEmoji()
    
    static var previews: some View {
        MemorizeGameView(viewModel: game)
            .preferredColorScheme(.light)
        MemorizeGameView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
