---
title: "Go Strings"
date: 2019-10-09
categories: [Prog]
tags: [Go, Strings]
---

## What is a string

String is a read-only **slice of bytes**. A string can hold arbitrary bytes not just UTF-8 text or any other predefined format. Here is a string literal that uses the `\xNN` notation (bytes' hex values range from `00` to `FF`):

```go
const sample = "\xbd\xb2\x3d\xbc\x20\xe2\x8c\x98"
```

We can also create a "raw string" that can contain only literal text (regular string can contain escape sequences as shown above):

```go
const placeOfInterest = `⌘`
```

## Printing strings

```go
// Print the string directly.
fmt.Print(sample)                   // ��=� ⌘

// Get individual bytes by looping over the string.
for i := 0; i < len(sample); i++ {  // bd b2 3d bc 20 e2 8c 98
    fmt.Printf("%x ", sample[i])
}

// Print bytes in hex (same output as the byte-by-byte loop above).
fmt.Printf("% x\n", sample)         // bd b2 3d bc 20 e2 8c 98

// Escape any non-printable byte sequences ..
fmt.Printf("% q\n", sample)         // "\xbd\xb2=\xbc ⌘"

// .. escape also non-ASCII bytes while intepreting UTF-8.
fmt.Printf("%+q\n", sample)         // "\xbd\xb2=\xbc \u2318"
```

## More

* https://blog.golang.org/strings
