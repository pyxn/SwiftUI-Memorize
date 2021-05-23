//
//  ContentView.swift
//  Shared
//
//  Created by Pao Yu on 2021-05-17.
//

import SwiftUI

struct ContentView: View {
    
    var emojis: [String] = ["🌏", "⚡️", "🌴", "💫"]
    @State var emojiCount: Int = 4
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 55))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                    }
                }
            }
            Spacer()
            HStack {
                view_cardRemove
                Spacer()
                view_cardAdd
            }
            .font(.largeTitle)
        }
        .padding()
    }
    
    private var view_cardRemove: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
                .padding()
        }
    }
    
    private var view_cardAdd: some View {
        Button {
            if emojiCount < 4 {
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
