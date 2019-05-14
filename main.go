package main

import (
	"database/sql"
	"log"
	"net/http"

	_ "github.com/go-sql-driver/mysql"
	"github.com/gorilla/mux"
	sw "github.com/mvgmb/taki-back/server"
	"github.com/mvgmb/taki-back/util"
)

var (
	db     *sql.DB
	router *mux.Router
)

func init() {
	var err error

	// Connect to taki database
	db, err = sql.Open("mysql", "user:password@(localhost:3306)/taki")
	if err != nil {
		log.Fatal(err)
	}

	// Create router
	router = sw.NewRouter()
}

func main() {
	// Close db connection after main is over
	defer db.Close()

	// Dummy test
	stmt := "SELECT * FROM users"

	result, err := util.RunStatement(db, stmt)
	if err != nil {
		log.Fatal(err)
	}
	log.Println(result)

	// Starts server
	log.Printf("Server started")
	log.Fatal(http.ListenAndServe(":8080", router))
}
