import SwiftUI

// ViewModel
// This is like our Model Class in CS2103T
class EmojiMemoryGame: ObservableObject { // ObservableObject is only for class
    // private(set) works like a glassdoor, where others can see inside EmojiMemoryGame but unable to access it
    // this in a way to do an inline method
    // We can leave out the type as swift can infer the type from the method in memory game
    // The _ means it can be anything because it is unused
    // We can "remove" the comma as the inline method is the last argument, so we can just leave it in the {} instead
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        // this refers to a constant array
        let emojis: Array<String> = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) {pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        // Instead of calling this method, we will use a property wrapper @Published
        // objectWillChange.send()
        model.choose(card: card)
    }
}

struct EmojiMemoryGame_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
