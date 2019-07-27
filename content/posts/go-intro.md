---
title: "Introduction to Go"
date: 2019-07-22
draft: false
categories: [prog]
tags: [go]
---

# Types

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

See also [Basic types](https://tour.golang.org/basics/11), [Zero values](https://tour.golang.org/basics/12) and [Type conversions](https://tour.golang.org/basics/13).

## Numbers

Computers use base-2 binary system to store and work with the numbers. So
computers count like this: 0, 1, 10, 11, 100, 110, 111, ...

Integer types

* [u]int{8, 16, 32, 64}
* machine dependent: uint, **int**, uintptr
* byte - alias for uint8
* rune - alias for int32 (represents a Unicode code point)

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

See also [Type inference](https://tour.golang.org/basics/14).

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

// loop over array/slice
for i, value := range x {
    ...
}
```

## The if and switch Statements

If the if statement becomes too verbose use the switch statement.

```go
for i := 1; i <= 10; i++ {
    switch i { // expression after switch can be omitted
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

# More built-in types

## Arrays

Array is a numbered sequence of elements of a single type with a *fixed length*.

```go
var a1 [3]int // array of three integers
a1[0] = 10
a1[1] = 20
a1[3] = 30

// shorter syntax for creating arrays
a2 := [3]int{ 10, 20, 30, }
```

Now, you rarely see arrays used directly in Go code :-).

## Slices

Slice is a segment of an array. Like arrays, they are indexable and have a length. Unlike arrays, the *length is allowed to change*.

```go
    var s1 []float64            // []
    s2 := make([]float64, 3)    // [0 0 0]

    // define length (3) and capacity (5)
    s3 := make([]float64, 3, 5) // [0 0 0]

    // create slice from array
    a := [5]float64{1,2,3,4,5}
    s4 := a[1:3]                // [2 3]
    s5 := a[:]                  // [1 2 3 4 5]
```

Slices are always associated with some array. The are like
[references](https://tour.golang.org/moretypes/8) to arrays.

See also [Slice literals](https://tour.golang.org/moretypes/9).

### `append` operator

```go
s1 := []int{1,2,3}
s2 := append(s1, 4, 5)
```

* adds elements onto the end of a slice and creates a *new slice*
* if there's sufficient capacity, the backing array's length is incremented
* if not, a new backing array is created and all the existing elements are copied over

See also [Appending to a slice](https://tour.golang.org/moretypes/15).

### `copy` operator

```go
s1 := []int{1,2,3}
s2 := make([]int, 2)
// func copy(dst, src []Type) int
copy(s2, s1)
// s1: [1,2,3], s2: [1,2]
```

* all of the entries in `src` are copied into `dst` overwriting whatever is there
* if lengths are not the same, the smaller of the two will be used

See also [copy](https://golang.org/pkg/builtin/#copy).

## Maps

* unordered collection of key-value pairs (also called associative arrays, hash tables, or dictionaries)

```go
// x is a map of strings into ints

// WRONG: this will yield a run time error
var x map[string]int
x["key"] = 10 // panic: assignment to entry in nil map

// maps have to be initialized before they can be used
var x = make(map[string]int)
x["key"] = 10

// delete an item from a map
delete(x, "key")
```

* maps are often used as lookup tables (dictionaries)

```go
elements := map[string]string{
    "H":  "Hydrogen",
    "He": "Helium",
    "Li": "Lithium",
}

if name, ok := elements["He"]; ok {
    fmt.Printf("He is %s\n", name)
}
```

# Functions

A function (aka a procedure, or a subroutine) is an independent section of code that maps zero or more input parameters to zero or more output parameters:

```
Inputs -> [ func f(i, j int) int {} ] -> Outputs
```

* collectively, the parameters (i, j) and the return type (int) are called function's signature

Functions form call stacks:

```go
func main() {
    fmt.Println(f1())
}

func f1() int {
    return f2()
}

func f2() int {
    return 1
}
```

```
                            +----+
                            | f2 | return
                            +----+
              +----+        +----+        +----+
              | f1 |   f2   | f1 |        | f1 | return
              +----+        +----+        +----+
+----+        +----+        +----+        +----+        +----+
|main|   f1   |main|        |main|        |main|        |main|
+----+        +----+        +----+        +----+        +----+
```

* each time we call a function, we push it onto the call stack
* each time we return from a function, we pop it off of the stack

Return types can have names:

```go
func f2() (r int) {
    r := 1
    return
}
```

Multiple values can be returned:

```go
func f() (int, int) {
    return 4, 2
}

func main() {
    x, y := f()
}
```

Multiple values are often used to return an error value along with the result (`x, err := f()`), or a boolean to indicate success (`x, ok := f()`).

## Variadic functions

There is a special form available for the last parameter:

```go
// sump up zero or more integers
func sum(args ...int) int {     // prefix ellipsis
    total := 0
    for _, v := range args {
        total += v
    }
    return total
}

func main() {
    fmt.Println(sum())
    fmt.Println(sum(1, 2))

    xs := []int{1,2,3}
    fmt.Println(sum(xs...))     // suffix ellipsis
}
```

fmt.Println can take any number of values (...) of any type (interface{}):

```go
func Println(a ...interface{}) (n int, err error)
```

# Sources

* Caleb Doxsey: Introducing Go (O'Reilly, 2016)
* [A Tour of Go](https://tour.golang.org)
