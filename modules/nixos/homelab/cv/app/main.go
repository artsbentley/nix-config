// main.go
package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "<html><body>Hello from Go!</body></html>")
	})
	http.HandleFunc("/attributes", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		fmt.Fprintf(w, `{"foo":"bar","version":1}`)
	})
	http.ListenAndServe(":3333", nil)
}
