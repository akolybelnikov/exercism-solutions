// Package grains implements a solution to the problem on the Go track of Exercism
package grains

import "errors"

// Square calculates how many grains were on a given square.
func Square(input int) (uint64, error) {
	if input <= 0 || input > 64 {
		return 0, errors.New("invalid input")
	}
	var num uint64 = 1
	for i := 2; i <= input; i++ {
		num *= 2
	}
	return num, nil
}

// Total calculate the number of grains of wheat on a chessboard.
func Total() uint64 {
	var num uint64 = 1
	var sum uint64 = 1
	for i := 2; i <= 64; i++ {
		num *= 2
		sum += num
	}
	return sum
}
