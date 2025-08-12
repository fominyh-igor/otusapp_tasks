BINARY_NAME=../bin/dosa
DOCKER_IMAGE=dosa
VERSION=1.0.15

DOCKER_USERNAME=ifominykh

.PHONY: build run docker

# Сборка бинарника под текущую ОС
build:
	cd src && go build -o $(BINARY_NAME) main.go

# Запуск сервера локально
run:
	cd src && go run main.go

# Сборка Docker-образа с кросс-компиляцией под linux/amd64
docker:
	cd src && GOOS=linux GOARCH=amd64 go build -o $(BINARY_NAME) main.go
	docker build --platform linux/amd64 -t $(DOCKER_IMAGE):$(VERSION) .

# Публикация образа в докерхабе
docker-push:
	docker tag $(DOCKER_IMAGE):$(VERSION) $(DOCKER_USERNAME)/$(DOCKER_IMAGE):$(VERSION)
	docker push $(DOCKER_USERNAME)/$(DOCKER_IMAGE):$(VERSION)

# Очистка
clean:
	rm -f $(BINARY_NAME)