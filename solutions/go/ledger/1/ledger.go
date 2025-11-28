package ledger

import (
	"errors"
	"fmt"
	"sort"
	"strings"
	"time"
)

/*
CHANGELOG
*********
The function call in the if-block on lines 20-24 simply catches invalid currency string.
It can be replaced with string equality checks on currency and locale. If either is invalid,
we enter neither loops and exit on error early.
---------
Instead of copying the entries and then iterating over the copy twice (sorting and formatting),
we cast entries into a different data structure checking for the date validity in the process.
This way we exit before we enter the sorting loop if there is an invalid entry. Another bonus
of saving date as time is that we avoid a lot of string operations while getting an output.
----------
Lines 25-43 sort the entries. The logic is complicated and unreadable. We can implement Sort
for our FormatEntry and make our code more readable and performant.
----------
In lines 45-62 there's some repetition in padding strings to the desired length. The same operation
is performed later in the code. We can make our code DRY and use a function to pad strings.
----------
To further DRY up our code, make it extensible and get rid of "magic strings", we can define structures for locale
strings and formats. This helps us to reuse code in a type-safe manner.
----------
Parallelism ... not always a great idea. The order of execution is not guaranteed in channels, and we may lose the order
that we have achieved with the Sort. We won't use chan and get rid of repeated iterations over the slice of entries.
----------
The function in the go routine in lines 63-212 is too long and doing too many things. Let's split it and delegate string
formatting to our FormatEntry. We are saving the date as Time, and it makes formatting faster and safer. We will also
create a function for formatting the change amounts.
----------
*********
*/

var symbols = map[string]string{
	"EUR": "€",
	"USD": "$",
}

type Entry struct {
	Date        string // "Y-m-d"
	Description string
	Change      int // in cents
}

type FormatEntry struct {
	Date        time.Time
	Description string
	Change      int
}

// New creates a FormatEntry with a ledger entry as input
func New(entry *Entry) (FormatEntry, error) {
	// parse the date string
	parseDate, err := time.Parse("2006-01-02", entry.Date)
	if err != nil {
		return FormatEntry{}, err
	}
	// process the description
	desc := entry.Description
	if len(desc) > 25 {
		desc = desc[:22] + "..."
	} else {
		desc = padString(25, desc, false)
	}
	return FormatEntry{
		Date:        parseDate,
		Description: desc,
		Change:      entry.Change,
	}, nil
}

// String returns a formatted ledger entry
func (e *FormatEntry) String(currency, locale string) string {
	return fmt.Sprintf("%s | %s | %s\n",
		padString(10, e.Date.Format(locales[locale].dateFormat), false),
		e.Description,
		padString(13, formatChange(e.Change, currency, locale), true),
	)
}

type FormatEntrySlice []FormatEntry

func (s FormatEntrySlice) Len() int {
	return len(s)
}

func (s FormatEntrySlice) Swap(i, j int) {
	s[i], s[j] = s[j], s[i]
}

// Less implements the sorting in order date -> description -> change
func (s FormatEntrySlice) Less(i, j int) bool {
	leftEl, rightEl := s[i], s[j]
	switch {
	case leftEl.Date != rightEl.Date:
		return leftEl.Date.Before(rightEl.Date)
	case leftEl.Description != rightEl.Description:
		return leftEl.Description < rightEl.Description
	default:
		return leftEl.Change < rightEl.Change
	}
}

type Locale struct {
	date        string
	description string
	change      string
	currency    CurrencyFormat
	dateFormat  string
}

type CurrencyFormat struct {
	space     string
	thousand  string
	decimal   string
	negBefore string
	negAfter  string
}

var (
	locales = map[string]Locale{
		"en-US": {
			date:        "date",
			description: "Description",
			change:      "Change",
			currency: CurrencyFormat{
				space:     "",
				thousand:  ",",
				decimal:   ".",
				negBefore: "(",
				negAfter:  ")",
			},
			dateFormat: "01/02/2006",
		},
		"nl-NL": {
			date:        "Datum",
			description: "Omschrijving",
			change:      "Verandering",
			currency: CurrencyFormat{
				space:     " ",
				thousand:  ".",
				decimal:   ",",
				negBefore: "",
				negAfter:  "-",
			},
			dateFormat: "02-01-2006",
		},
	}
)

func FormatLedger(currency string, locale string, entries []Entry) (string, error) {
	// Check currency and locale, and exit early if either is invalid.
	if currency != "EUR" && currency != "USD" {
		return "", errors.New("invalid currency")
	}
	if locale != "nl-NL" && locale != "en-US" {
		return "", errors.New("invalid locale")
	}

	// Make a slice of FormatEntry and parse Entries while checking the dates are valid.
	formatEntries := make(FormatEntrySlice, 0, len(entries))
	for _, e := range entries {
		fe, err := New(&e)
		if err != nil {
			return "", err
		}
		formatEntries = append(formatEntries, fe)
	}
	// If no errors, sort the slice
	sort.Sort(formatEntries)

	// Create ledger header based on the locale.
	var s string
	l, _ := locales[locale]
	s = fmt.Sprintf("%s | %s | %s\n",
		padString(10, l.date, false), padString(25, l.description, false), l.change)

	// Append formatted ledger entries.
	for _, fe := range formatEntries {
		s += fe.String(currency, locale)
	}
	return s, nil
}

func padString(length int, s string, start bool) string {
	padSize := length - len([]rune(s))
	padding := strings.Repeat(" ", padSize)
	if start {
		return fmt.Sprintf("%s%s", padding, s)
	}
	return fmt.Sprintf("%s%s", s, padding)
}

func formatChange(value int, currency, locale string) string {
	var result string
	var isNegative bool
	l := locales[locale]

	if value < 0 {
		value = value * -1
		isNegative = true
	}

	result = fmt.Sprintf("%s%02d%s", l.currency.decimal, value%100, result)
	value /= 100

	for value >= 1000 {
		result = fmt.Sprintf("%s%03d%s", l.currency.thousand, value%1000, result)
		value /= 1000
	}

	result = fmt.Sprintf("%s%s%d%s", symbols[currency], l.currency.space, value, result)

	if isNegative {
		return fmt.Sprintf("%s%s%s", l.currency.negBefore, result, l.currency.negAfter)
	}

	return result + " "
}
