package phonenumber

import (
	"errors"
	"fmt"
    "strings"
    "unicode"
)

var ErrInvalidCode = errors.New("invalid country/area/exchange code")
var ErrInvalidNumber = errors.New("not enough/too many digits")

func Number(phoneNumber string) (string, error) {
    num, err := parsePhoneNumber(phoneNumber)
    if err != nil {
        return "", err
    }

    return num, nil
}

func AreaCode(phoneNumber string) (string, error) {
	num, err := parsePhoneNumber(phoneNumber)
    if err != nil {
        return "", err
    }

    return num[:3], nil
}

func Format(phoneNumber string) (string, error) {
	num, err := parsePhoneNumber(phoneNumber)
    if err != nil {
        return "", err
    }

    return fmt.Sprintf("(%s) %s-%s", num[:3], num[3:6], num[6:]), nil
}

func parsePhoneNumber(phoneNumber string) (string, error) {
	var b strings.Builder

    for _, c := range phoneNumber {
        if c == '1' && b.Len() == 0 {
            continue
        }
        if (c == '0' || c == '1') && (b.Len() == 0 || b.Len() == 3) {
            return "", ErrInvalidCode
        }
        if unicode.IsDigit(c) {
			b.WriteRune(c)
		}
    }

    if b.Len() != 10 {
        return "", ErrInvalidNumber
    }

    return b.String(), nil
}
