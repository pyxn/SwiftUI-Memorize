//
//  CardView.swift
//  Memorize
//
//  Created by Pao Yu on 2021-05-23.
//

import SwiftUI

struct CardView: View {
    
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 13)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 2).foregroundColor(.blue)
                Text(content)
                    .font(.largeTitle)
                    .foregroundColor(.blue)
            } else {
                shape.fill().foregroundColor(.blue)
            }
        }
        .aspectRatio(1/1.618, contentMode: .fit)
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(content: "🌏")
        CardView(content: "🌏")
    }
}
