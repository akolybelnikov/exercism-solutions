// Package luhn implements a solution ot the problem on Go track of Exercism
package luhn

import (
	"strconv"
	"unicode"
)

// Valid determines whether or not the given number is valid per the Luhn formula.
func Valid(str string) bool {
	// Keep track of the total and the current character position
	var sum, index int
	// Convert to runes to operate on Unicode characters
	runeS := []rune(str)
	// Return early if not enough characters
	if len(runeS) <= 1 {
		return false
	}
	// Iterate over the runes from end to start
	for i := len(runeS) - 1; i >= 0; i-- {
		// Return false if a character is not numeric or whitespace
		if !unicode.IsDigit(runeS[i]) && !unicode.IsSpace(runeS[i]) {
			return false
		}
		// Skip whitespaces
		if unicode.IsSpace(runeS[i]) {
			continue
		}
		// Double the character numeric value if it's in an even position
		if index%2 == 0 {
			if d, err := strconv.Atoi(string(runeS[i])); err == nil {
				sum += d
			}
		} else {
			if d, err := strconv.Atoi(string(runeS[i])); err == nil {
				dd := d * 2
				if dd > 9 {
					dd -= 9
				}
				sum += dd
			}
		}
		// Increase the position for a valid character
		index++
	}
	// Return false if not enough valid characters
	if index <= 1 {
		return false
	}
	// Else check for the Luhn's condition and return
	return sum%10 == 0
}
