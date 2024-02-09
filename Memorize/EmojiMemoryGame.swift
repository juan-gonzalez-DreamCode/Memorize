//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by DreamCode on 6/02/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let emojis = ["🚀", "👩🏼‍🚀", "🛰️", "👻", "🤡", "🤖", "🕷️", "👽", "⚽️", "⛳️", "🎪", "🎃", "🙀", "🔑"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 2) { pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            } else{
                return "⁉️"
            }
        }
    }

    @Published private var model = createMemoryGame()
    
    var cards: [Card] {
        model.cards
    }
    
    var color: Color {
        .red
    }
    
    // MARK: - Intents
    func shuffle(){
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
