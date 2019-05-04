---
title: "Reading from STDIN or from command line arguments"
date: 2018-08-08
categories: [prog]
tags: [go]
---

```go
// Dup2 prints the count and text of lines that appear more than once
// in the input. It reads from stdin or from a list of named files.
package main

import (
    "bufio"
    "fmt"
    "os"
)

func main() {
    counts := make(map[string]int)

    files := os.Args[1:]
    if len(files) == 0 {    // STDIN
        countLines(os.Stdin, counts)
    } else {                // command line args
        for _, arg := range files {
            f, err := os.Open(arg)
            if err != nil {
                fmt.Fprintf(os.Stderr, "dup2: %v\n", err)
                continue
            }
            countLines(f, counts)
            f.Close()
        }
    }

    // print report
    for line, n := range counts {
        if n > 1 {
            fmt.Printf("%d\t%s\n", n, line)
        }
    }
}

func countLines(f *os.File, counts map[string]int) {
    input := bufio.NewScanner(f)
    for input.Scan() {
        counts[input.Text()]++
    }
    // NOTE: ignoring potential errors from input.Err(). See
    // https://golang.org/pkg/bufio/#example_Scanner_lines
}
```

Taken from [The Go Programming Language](https://learning.oreilly.com/library/view/the-go-programming/9780134190570/ebook_split_013.html). See also [Read a file (stdin) line by line](https://yourbasic.org/golang/read-file-line-by-line/).
