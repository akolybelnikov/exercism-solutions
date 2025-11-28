package secret

import (
	"fmt"
)

var secrets = map[int]string{
	0: "jump",
	1: "close your eyes",
	2: "double blink",
	3: "wink",
}

func Handshake(code uint) []string {
	seq := make([]string, 0, 4)
	// 16 is 10000 in Binary
	a := code >= 16
	code = code % 16
	b := fmt.Sprintf("%04b", code)
	for i, t := range b {
		// ASCII character '1' is 49 in Decimal
		if t == 49 {
			if a {
				seq = append(seq, secrets[i])
			} else {
				seq = append([]string{secrets[i]}, seq...)
			}
		}
	}
	return seq
}
