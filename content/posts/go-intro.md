---
title: "Introduction to Go"
date: 2019-07-22
draft: false
categories: [prog]
tags: [go]
---

# Data types

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
