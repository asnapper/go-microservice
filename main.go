package main

import (
    "net/http"
    "log"
    "github.com/gorilla/mux"
)

func healthHandler(w http.ResponseWriter, r *http.Request) {
    w.Write([]byte("I'm healthy!\n"))
}

var version string

func versionHandler(w http.ResponseWriter, r *http.Request) {
    w.Write([]byte(version))
}

func main() {
    r := mux.NewRouter()
    r.HandleFunc("/health", healthHandler)
    r.HandleFunc("/version", versionHandler)

    log.Fatal(http.ListenAndServe("0.0.0.0:8080", r))
}