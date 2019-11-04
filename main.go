package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/api/v1/message", HelloServer)
	http.ListenAndServe(":8080", nil)
}

func HelloServer(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Scala is the best language in the world\n")
}
