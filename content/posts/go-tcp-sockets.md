---
title: "TCP sockets with Go"
date: 2019-01-25
draft: false
categories: [net,prog]
tags: [tcp,socket,go]
---

This is an HTTP client implemented using socket-level programming:

```go
// Usage: go run getHeadInfo.go reisinge.net:80
package main

import (
	"fmt"
	"io/ioutil"
	"net"
	"os"
)

func main() {
	service := os.Args[1]

	tcpAddr, err := net.ResolveTCPAddr("tcp", service)
	checkError(err)

	conn, err := net.DialTCP("tcp", nil, tcpAddr)
	checkError(err)

	_, err = conn.Write([]byte("HEAD / HTTP/1.0\r\n\r\n"))
	checkError(err)

	result, err := ioutil.ReadAll(conn)
	checkError(err)

	fmt.Printf("%s\n", result)
}

func checkError(err error) {
	if err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err.Error())
		os.Exit(1)
	}
}
```

To add a timeout you can use the `Dialer` structure:

```go
package main

import (
	"fmt"
	"io/ioutil"
	"net"
	"os"
	"time"
)

func main() {
	service := os.Args[1]

	d := net.Dialer{Timeout: 2 * time.Second}
	conn, err := d.Dial("tcp", service)
	checkError(err)

	_, err = conn.Write([]byte("HEAD / HTTP/1.0\r\n\r\n"))
	checkError(err)

	result, err := ioutil.ReadAll(conn)
	checkError(err)

	fmt.Printf("%s\n", result)
}

func checkError(err error) {
	if err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err.Error())
		os.Exit(1)
	}
}
```

This time you don't need to resolve the TCP address (e.g. `reisinge.net:80`).

It's normal to have a lot of error checking in network programming because lot
of things can go wrong (e.g. syntax error in the address, service not running,
hardware failing).

More: [Network programming with
Go](https://www.apress.com/gp/book/9781484226919): 3. Socket-level programming
