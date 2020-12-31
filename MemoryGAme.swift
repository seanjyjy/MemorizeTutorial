import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    // This only for Struct and not for class as class is on the Heap which have pointer to them
    mutating func choose(card: Card) { // We cant just boolean = !boolean as the Card being passed in is Struct which is value-type which is a copy
        // we cant do chosenCard: Card = Array[idx] => and changing as Let also does a copy, thus the only way is the access the array directly(indirectly not possible)
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
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
