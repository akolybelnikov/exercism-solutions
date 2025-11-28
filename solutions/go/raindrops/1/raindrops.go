// Package raindrops provides a solution to the problem on Go track of Exercism
package raindrops

import "fmt"

// Convert returns a string that contains raindrop sounds corresponding to factors 3, 5 and 7
func Convert(given int) (result string) {
	result = ""
	if given%3 != 0 && given%5 != 0 && given%7 != 0 {
		return fmt.Sprint(given)
	}
	if given%3 == 0 {
		result = result + "Pling"
	}
	if given%5 == 0 {
		result = result + "Plang"
	}
	if given%7 == 0 {
		result = result + "Plong"
	}
	return
}
