# Имя бинарника
BINARY_NAME=health-service
# Имя Docker-образа
DOCKER_IMAGE=docker-sample
# Версия (можно менять)
VERSION=1.0.7

.PHONY: build run docker

# Сборка бинарника под текущую ОС
build:
	go build -o $(BINARY_NAME) main.go

# Запуск сервера локально
run:
	go run main.go

# Сборка Docker-образа с кросс-компиляцией под linux/amd64
docker:
	GOOS=linux GOARCH=amd64 go build -o $(BINARY_NAME) main.go
	docker build --platform linux/amd64 -t $(DOCKER_IMAGE):$(VERSION) .

# Очистка (опционально)
clean:
	rm -f $(BINARY_NAME)