package dndcharacter

import (
	"math"
	"math/rand"
	"sort"
)

type Attributes struct {
	Strength     int
	Dexterity    int
	Constitution int
	Intelligence int
	Wisdom       int
	Charisma     int
}

func generateAttributes() Attributes {
	return Attributes{
		Strength:     Ability(),
		Dexterity:    Ability(),
		Constitution: Ability(),
		Intelligence: Ability(),
		Wisdom:       Ability(),
		Charisma:     Ability(),
	}
}

type Character struct {
	*Attributes
	Hitpoints int
}

// Modifier calculates the ability modifier for a given ability score
func Modifier(score int) int {
	return int(math.Floor(float64(score-10) / 2.0))
}

// Ability uses randomness to generate the score for an ability
func Ability() int {
	digits := make([]int, 4)
	for i := 0; i < 4; i++ {
		digits[i] = rand.Intn(6) + 1
	}
	sort.Ints(digits)
	return digits[1] + digits[2] + digits[3]
}

// GenerateCharacter creates a new Character with random scores for abilities
func GenerateCharacter() Character {
	attrs := generateAttributes()
	return Character{
		Attributes: &attrs,
		Hitpoints:  10 + Modifier(attrs.Constitution),
	}
}
