package thefarm

import (
    "errors"
        "fmt"
    )

var SillyNephewError error

// DivideFood computes the fodder amount per cow for the given cows.
func DivideFood(weightFodder WeightFodder, cows int) (float64, error) {
	fodder, err := weightFodder.FodderAmount()
    if err != nil {
        if err == ErrScaleMalfunction {
            fodder *= 2
        } else {
        	return 0.0, err
        }
    }
    
    if (err == nil || err == ErrScaleMalfunction) && fodder < 0 {
        return float64(0), errors.New("negative fodder")
    }

    if cows == 0 {
        return float64(0), errors.New("division by zero")
    }

    if cows < 0 {
        SillyNephewError = errors.New(fmt.Sprintf("silly nephew, there cannot be %d cows", cows))
        return float64(0), SillyNephewError
    }

    return fodder/float64(cows), nil
}
