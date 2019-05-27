package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"os"

	_ "github.com/go-sql-driver/mysql"
	"github.com/gorilla/mux"
	sw "github.com/mvgmb/taki-back/server/api"
)

var (
	dbAddr = os.Getenv("DB_ADDR")
	dbPort = os.Getenv("DB_PORT")
	dbUser = os.Getenv("DB_USER")
	dbPass = os.Getenv("DB_PASS")
	dbName = os.Getenv("DB_NAME")

	db     *sql.DB
	router *mux.Router
)

func main() {
	var err error

	dataSourceName := fmt.Sprintf("%s:%s@(%s:%s)/%s", dbUser, dbPass, dbAddr, dbPort, dbName)

	log.Println(dataSourceName)

	// Connect to taki database
	db, err = sql.Open("mysql", dataSourceName)
	if err != nil {
		log.Fatal(err)
	}

	// Create router
	router = sw.NewRouter(db)
	// Close db connection after main is over
	defer db.Close()

	// Starts server
	log.Printf("Server started")
	log.Fatal(http.ListenAndServe(":8080", router))
}
