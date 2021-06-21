import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {

    //MARK: - Properties
    var cards = [Card]()
    var type: DeckType
    var trump: Suit?

    var total:Int {
        return type.rawValue
    }
}

extension Deck {

    init(with type: DeckType) {
        self.type = type
        self.cards = createDeck(suits: Suit.allCases, values: Value.allCases)
    }

    public func createDeck(suits:[Suit], values:[Value]) -> [Card] {
        var cards: [Card] = []
        let sortedSuits = suits.sorted(by: { $0.rawValue < $1.rawValue })
        let sortedValues = values.sorted(by: { $0.rawValue < $1.rawValue })
        
        for suit in sortedSuits {
            for value in sortedValues {
                let card = Card(suit: suit, value: value)
                cards.append(card)
            }
        }
        return cards
    }

    public mutating func shuffle() {
        self.cards.shuffle()
    }

    public mutating func defineTrump() {
        guard let firstCard = cards.first else { return }
        let trumpSuit = firstCard.suit
        self.trump = trumpSuit
        self.setTrumpCards(for: trumpSuit)
    }

    public mutating func initialCardsDealForPlayers(players: [Player]) {
        let handCardsCount = 6
        for player in players {
            player.hand = Array(cards.dropFirst(handCardsCount))
            cards.removeFirst(handCardsCount)
        }
        
    }

    public mutating func setTrumpCards(for suit:Suit) {
        self.cards = cards.map { card -> Card in
            if card.suit == suit {
                return Card(suit: card.suit, value: card.value, isTrump: true)
            }
            return card
        }
    }
}
