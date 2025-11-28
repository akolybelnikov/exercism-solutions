package minesweeper

import "strings"

// Annotate returns an annotated board
func Annotate(board []string) []string {
	if len(board) == 0 || len(board[0]) == 0 {
		return board
	}
	// use strings writer package to produce the final result
	// this is more efficient than using string concatenation
	// because strings are immutable in Go
	// and every time we concatenate a string, a new string is created
	// and the old one is garbage collected
	// this is not efficient for large strings
	// so we use strings.Builder to build the final result
	var result []string
	for i := 0; i < len(board); i++ {
		var row strings.Builder
		for j := 0; j < len(board[i]); j++ {
			if board[i][j] == '*' {
				row.WriteByte('*')
			} else {
				count := countMines(board, i, j)
				if count == 0 {
					row.WriteByte(' ')
				} else {
					row.WriteByte(byte(count) + '0')
				}
			}
		}
		result = append(result, row.String())
	}

	return result
}

func countMines(board []string, i, j int) int {
	count := 0
	for x := -1; x < 2; x++ {
		for y := -1; y < 2; y++ {
			if x == 0 && y == 0 {
				continue
			}
			if i+x < 0 || i+x >= len(board) || j+y < 0 || j+y >= len(board[i]) {
				continue
			}
			if board[i+x][j+y] == '*' {
				count++
			}
		}
	}
	return count
}
