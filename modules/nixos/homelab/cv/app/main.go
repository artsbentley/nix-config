package main

import (
	"embed"
	"html/template"
	"log"
	"net/http"
)

//go:embed templates/* static/*
var content embed.FS

func main() {
	tmpl := template.Must(template.ParseFS(content, "templates/index.html"))

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		err := tmpl.Execute(w, nil)
		if err != nil {
			http.Error(w, "Error rendering page", http.StatusInternalServerError)
		}
	})

	fs := http.FS(content)
	http.Handle("/static/", http.StripPrefix("/static/", http.FileServer(fs)))

	log.Println("Listening on http://localhost:3333")
	log.Fatal(http.ListenAndServe(":3333", nil))
}
