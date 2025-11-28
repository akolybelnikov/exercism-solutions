// Package luhn implements a solution ot the problem on Go track of Exercism
package luhn

import (
	"strconv"
	"strings"
)

// Valid determines whether or not the given number is valid per the Luhn formula.
func Valid(str string) bool {
	// Sanitize the string and check for sufficient length
	str = strings.ReplaceAll(str, " ", "")
	if len(str) <= 1 {
		return false
	}
	// Keep track of the total
	var sum int
	// Find the odd positions based on the length of the input string
	odd := len(str)%2 == 0
	// Iterate over the runes and double the current character's numeric value
	// if it's in an odd position relative to the end of the range
	for _, r := range str {
		// Check if the character is a digit and convert to integer
		d, err := strconv.Atoi(string(r))
		// return an error otherwise
		if err != nil {
			return false
		}
		if odd {
			d *= 2
			if d > 9 {
				d -= 9
			}
		}
		sum += d
		odd = !odd
	}
	// check for the Luhn's condition and return
	return sum%10 == 0
}
