---
title: "Heap vs Stack"
date: 2018-08-07T08:43:41+02:00
categories: [prog]
tags: [c, go]
---

Both are memory regions.

Stack (temporary to a function)

* stores temporary variables created by functions
* LIFO data structure with push/pop operations
* all vars are popped off when function exits
* very fast
* limited in size

Heap (global)

* not as tightly managed by CPU
* in C you have to manage it yourself via `malloc()`, `calloc()` or `realloc()`
* if you fail you get a memory leak
* slower access because pointers are used
* limited only by physical memory

Go example:

```go
var global *int     // "global" is the name :-)

func f() {
    var x int       // heap-allocated because ...
    x = 1
    global = &x     // ... escapes from f()
}

func g() {
    y := new(int)   // allocated on the stack
    *y = 1
}

```

More

* https://www.gribblelab.org/CBootCamp/7_Memory_Stack_vs_Heap.html
* https://www.gopl.io/, ch. 2.3
