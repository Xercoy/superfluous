package main

import (
	"log"
	"net/http"
	"time"

	"github.com/gorilla/mux"
)

const (
	defaultMessage  = "Hello, world!"
	defaultPort     = "8080"
	defaultEndpoint = "localhost"
)

func main() {
	router := mux.NewRouter()

	// set root as a valid path, then set the handler that will, uh, handle the request.
	router.HandleFunc("/", mainHandler)

	http.Handle("/", router)

	srv := &http.Server{
		Handler:      router,
		Addr:         (defaultEndpoint + ":" + defaultPort), // get this from envars when doing a refactor
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
	}

	log.Fatal(srv.ListenAndServe())
}
