package database

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

var DB *sql.DB

func InitDB() {
	conf := LoadDBConfig()

	log.Printf(conf.ConnectionString())
	var err error
	DB, err = sql.Open("postgres", conf.ConnectionString())
	if err != nil {
		log.Fatal(err)
	}

	err = DB.Ping()
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("Successfully connected to PostgreSQL!")
}
