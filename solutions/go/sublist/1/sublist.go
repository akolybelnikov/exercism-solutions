package sublist

func Sublist(l1, l2 []int) Relation {
	switch {
	case len(l1) == len(l2):
		return withLenEqual(l1, l2)
	case len(l1) == 0 && len(l2) > 0:
		return RelationSublist
	case len(l1) > 0 && len(l2) == 0:
		return RelationSuperlist
	default:
		return withLenUnequal(l1, l2)
	}
}

func withLenEqual(l1, l2 []int) Relation {
	if len(l1) == 0 && len(l2) == 0 {
		return RelationEqual
	}

	for i := range l1 {
		if l1[i] != l2[i] {
			return RelationUnequal
		}
	}

	return RelationEqual
}

func withLenUnequal(l1, l2 []int) Relation {
	switch {
	case isSuperlist(l1, l2):
		return RelationSuperlist
	case isSuperlist(l2, l1):
		return RelationSublist
	default:
		return RelationUnequal
	}
}

func isSuperlist(l1, l2 []int) bool {
	if len(l1) < len(l2) {
		return false
	}

	for i := 0; i < len(l1); i++ {
		if len(l1)-i < len(l2) {
			return false
		}

		if l1[i] == l2[0] {
			var eq = true
			for j := range l2 {
				if l1[i+j] != l2[j] {
					eq = false
					break
				}
			}
			if eq {
				return true
			}
		}

	}

	return false
}
