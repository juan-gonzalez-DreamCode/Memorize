//
//  ContentView.swift
//  Memorize
//
//  Created by DreamCode on 5/02/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let emojis: [String] = ["👻", "🤡", "🤖", "🕷️"]
        
        HStack {
            ForEach(emojis.indices, id: \.self){ index in
                CardView(content: emojis[index])
            }
        }
        .foregroundColor(.red)
        .padding()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
         ZStack{
            let base = RoundedRectangle(cornerRadius: 12.0)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder( lineWidth: 2 )
                Text(content)
            } else {
                base.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
