---
title: "Sorting with Go"
date: 2018-10-24
categories: [prog]
tags: [go]
---

```go
package main

import (
	"fmt"
	"sort"
)

// A type with the three methods required for sorting.
type StringSlice []string

func (p StringSlice) Len() int           { return len(p) }
func (p StringSlice) Less(i, j int) bool { return p[i] < p[j] }
func (p StringSlice) Swap(i, j int)      { p[i], p[j] = p[j], p[i] }

func main() {
	names := []string{"Xavier", "John", "Eve", "Adam"}

	// sort.Strings(names) has the same effect
	sort.Sort(StringSlice(names))

	fmt.Printf("%v\n", names)
}
```
