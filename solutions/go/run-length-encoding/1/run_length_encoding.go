// Package encode implements a solution to the problem on Go track of exercism
package encode

import (
	"bytes"
	"fmt"
	"strconv"
	"unicode"
)

func countOne(runeS []rune) int {
	count := 1
	for i := 1; i < len(runeS); i++ {
		if runeS[i] == runeS[0] {
			count++
			continue
		} else {
			break
		}
	}
	return count
}

func runesToDigits(runeS []rune) (int, int) {
	i := 0
	for unicode.IsDigit(runeS[i]) {
		i++
	}
	s := string(runeS[:i])
	res, err := strconv.Atoi(s)
	if err != nil {
		fmt.Println(err)
	}
	return res, i
}

// RunLengthEncode implements run-length encoding.
func RunLengthEncode(s string) string {
	var b bytes.Buffer
	runeS := []rune(s)
	i := 0
	for i < len(runeS) {
		n := countOne(runeS[i:])
		if n > 1 {
			b.WriteString(strconv.Itoa(n))
		}
		b.WriteRune(runeS[i])
		i += n
	}

	return b.String()
}

// RunLengthDecode implements run-length and decoding.
func RunLengthDecode(s string) string {
	var b bytes.Buffer
	runeS := []rune(s)
	i := 0
	for i < len(runeS) {
		if unicode.IsDigit(runeS[i]) {
			n, x := runesToDigits(runeS[i:])
			for j := 0; j < n; j++ {
				b.WriteRune(runeS[i+x])
			}
			i += x + 1
		} else {
			b.WriteRune(runeS[i])
			i++
		}
	}

	return b.String()
}
