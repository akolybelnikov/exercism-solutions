package complexnumbers

import "math"

type Number struct {
	a float64
	b float64
}

func (n Number) Real() float64 {
	return n.a
}

func (n Number) Imaginary() float64 {
	return n.b
}

func (n Number) Subtract(n2 Number) Number {
	return Number{n.a - n2.a, n.b - n2.b}
}

func (n Number) Add(n2 Number) Number {
	return Number{n.a + n2.a, n.b + n2.b}
}

func (n Number) Multiply(n2 Number) Number {
	return Number{n.a*n2.a - n.b*n2.b, n.a*n2.b + n.b*n2.a}
}

func (n Number) Times(factor float64) Number {
	return Number{n.a * factor, n.b * factor}
}

func (n Number) Divide(n2 Number) Number {
	denominator := n2.a*n2.a + n2.b*n2.b
	return Number{(n.a*n2.a + n.b*n2.b) / denominator, (n.b*n2.a - n.a*n2.b) / denominator}
}

func (n Number) Conjugate() Number {
	return Number{n.a, -n.b}
}

func (n Number) Exp() Number {
	exponential := math.Exp(n.a)
	return Number{exponential * math.Cos(n.b), exponential * math.Sin(n.b)}
}

func (n Number) Abs() float64 {
	return math.Sqrt(n.a*n.a + n.b*n.b)
}
