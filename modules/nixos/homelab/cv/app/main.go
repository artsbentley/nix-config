package main

import (
	"embed"
	"io/fs"
	"log"
	"net/http"
)

//go:embed static
var content embed.FS

func main() {
	sub, err := fs.Sub(content, "static")
	if err != nil {
		log.Fatal(err)
	}
	http.Handle("/", http.FileServer(http.FS(sub)))
	log.Println("Listening on http://localhost:8080")
	log.Fatal(http.ListenAndServe(":3333", nil))
}
