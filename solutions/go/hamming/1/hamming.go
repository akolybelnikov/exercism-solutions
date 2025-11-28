// Package hamming provides a solution to the Exercism task Hamming
package hamming

import (
	"errors"
)

// Distance calculates the Hamming Distance between two DNA strands
func Distance(a, b string) (int, error) {
	// Return an error if inputs are empty or incomparable
	if err := len(a) != len(b); err {
		return 0, errors.New("please provide correct inputs")
	}
	// Return 0 if inputs are identical, or the number of differences otherwise
	num := 0
	runeA := []rune(a)
	runeB := []rune(b)
	for i := 0; i < len(runeA); i++ {
		if v := runeA[i] != runeB[i]; v {
			num += 1
		}
	}
	return num, nil
}
