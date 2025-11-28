package blackjack

var cards = map[string]int{
	"two":   2,
	"three": 3,
	"four":  4,
	"five":  5,
	"six":   6,
	"seven": 7,
	"eight": 8,
	"nine":  9,
	"ten":   10,
	"jack":  10,
	"queen": 10,
	"king":  10,
	"ace":   11,
}

const (
	Stand            string = "S"
	Hit                     = "H"
	Split                   = "P"
	AutomaticallyWin        = "W"
)

// ParseCard returns the integer value of a card following blackjack ruleset.
func ParseCard(card string) int {
	return cards[card]
}

// FirstTurn returns the decision for the first turn, given two cards of the
// player and one card of the dealer.
func FirstTurn(card1, card2, dealerCard string) string {
	val1 := ParseCard(card1)
	val2 := ParseCard(card2)
	sumUp := val1 + val2
	valDealer := ParseCard(dealerCard)
	switch {
	case val1 == 11 && val2 == 11:
		return Split
	case sumUp == 21 && valDealer < 10:
		return AutomaticallyWin
	case sumUp == 21 && valDealer >= 10:
		return Stand
	case sumUp >= 17 && sumUp <= 20:
		return Stand
	case sumUp >= 12 && sumUp <= 16 && valDealer < 7:
		return Stand
	default:
		return Hit
	}
}
