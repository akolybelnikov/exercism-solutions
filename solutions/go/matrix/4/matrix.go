package matrix

import (
	"errors"
	"strconv"
	"strings"
)

var ErrInvalid error = errors.New("invalid matrix")

// Matrix holds the rows and the columns of a matrix.
type Matrix [][]int

func New(s string) (Matrix, error) {
	rows := strings.Split(s, "\n")
	matrix := make(Matrix, len(rows))
	var rowLen int
	for i, row := range rows {
		row = strings.TrimSpace(row)
		cols := strings.Split(row, " ")
		if i == 0 {
			rowLen = len(cols)
		}
		if len(cols) != rowLen {
			return Matrix{}, ErrInvalid
		}
		matrix[i] = make([]int, len(cols))
		for j, col := range cols {
			colInt, err := strconv.Atoi(col)
			if err != nil {
				return Matrix{}, err
			}
			matrix[i][j] = colInt
		}
	}
	return matrix, nil
}

// Cols and Rows must return the results without affecting the matrix.
func (m Matrix) Cols() [][]int {
	cols := make([][]int, len(m[0]))
	for i := range cols {
		cols[i] = make([]int, len(m))
		for j := range cols[i] {
			cols[i][j] = m[j][i]
		}
	}

	return cols
}

func (m Matrix) Rows() [][]int {
	rows := make([][]int, len(m))
	for i := range rows {
		rows[i] = make([]int, len(m[i]))
		copy(rows[i], m[i])
	}
	return rows
}

func (m Matrix) Set(row, col, val int) bool {
	if row < 0 || row >= len(m) || col < 0 || col >= len(m[0]) {
		return false
	}
	m[row][col] = val
	return true
}
