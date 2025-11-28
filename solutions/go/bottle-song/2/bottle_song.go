package bottlesong

import (
	"fmt"
)

var humanizer = map[int]string{
	1:  "one",
	2:  "two",
	3:  "three",
	4:  "four",
	5:  "five",
	6:  "six",
	7:  "seven",
	8:  "eight",
	9:  "nine",
	10: "ten",
}

func Recite(startBottles, takeDown int) []string {
	var res []string
	for i := 0; i < takeDown; i++ {
		if startBottles == 1 {
			res = append(res,
				"One green bottle hanging on the wall,",
				"One green bottle hanging on the wall,",
				"And if one green bottle should accidentally fall,",
				"There'll be no green bottles hanging on the wall.",
			)
			break
		}
		if startBottles == 2 {
			res = append(res,
				"Two green bottles hanging on the wall,",
				"Two green bottles hanging on the wall,",
				"And if one green bottle should accidentally fall,",
				"There'll be one green bottle hanging on the wall.",
			)
			if i < takeDown-1 {
				res = append(res, "")
			}
			startBottles--
			continue
		}
		humanized := humanizer[startBottles]
		simpleFold := rune(humanized[0]) - 32
		humanized = string(simpleFold) + humanized[1:]

		next := humanizer[startBottles-1]

		res = append(res,
			fmt.Sprintf("%s green bottles hanging on the wall,", humanized),
			fmt.Sprintf("%s green bottles hanging on the wall,", humanized),
			"And if one green bottle should accidentally fall,",
			fmt.Sprintf("There'll be %s green bottles hanging on the wall.", next),
		)
		if i < takeDown-1 {
			res = append(res, "")
		}
		startBottles--
	}

	return res
}
