//
//  ContentView.swift
//  Memorize
//
//  Created by DreamCode on 5/02/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewGameMemorize: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4.0
    private let dealAnimation: Animation = .easeInOut(duration: 1)
    private let dealIternval: TimeInterval = 0.15
    private let deckWidth: CGFloat = 50
    
    var body: some View {
        VStack{
            cards
                .foregroundColor(viewGameMemorize.color)
            HStack{
                score
                Spacer()
                deck.foregroundColor(viewGameMemorize.color)
                Spacer()
                shuffle
            }
        }
        .padding()
    }
    
    private var score: some View {
        Text("Score: \(viewGameMemorize.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                viewGameMemorize.shuffle()
            }
        }
    }
    
    private var cards: some View {
        AspectVGrid(viewGameMemorize.cards, aspectRatio: aspectRatio){ card in
            if isDealt(card){
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
            }
        }
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewGameMemorize.cards.filter { !isDealt($0) }
    }
    
    @Namespace private var dealingNamespace
    
    private var deck: some View {
        ZStack{
            ForEach(undealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onTapGesture {
            deal()
        }
    }
    
    private func deal(){
        var delay: TimeInterval = 0
        for card in viewGameMemorize.cards {
            withAnimation(dealAnimation.delay(delay)){
                _ = dealt.insert(card.id)
            }
            delay += 0.5
        }
    }
    
    private func choose(_ card: Card){
        withAnimation(.easeInOut(duration: 0.5)){
            let scoreBeforeChoosing = viewGameMemorize.score
            viewGameMemorize.choose(card)
            let scoreChange = viewGameMemorize.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    
    @State private var lastScoreChange = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int{
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewGameMemorize: EmojiMemoryGame())
    }
}
