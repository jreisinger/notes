---
title: "Introduction to Go"
date: 2019-07-22
draft: false
categories: [prog]
tags: [go]
---

# Data Types

Go is statically typed - variables always have specific type and type cannot
change during the program run time.

Types help us reason about what our program is doing and help us catch many
errors.

Types are similar to sets in mathematics. They classify data into groups and
determine:

* characteristics of data (e.g. all strings have length)
* operations that can be performed on data (e.g. `len("a string")`)
* data size (e.g. `int8`)
* how data is stored in memory

See also A Tour of Go: [Basic types](https://tour.golang.org/basics/11).

## Numbers

Computers use base-2 binary system to store and work with the numbers. So
computers count like this: 0, 1, 10, 11, 100, 110, 111, ...

Integer types

* [u]int{8, 16, 32, 64}
* machine dependent: uint, **int**, uintptr
* byte - alias for uint8
* rune - alias for int32

Floating-point types

* float32 (single precision), **float64** (double precision)
* complex64, complex128
* contain decimal component (i.e. real numbers)
* their actual representation on computer is quite complicated but not needed to
    know to use them
* inexact (1.01 – 0.99 using floating-point arithmetic results in
    0.020000000000000018)
* have certain size (32 or 64 bit)
* NaN - not a number (for things like 0/0), +∞, -∞

```go
// we use .0 to tell Go it's a floating-point number
fmt.Prinln("1 + 1 =", 1.0 + 1.0)
```

## Strings

* sequences of characters used to represent text
* made up of individual bytes, usually (but not always) one for each character

String literals are created with:

* double quotes (`"Hello world"`) - cannot contain newlines and allow escape
    sequeences (e.g. `\t`, `\n`)
* backticks (`` `Hello world` ``)

Common operations on strings:

* find length: `len("Hello world")`
* access a character: `"Hello world[1]` -> 101 instead of e because the
    character is represented by a byte (i.e. and integer)
* concatenate strings: `"Hello " + "world"` -> Go figures out what to do based
    on the type of the arguments

## Booleans

* special 1-bit integer type used to represent true and false (or on and off)
* logical operators: `&&`, `||`, `!`
* truth tables define how these operators work

# Variables

* variable - storage location, with a specific type and an associated name
* [scope](https://golang.org/ref/spec#Declarations_and_scope) - the range of places where you are allowed to use a variable ("Go is lexically scoped using block.")
* constants - variables whose values cannot be changed during program run time

```go
package main

import (
    "fmt"
)

func main() {
    fmt.Print("Enter distance in feet: ")
    var feet float64 // one way to define var
    fmt.Scanf("%f", &feet)
    meters := feet * 0.3048 // another way to define var
    fmt.Printf("%.2f ft = %.2f m\n", feet, meters)
}
```

# Control Structures

## The for Statement

Other programming languages have various types of loops (while, until, foreach,
...). Go only has for loop that can be used in various ways, e.g.:

```go
// traditional c-style
for i := 1; i <= 10; i++ {
    fmt.Println(i)
}

i := 1              // declaration + initialization
for i <= 10 {       // condition
    fmt.Println(i)
    i++             // increment
}
```

## The if and switch Statements

If the if statement becomes too verbose use the switch statement.

```go
for i := 1; i <= 10; i++ {
    switch i {
    case 1: fmt.Println("one")
    case 5: fmt.Println("five")
    case 6: fmt.Println("six")
    case 10: fmt.Println("ten")
    default: fmt.Println(i) // similar to else
    }
}
```

The value of the expressions (in this example `i`) is compared to the
expression following each `case` keyword. If they are equivalent the statements
following `:` are executed. The first one to succeed is chosen.

```go
for i := 1; i <= 30; i++ {
    switch {
    case i%3 == 0 && i%5 == 0:
        fmt.Println("FizzBuzz")
    case i%3 == 0:
        fmt.Println("Fizz")
    case i%5 == 0:
        fmt.Println("Buzz")
    default:
        fmt.Println(i)
    }
}
```

# Sources

* Caleb Doxsey: Introducing Go (O'Reilly, 2016)
