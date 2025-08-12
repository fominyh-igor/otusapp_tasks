package main

import (
	"log"
	"net/http"

	"github.com/gorilla/mux"

	"dosa/database"
	"dosa/handlers"
	"dosa/utils"
)

func main() {
	// Инициализация базы данных
	database.InitDB()
	defer database.DB.Close()
	log.Printf("Database initialized")
	// Создание обработчика
	userHandler := &handlers.UserHandler{DB: database.DB}
	healthHandler := &handlers.HealthHandler{}
	log.Printf("Handlers initialized")
	// Настройка роутера
	router := mux.NewRouter()

	router.HandleFunc("/health", healthHandler.Health).Methods("GET")
	// RESTful эндпоинты
	router.HandleFunc("/users", userHandler.CreateUser).Methods("POST")
	router.HandleFunc("/users", userHandler.GetAllUsers).Methods("GET")
	router.HandleFunc("/users/{id}", userHandler.GetUser).Methods("GET")
	router.HandleFunc("/users/{id}", userHandler.UpdateUser).Methods("PUT")
	router.HandleFunc("/users/{id}", userHandler.DeleteUser).Methods("DELETE")

	// Настройка CORS (для разработки)
	corsHandler := utils.CorsMiddlewareDev(router)
	//corsHandler := utils.CorsMiddlewareProd(router)

	// Запуск сервера
	log.Println("Server starting on :8000")
	log.Fatal(http.ListenAndServe(":8000", corsHandler))
}
