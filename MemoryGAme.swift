import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        print("press choose \(card)")
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>() // this is an empty array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex) // var is for varying. Let is for variable that doesnt vary (different from js)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
     
    // This is something like protocol with Identifiable
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false // we can initialize some variable first, thus the "constructor" for card can take in lesser argument
        var content: CardContent
        var id: Int // this is like how RN.map requires the Index. This issue is from the (FromEach)
    }
}
