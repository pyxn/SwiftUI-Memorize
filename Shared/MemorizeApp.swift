//
//  MemorizeApp.swift
//  Shared
//
//  Created by Pao Yu on 2021-03-17.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    private let game = MemorizeEmojiViewModel()
    
    public var body: some Scene {
        WindowGroup {
            MainView(viewModel: game)
        }
    }
}
