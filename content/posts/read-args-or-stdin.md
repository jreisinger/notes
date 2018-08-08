---
title: "Reading from command line arguments or from STDIN"
date: 2018-08-08
categories: [prog]
tags: [go]
---

Go

```
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
        scan := bufio.NewScanner(os.Stdin)
        for scan.Scan() {
            fmt.Println(scan.Text())
        }
    }
}
```
