package armstrong

func IsNumber(n int) bool {
	if n == 0 {
		return true
	}

	m := n

	digits := make([]int, 0)
	for m != 0 {
		digits = append(digits, m%10)
		m /= 10
	}

	result := 0
	for _, digit := range digits {
		d := digit
		for i := 1; i < len(digits); i++ {
			d *= digit
		}
		result += d
	}

	return result == n
}
