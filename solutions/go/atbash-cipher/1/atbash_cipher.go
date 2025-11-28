package atbash

import "strings"

var cipher = map[rune]rune{
	'a': 'z',
	'b': 'y',
	'c': 'x',
	'd': 'w',
	'e': 'v',
	'f': 'u',
	'g': 't',
	'h': 's',
	'i': 'r',
	'j': 'q',
	'k': 'p',
	'l': 'o',
	'm': 'n',
	'n': 'm',
	'o': 'l',
	'p': 'k',
	'q': 'j',
	'r': 'i',
	's': 'h',
	't': 'g',
	'u': 'f',
	'v': 'e',
	'w': 'd',
	'x': 'c',
	'y': 'b',
	'z': 'a',
}

func Atbash(s string) string {
	runes := []rune(strings.ToLower(s))
	b := strings.Builder{}
	cur := 0
	for i, r := range runes {
		if cur == 5 && i != len(runes)-1 {
			b.WriteRune(' ')
			cur = 0
		}
		if c, found := cipher[r]; found {
			b.WriteRune(c)
			cur++
		}
		if r >= '0' && r <= '9' {
			b.WriteRune(r)
			cur++
		}
	}

	return b.String()
}
