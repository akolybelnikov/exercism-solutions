// Package listops provides a solution to the problem on Go track of exercism
package listops

// IntList is an integer slice type that implements the list ops
type IntList []int

// binFunc is a binary function used in ops with two integers, returns an integer
type binFunc func(x, y int) int

// predFunc accepts and integer argument and returns a boolean value
type predFunc func(n int) bool

// unaryFunc is used in ops with one integer, returns an integer
type unaryFunc func(x int) int

// Foldr reduces each item into the accumulator from the right using the binFunc
func (l IntList) Foldr(f binFunc, acc int) int {
	if len(l) == 0 {
		return acc
	}
	for i := len(l) - 1; i >= 0; i-- {
		acc = f(l[i], acc)
	}
	return acc
}

// Foldl reduces each item into the accumulator from the left using the binFunc
func (l IntList) Foldl(f binFunc, acc int) int {
	for i := 1; i < len(l); i++ {
		acc = f(acc, l[i])
	}
	return acc
}

// Filter returns the list of all items for which predicate(item) is True
func (l IntList) Filter(f predFunc) []int {
	if len(l) == 0 {
		return l
	}
	n := l
	for i := 0; i < len(n); i++ {
		if !f(n[i]) {
			n = append(n[:i], n[i+1:]...)
		}
	}
	return n
}

// Length returns the total number of items within the list
func (l IntList) Length() int {
	return len(l)
}

// Map returns the list of the results of applying function(item) on all items
func (l IntList) Map(f unaryFunc) []int {
	var n []int
	for _, i := range l {
		n = append(n, f(i))
	}
	return n
}

// Reverse returns a list with all the original items, but in reversed order
func (l IntList) Reverse() []int {
	if len(l) == 0 {
		return l
	}
	var n []int
	for i := len(l) - 1; i >= 0; i-- {
		n = append([]int{l[i]}, n...)
	}
	return n
}

// Append adds all items in the second list to the end of the first list
func (l IntList) Append(s []int) []int {
	var res = append(l, []int{}...)
	for _, i := range s {
		res = append(res, i)
	}

	return res
}

// Concat combines all items in all given lists into one flattened list
func (l IntList) Concat(args []IntList) []int {
	if len(l) == 0 {
		return l
	}
	n := l
	for _, a := range args {
		n = append(n, a...)
	}
	return n
}
