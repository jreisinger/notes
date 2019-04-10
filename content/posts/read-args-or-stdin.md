---
title: "Reading command line arguments or STDIN"
date: 2018-08-08
categories: [prog]
tags: [go, perl]
---

Go

```go
package main

import (
    "bufio"
    "os"
    "fmt"
)

func main() {
    if len(os.Args) > 1 {               // we have command line args
        for _, arg := range os.Args[1:] {
            fmt.Println(arg)
        }
    } else {                            // read from STDIN
        stdin := bufio.NewScanner(os.Stdin)
        for stdin.Scan() {
            fmt.Println(stdin.Text())
        }
    }
}
```

Perl

```perl
#!/usr/bin/env perl
use 5.014;    # includes strict
use warnings;
use autodie;

if (@ARGV) {
    say for @ARGV;
} else {
    print for <STDIN>;    # but all lines at once
}
```
