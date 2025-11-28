// Package luhn implements a solution ot the problem on Go track of Exercism
package luhn

import (
	"strconv"
	"unicode"
)

// Valid determines whether or not the given number is valid per the Luhn formula.
func Valid(str string) bool {
	if len(str) <= 1 {
		return false
	}
	var sum int
	runeS := make([]rune, 0, len(str))
	for _, ch := range str {
		if !unicode.IsDigit(ch) && !unicode.IsSpace(ch) {
			return false
		}
		if !unicode.IsSpace(ch) {
			runeS = append([]rune{ch}, runeS...)
		}
	}
	if len(runeS) <= 1 {
		return false
	}
	for i := 0; i < len(runeS); i++ {
		if i%2 == 0 {
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
	}
	return sum%10 == 0
}
