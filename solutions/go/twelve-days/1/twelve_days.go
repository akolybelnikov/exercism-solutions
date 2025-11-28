package twelve

import (
	"fmt"
	"strings"
)

var days = []string{
	"first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth",
}
var presents = []string{
	"a Partridge in a Pear Tree.",
	"two Turtle Doves",
	"three French Hens",
	"four Calling Birds",
	"five Gold Rings",
	"six Geese-a-Laying",
	"seven Swans-a-Swimming",
	"eight Maids-a-Milking",
	"nine Ladies Dancing",
	"ten Lords-a-Leaping",
	"eleven Pipers Piping",
	"twelve Drummers Drumming",
}

func Verse(i int) string {
	var b strings.Builder
	b.WriteString(fmt.Sprintf("On the %s day of Christmas my true love gave to me: ", days[i-1]))
	for j := i; j > 0; j-- {
		if j != i {
			b.WriteString(", ")
		}
		if j == 1 && i != 1 {
			b.WriteString("and ")
		}
		b.WriteString(presents[j-1])
	}

	return b.String()
}

func Song() string {
	var b strings.Builder
	for i := 1; i <= 12; i++ {
		b.WriteString(Verse(i))
		b.WriteRune('\n')
	}
	return strings.TrimSuffix(b.String(), "\n")
}
