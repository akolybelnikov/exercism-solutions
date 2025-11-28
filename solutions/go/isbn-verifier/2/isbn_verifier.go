// Package isbn implements a solution for the problem on the Go track of Exercism
package isbn

import (
	"strconv"
)

// IsValidISBN checks if the provided string is a valid ISBN-10.
func IsValidISBN(str string) bool {
	if str == "" {
		return false
	}
	var sum int
	runes := []rune(str)
	count := 10
	for i := 0; i < len(runes); i++ {
		// check if character is a dash
		if runes[i] == 45 {
			continue
		}
		// check if last character is X and add 10 in case it is
		if count == 1 && runes[i] == 88 {
			sum += 10
			// else check if converts to digit and calculate
			// if err it means a character is not a digit; return false
		} else {
			d, err := strconv.Atoi(string(runes[i]))
			if err != nil {
				return false
			}
			sum += d * count
		}
		count--
	}

	return count == 0 && sum%11 == 0
}
