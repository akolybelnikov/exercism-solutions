// Package isogram provides a solution to the problem on the Go track of exercism
package isogram

import (
	"strings"
	"unicode"
)

// IsIsogram determines if a word or phrase is an isogram
// accepts a string argument and returns a boolean value
func IsIsogram(input string) bool {
	var isomap = map[rune]int{}
	for _, ch := range strings.ToLower(input) {
		if unicode.IsLetter(ch) {
			if _, ok := isomap[ch]; !ok {
				isomap[ch]++
			} else {
				return false
			}
		}
	}
	return true
}
