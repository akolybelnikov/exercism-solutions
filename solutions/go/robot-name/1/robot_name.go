// Package robotname manages robot factory settings.
package robotname

import (
	"errors"
	"fmt"
	"math/rand"
)

type Robot struct {
	name string
}

const maxNames = 26 * 26 * 10 * 10 * 10

var availableNames = make([]string, 0, maxNames)
var initialized = false

// Init creates and stores all possible combinations of 2 letters and 3 digits
func Init() {
	var letters []string
	i := 65
	for ; i <= 90; i++ {
		j := 65
		for ; j <= 90; j++ {
			letters = append(letters, string(rune(i))+string(rune(j)))
		}
	}

	var digits []string
	k := 0
	for ; k <= 9; k++ {
		l := 0
		for ; l <= 9; l++ {
			m := 0
			for ; m <= 9; m++ {
				digits = append(digits, fmt.Sprintf("%d%d%d", k, l, m))
			}
		}
	}

	for _, lttrs := range letters {
		for _, dgds := range digits {
			availableNames = append(availableNames, lttrs+dgds)
		}
	}
}

func (r *Robot) Name() (string, error) {
	if !initialized {
		Init()
		initialized = true
	}

	if r.name != "" {
		return r.name, nil
	}

	if len(availableNames) == 0 {
		return "", errors.New("no available names")
	}

	idx := rand.Intn(len(availableNames))
	r.name = availableNames[idx]

	availableNames[idx] = availableNames[len(availableNames)-1]
	availableNames[len(availableNames)-1] = ""
	availableNames = availableNames[:len(availableNames)-1]

	return r.name, nil
}

func (r *Robot) Reset() {
	r.name = ""
}
