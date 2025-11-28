// Package luhn implements a solution ot the problem on Go track of Exercism
package luhn

import (
	"strconv"
	"strings"
)

// Valid determines whether or not the given number is valid per the Luhn formula.
func Valid(str string) bool {
	// Keep track of the total and the current character position
	var sum int
	// Convert to runes to operate on Unicode characters
	runeS := []rune(strings.ReplaceAll(str, " ", ""))
	// Return early if not enough characters
	if len(runeS) <= 1 {
		return false
	}
	odd := false
	// Iterate over the runes from end to start
	for i := len(runeS) - 1; i >= 0; i-- {
		// Check if the character is a digit and convert to integer
		d, err := strconv.Atoi(string(runeS[i]))
		if err != nil {
			return false
		}
		// Double the character numeric value if it's in an odd position
		if odd {
			d = d * 2
			if d > 9 {
				d -= 9
			}
		}
		// Increase the sum
		sum += d
		// Maintain the position with the boolean
		odd = !odd
	}
	// check for the Luhn's condition and return
	return sum%10 == 0
}
