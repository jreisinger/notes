---
title: "Go Strings"
date: 2019-10-09
categories: [Prog]
tags: [Go, Strings]
---

https://blog.golang.org/strings

```go
package main

import (
    "fmt"
)

func main() {
    // String is a (read-only) slice of bytes that can hold arbitrary bytes
    // (not just UTF-8 text or any other predefined format). Sample string
    // literal in hex:
    const sample = "\xbd\xb2\x3d\xbc\x20\xe2\x8c\x98"

    // loop over the string bytes
    for i := 0; i < len(sample); i++ {
        fmt.Printf("%x ", sample[i])
    }
    fmt.Println()

    // same as the byte-by-byte loop above
    fmt.Printf("% x\n", sample) // bd b2 3d bc 20 e2 8c 98

    // escape any non-printable byte sequences ..
    fmt.Printf("% q\n", sample) // "\xbd\xb2=\xbc ⌘"

    // .. escape also non-ASCII bytes while intepreting UTF-8
    fmt.Printf("%+q\n", sample) // "\xbd\xb2=\xbc \u2318"
}
```
