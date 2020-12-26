import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    // It doesnt re-render the whole thing because the Cards are identifiable, hence it can check
    // if somethign changes
    var body: some View {
        HStack {
            ForEach(viewModel.cards) {
                card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
        }.padding().foregroundColor(Color.orange)
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    // Currently this way of doing will have to introduce self. to all the "Attribute" being used due to closure
    // hence a cleaner method is to call method which returns the "View" instead
//    var body: some View {
//
//        GeometryReader {geometry in
//            ZStack {
//                if self.card.isFaceUp {
//                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
//                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
//                    Text(self.card.content)
//                } else {
//                    RoundedRectangle(cornerRadius: cornerRadius).fill()
//                }
//            }
//            .font(Font.system(size: min(geometry.size.width, geometry.size.height) * fontScaleFactor))
//        }
//    }
    
    var body: some View {
        GeometryReader {geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
        .font(Font.system(size: fontSize(size)))
    }
    
    // MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    
    // we can use _ in this case so that there isnt a need to declare the "name" when using the function
    func fontSize(_ size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
