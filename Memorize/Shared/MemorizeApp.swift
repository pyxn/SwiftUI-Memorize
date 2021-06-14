//
//  MemorizeApp.swift
//  Shared
//
//  Created by Pao Yu on 2021-05-17.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    private let game = MemorizeGameEmoji()
    
    var body: some Scene {
        WindowGroup {
            MemorizeGame(viewModel: game)
        }
    }
}
