// Package strand provides a solution for the RNA transcription problem on Go track of Exercism
package strand

import (
	"bytes"
	"errors"
	"strings"
)

var nucleotides = map[string]string{"G": "C", "C": "G", "T": "A", "A": "U"}

// ToRNA returns the RNA complement (per RNA transcription) of a given DNA strand
func ToRNA(dnaStrand string) string {
	var result bytes.Buffer

	if dnaStrand != "" {
		s := strings.Split(dnaStrand, "")
		for _, str := range s {
			pair, err := findPair(str)
			if err != nil {
				return result.String()
			}
			result.WriteString(pair)
		}
	}
	return result.String()
}

func findPair(nucleo string) (string, error) {
	if pair, ok := nucleotides[nucleo]; ok {
		return pair, nil
	}

	return "", errors.New("no pair exists")
}
