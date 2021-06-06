//
//  MemorizeApp.swift
//  Shared
//
//  Created by Pao Yu on 2021-05-17.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    private let game = MemorizeViewModelEmoji()
    
    var body: some Scene {
        WindowGroup {
            MemorizeGameView(viewModel: game)
        }
    }
}
