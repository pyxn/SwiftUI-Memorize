//
//  View+Cardify.swift
//  Memorize
//
//  Created by Pao Yu on 2021-04-24.
//

import SwiftUI

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
