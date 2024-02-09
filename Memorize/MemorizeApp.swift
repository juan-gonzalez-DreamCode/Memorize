//
//  MemorizeApp.swift
//  Memorize
//
//  Created by DreamCode on 5/02/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewGameMemorize: game)
        }
    }
}
