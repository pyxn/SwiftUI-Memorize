//
//  Cardify.swift
//  Memorize
//
//  Created by Pao Yu on 2021-06-07.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    internal var isFaceUp: Bool
    
    private struct Constants {
        static let cornerRadius:    CGFloat     = 13
        static let strokeWidth:     CGFloat     = 2
        static let aspectRatio:     CGFloat     = 1/1.618
        static let opacity:         Double      = 0
    }
    
    func body(content: Content) -> some View {
        let shape: RoundedRectangle = RoundedRectangle(cornerRadius: Constants.cornerRadius)
        if isFaceUp {
            shape
                .fill()
                .foregroundColor(.white)
            shape
                .strokeBorder(lineWidth: Constants.strokeWidth)
                .foregroundColor(.blue)
            content
        } else {
            shape
                .fill()
                .foregroundColor(.blue)
        }
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
