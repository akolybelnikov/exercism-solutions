package cipher

import (
	"strings"
)

type shift struct {
	distance int
}

type vigenere struct {
	key string
}

func NewCaesar() Cipher {
	return shift{3}
}

func NewShift(distance int) Cipher {
	if distance < -25 || distance > 25 || distance == 0 {
		return nil
	}

	if distance < 0 {
		distance = 26 + distance
	}

	return shift{distance}
}

func (c shift) Encode(input string) string {
	input = strings.ToLower(input)
	b := strings.Builder{}
	for _, r := range input {
		if r >= 'a' && r <= 'z' {
			b.WriteRune(rune((int(r)-'a'+c.distance)%26 + 'a'))
		}
	}

	return b.String()
}

func (c shift) Decode(input string) string {
	input = strings.ToLower(input)
	b := strings.Builder{}
	for _, r := range input {
		if r >= 'a' && r <= 'z' {
			d := int(r) - 'a' - c.distance
			if d < 0 {
				d += 26
			}
			b.WriteRune(rune(d%26 + 'a'))
		}
	}

	return b.String()
}

func NewVigenere(key string) Cipher {
	var count int
	for _, c := range key {
		if c < 'a' || c > 'z' {
			return nil
		}
		if c == 'a' {
			count++
		}
	}

	if count == len(key) {
		return nil
	}

	return vigenere{key}
}

func (v vigenere) Encode(input string) string {
	input = strings.ToLower(input)
	b := strings.Builder{}
	var idx int

	for _, r := range input {
		if r >= 'a' && r <= 'z' {
			b.WriteRune(rune((int(r)-'a'+int(v.key[idx%len(v.key)]-'a'))%26 + 'a'))
			idx++
		}
	}

	return b.String()
}

func (v vigenere) Decode(input string) string {
	input = strings.ToLower(input)
	b := strings.Builder{}
	var idx int

	for _, r := range input {
		if r >= 'a' && r <= 'z' {
			d := int(r) - 'a' - int(v.key[idx%len(v.key)]-'a')
			if d < 0 {
				d += 26
			}
			b.WriteRune(rune(d%26 + 'a'))
			idx++
		}
	}

	return b.String()
}
