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
	// set root as a valid path, then set the handler that will, uh, handle the request.
	http.HandleFunc("/", mainHandler)

	// start listening on the TCP network address, in this case the default is on port 8080.
	log.Fatal(http.ListenAndServe(defaultEndpoint+":"+defaultPort, nil))
}
