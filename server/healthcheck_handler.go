package main

import (
	"fmt"
	"net/http"
)

func healthCheckHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, healthCheckMessage)
}
