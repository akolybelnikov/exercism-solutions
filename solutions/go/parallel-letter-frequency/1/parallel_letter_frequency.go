// Package letter implements a solution to the problem on Exercism
package letter

import (
	"sync"
)

// FreqMap records the frequency of each rune in a given text.
type FreqMap map[rune]int

type safeFrequency struct {
	mu sync.Mutex
	fm FreqMap
}

// Frequency counts the frequency of each rune in a given text and returns this
// data as a FreqMap.
func Frequency(s string) FreqMap {
	m := FreqMap{}
	for _, r := range s {
		m[r]++
	}
	return m
}

// ConcurrentFrequency counts the frequency of each rune in each text in a list of texts concurrently
// and returns this data as a FreqMap.
func ConcurrentFrequency(texts []string) FreqMap {
	sf := safeFrequency{fm: make(FreqMap)}
	for _, t := range texts {
		sf.concFrequency(t)
	}
	return sf.fm
}

func (f *safeFrequency) concFrequency(s string) {
	for _, r := range s {
		go f.updateFrequency(r)
	}

}

func (f *safeFrequency) updateFrequency(r rune)  {
	f.mu.Lock()
	f.fm[r]++
	f.mu.Unlock()
}
