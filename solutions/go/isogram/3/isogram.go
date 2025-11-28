// Package isogram provides a solution to the problem on the Go track of exercism
package isogram

import (
	"unicode"
)

// IsIsogram determines if a word or phrase is an isogram
// accepts a string argument and returns a boolean value
func IsIsogram(input string) bool {
	var isomap = map[rune]int{}
	for _, ch := range input {
		if unicode.IsLetter(ch) {
			ch = unicode.ToLower(ch)
			if isomap[ch] > 0 {
				return false
			}
			isomap[ch]++
		}
	}
	return true
}
