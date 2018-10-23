package main

import "fmt"

// HelloWorld prints "Hello World!" with an endline.
func HelloWorld() {
	fmt.Println("Hello World!")
}

func main() {
	defer HelloWorld()
}
