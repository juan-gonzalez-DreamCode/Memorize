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
        return MemoryGame(numberOfPairsOfCards: 5) { pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            } else{
                return "⁉️"
            }
        }
    }

    @Published private var gameMemorize = createMemoryGame()
    
    var cards: [Card] {
        gameMemorize.cards
    }
    
    var score: Int {
        gameMemorize.score
    }
    
    var color: Color {
        .red
    }
    
    // MARK: - Intents
    func shuffle(){
        gameMemorize.shuffle()
    }
    
    func choose(_ card: Card) {
        gameMemorize.choose(card)
    }
}
