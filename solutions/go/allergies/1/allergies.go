package allergies

var substances = map[uint]string{
	1:   "eggs",
	2:   "peanuts",
	4:   "shellfish",
	8:   "strawberries",
	16:  "tomatoes",
	32:  "chocolate",
	64:  "pollen",
	128: "cats",
}

func Allergies(score uint) (results []string) {
	for k, v := range substances {
		if k&score == k {
			results = append(results, v)
		}
	}
	return
}

func AllergicTo(score uint, substance string) (a bool) {
	for k, v := range substances {
		if v == substance {
			if k&score == k {
				a = true
			} else {
				a = false
			}
		}
	}
	return
}
