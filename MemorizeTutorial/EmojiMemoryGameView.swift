import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    // It doesnt re-render the whole thing because the Cards are identifiable, hence it can check
    // if somethign changes
    var body: some View {
        Grid(viewModel.cards) {
            card in
            CardView(card: card).onTapGesture {
                self.viewModel.choose(card: card)
            }.padding(5)
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
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if (card.isFaceUp || !card.isMatched) {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockWise: true).padding(5).opacity(0.4)
                Text(card.content).font(Font.system(size: fontSize(size)))
            }.cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    // MARK: - Drawing Constants
    
    // we can use _ in this case so that there isnt a need to declare the "name" when using the function
    private func fontSize(_ size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
