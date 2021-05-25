//
//  ContentView.swift
//  Shared
//
//  Created by Pao Yu on 2021-05-17.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: MemorizeViewModelEmoji
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 55))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
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
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
