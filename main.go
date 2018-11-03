package main

import (
	"log"
	"net/http"
)

const (
	defaultMessage  = "Hello, world!"
	defaultPort     = "8080"
	defaultEndpoint = "localhost"
)

func main() {
	http.HandleFunc("/", mainHandler)

	log.Fatal(http.ListenAndServe(defaultPort, nil))
}
