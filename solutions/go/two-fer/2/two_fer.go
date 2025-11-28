// Package twofer provides a solution to the Exercism task Two Fer
package twofer

import "fmt"

// ShareWith returns a string with the message, given a name.
// However, if the name is missing, it returns the string 'you'
func ShareWith(name string) string {
	if name == "" {
		name = "you"
	}
	return fmt.Sprintf("One for %s, one for me.", name)
}
