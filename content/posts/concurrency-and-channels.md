---
title: "Concurrency and Channels"
date: 2019-05-06
draft: false
categories: [prog]
tags: [go]
---

A *goroutine* is a function capable of running concurrently with other functions. Create a gouroutine with the `go` keyword. 

A *channel* is a way for gouroutines to communicate with each other and *synchronize* their execution.

When `pinger` or `ponger` attempts to send a message on the channel, it will
wait until `printer` is ready to receive the message (blocking):

```go
package main

import (
    "fmt"
    "time"
)

func main() {
    ch := make(chan string)

    go pinger(ch)
    go ponger(ch)
    go printer(ch)

    // Wait for Enter to exit.
    var input string
    fmt.Scanln(&input)
}

func pinger(ch chan string) { for { ch <- "ping" } }
func ponger(ch chan string) { for { ch <- "pong" } }

func printer(ch chan string) {
    for {
        fmt.Println(<-ch)
        time.Sleep(time.Second * 1)
    }
}
```

Taken from "Introducing Go". See also [fetchall.go](https://github.com/jreisinger/go/blob/master/http/fetchall.go) and [fetchall2.go](https://github.com/jreisinger/go/blob/master/http/fetchall2.go).
