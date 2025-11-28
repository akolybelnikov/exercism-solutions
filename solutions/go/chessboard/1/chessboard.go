package chessboard


// Declare a type named File which stores if a square is occupied by a piece - this will be a slice of bools
type File []bool
// Declare a type named Chessboard which contains a map of eight Files, accessed with keys from "A" to "H"
type Chessboard map[string]File
// CountInFile returns how many squares are occupied in the chessboard,
// within the given file.
func CountInFile(cb Chessboard, file string) int {
	var res int
    for _, f := range cb[file] {
        if f {
            res++
        }
    }

    return res
}

// CountInRank returns how many squares are occupied in the chessboard,
// within the given rank.
func CountInRank(cb Chessboard, rank int) int {
	var res int
    if rank > 0 && rank < 9 {
        for _, f := range cb {
            if f[rank-1] {
                res++
            }
        }
    }

    return res
}

// CountAll should count how many squares are present in the chessboard.
func CountAll(cb Chessboard) int {
	var res int
    for _, f := range cb {
        res += len(f)
    }

    return res
}

// CountOccupied returns how many squares are occupied in the chessboard.
func CountOccupied(cb Chessboard) int {
    var res int
	for _, f := range cb {
        for _, r := range f {
            if r {
                res++
            }
        }
    }

    return res
}
