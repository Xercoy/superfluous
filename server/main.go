package main

import (
	"log"
	"net/http"
	"time"

	"github.com/gorilla/mux"
)

const (
	healthCheckMessage = "ONLINE"
	defaultMessage     = "Hello, world!"
	defaultPort        = "8081"
	defaultEndpoint    = "localhost"
)

func main() {
	router := mux.NewRouter()

	// set root as a valid path, then set the handler that will, uh, handle the request.
	router.HandleFunc("/", mainHandler)
	router.HandleFunc("/healthz", healthCheckHandler)

	http.Handle("/", router)
	http.Handle("/healthz", router)

	srv := &http.Server{
		Handler:      router,
		Addr:         (defaultEndpoint + ":" + defaultPort), // get this from envars when doing a refactor
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
	}

	log.Fatal(srv.ListenAndServe())
}
