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
        }
        .padding()
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
