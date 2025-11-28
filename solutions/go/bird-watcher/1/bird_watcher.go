package birdwatcher

// TotalBirdCount return the total bird count by summing
// the individual day's counts.
func TotalBirdCount(birdsPerDay []int) int {
	total := 0
	for _, count := range birdsPerDay {
		total += count
	}
	return total
}

// BirdsInWeek returns the total bird count by summing
// only the items belonging to the given week.
func BirdsInWeek(birdsPerDay []int, week int) int {
	total := 0
	for i := 0; i < len(birdsPerDay); i++ {
		if i%7 == week {
			total += birdsPerDay[i]
		}
	}
	return total
}

// FixBirdCountLog returns the bird counts after correcting
// the bird counts for alternate days.
func FixBirdCountLog(birdsPerDay []int) []int {
	fixed := make([]int, len(birdsPerDay))
	for i := 0; i < len(birdsPerDay); i++ {
		if i%2 == 0 {
			fixed[i] = birdsPerDay[i]
		} else {
			fixed[i] = birdsPerDay[i-1]
		}
	}
	return fixed
}
