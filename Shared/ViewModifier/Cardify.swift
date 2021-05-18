//
//  Cardify.swift
//  Memorize
//
//  Created by Pao Yu on 2021-04-24.
//

import SwiftUI

struct Cardify: AnimatableModifier /* ViewModifier, Animatable */ {
    
    private let cornerRadius: CGFloat = 13
    private let cardBackOpacity: Double = 0.13
    public var rotation: Double
    
    public var isFaceUp: Bool {
        if (rotation < 90) {
            return true
        } else {
            return false
        }
    }
    
    public var animatableData: Double {
        get {
            return rotation
        }
        set {
            rotation = newValue
        }
    }
    
    public init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.blue).opacity(cardBackOpacity)
                content
                
            }
                .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
}
