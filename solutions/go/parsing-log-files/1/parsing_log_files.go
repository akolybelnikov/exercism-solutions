package parsinglogfiles

import (
    "fmt"
    "regexp"
)

func IsValidLine(text string) bool {
    re := regexp.MustCompile(`\[TRC\]|\[DBG\]|\[INF\]|\[WRN\\]|\[ERR\]|\[FTL\]`)
    loc := re.FindStringIndex(text)

    return loc != nil && loc[0] == 0
}

func SplitLogLine(text string) []string {
	re := regexp.MustCompile(`<(~|-|\*|=?)+>`)
    
    return re.Split(text, -1)
}

func CountQuotedPasswords(lines []string) int {
    var res int
	re := regexp.MustCompile(`"[^"]*[Pp][Aa][Ss][Ss][Ww][Oo][Rr][Dd][^"]*"`)
	for _, line := range lines {
		b := re.MatchString(line)
		if b {
			res++
		}
	}

	return res
}

func RemoveEndOfLineText(text string) string {
	re := regexp.MustCompile(`end-of-line\S*`)

    return re.ReplaceAllString(text, "")
}

func TagWithUserName(lines []string) []string {
    var res []string
	re := regexp.MustCompile(`User\s+`)
	re2 := regexp.MustCompile(`\S*`)
	for _, line := range lines {
		si := re.FindStringIndex(line)
		if si != nil {
			s := re2.FindString(line[si[1]:])
			pfx := fmt.Sprintf("[USR] %s ", s)
			bln := append([]byte(pfx), []byte(line)...)
			res = append(res, string(bln))
		} else {
            res = append(res, line)
        }
	}

    return res
}
