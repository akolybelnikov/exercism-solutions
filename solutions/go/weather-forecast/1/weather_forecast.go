// Package weather provides the weather forecast for the current // location.
package weather

// CurrentCondition describes the current weather condition.
var CurrentCondition string
// CurrentLocation indicates the current geo location.
var CurrentLocation string

// Forecast constructs the final output of the weather forecast for the current location.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
