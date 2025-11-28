package prime

func Factors(n int64) []int64 {
	var factors []int64

	// Divide by 2 until n is odd
	for n%2 == 0 {
		factors = append(factors, 2)
		n = n / 2
	}
	// n must be odd at this point. So we can skip one element (Note i = i +2)
	for i := int64(3); i*i <= n; i = i + 2 {
		// While i divides n, append i and divide n
		for n%i == 0 {
			factors = append(factors, i)
			n = n / i
		}
	}
	// This condition is to handle the case when n is a prime number greater than 2
	if n > 2 {
		factors = append(factors, n)
	}

	return factors
}
