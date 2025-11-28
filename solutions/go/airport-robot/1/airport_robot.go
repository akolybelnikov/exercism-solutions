package airportrobot

import "fmt"

type Greeter interface {
    LanguageName() string
    Greet(visitorName string) string
}

func SayHello(visitorName string, g Greeter) string {
    return fmt.Sprintf("I can speak %s: %s", g.LanguageName(), g.Greet(visitorName))
}

type Italian struct {}

func(i Italian) LanguageName() string {
    return "Italian"
}

func(i Italian) Greet(name string) string {
    return fmt.Sprintf("Ciao %s!", name)
}

type Portuguese struct {}

func(p Portuguese) LanguageName() string {
    return "Portuguese"
}

func(p Portuguese) Greet(name string) string {
    return fmt.Sprintf("Olá %s!", name)
}
