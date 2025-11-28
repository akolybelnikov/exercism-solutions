package booking

import (
	"fmt"
	"time"
)

// Schedule returns a time.Time from a string containing a date.
func Schedule(date string) time.Time {
	pattern := "1/2/2006 15:04:05"
	t1, err := time.Parse(pattern, date)
	if err != nil {
		panic(err)
	}
	return t1
}

// HasPassed returns whether a date has passed.
func HasPassed(date string) bool {
	pattern := "January 2, 2006 15:04:05"
	t1, err := time.Parse(pattern, date)
	if err != nil {
		panic(err)
	}
	return t1.Before(time.Now())
}

// IsAfternoonAppointment returns whether a time is in the afternoon.
func IsAfternoonAppointment(date string) bool {
	pattern := "Monday, January 2, 2006 15:04:05"
	t1, err := time.Parse(pattern, date)
	if err != nil {
		panic(err)
	}
	return t1.Hour() >= 12 && t1.Hour() <= 18
}

// Description returns a formatted string of the appointment time.
func Description(date string) string {
	pattern := "1/2/2006 15:04:05"
	t1, err := time.Parse(pattern, date)
	if err != nil {
		panic(err)
	}
	return fmt.Sprintf("You have an appointment on %s, %s %d, %d, at %d:%d.", t1.Weekday(), t1.Month(), t1.Day(), t1.Year(), t1.Hour(), t1.Minute())
}

// AnniversaryDate returns a Time with this year's anniversary.
func AnniversaryDate() time.Time {
	return time.Date(time.Now().Year(), time.September, 15, 0, 0, 0, 0, time.UTC)
}
