import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    // This only for Struct and not for class as class is on the Heap which have pointer to them
    mutating func choose(card: Card) { // We cant just boolean = !boolean as the Card being passed in is Struct which is value-type which is a copy
        // we cant do chosenCard: Card = Array[idx] => and changing as Let also does a copy, thus the only way is the access the array directly(indirectly not possible)
        let chosenIndex: Int = self.index(of: card)
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
        print("press choose \(card)")
    }
    // of refers to external name (something that other methods have to use this name to call)
    // card refers to the internal name (something that can be used in this method
    func index(of card: Card) -> Int {
        for index in 0..<self.cards.count {
            if self.cards[index].id == card.id {
                return index
            }
        }
        return 0 // TODO: bogus!
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
        var isFaceUp: Bool = true
        var isMatched: Bool = false // we can initialize some variable first, thus the "constructor" for card can take in lesser argument
        var content: CardContent
        var id: Int // this is like how RN.map requires the Index. This issue is from the (FromEach)
    }
}
