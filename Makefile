# Makefile pour tacticians-hub

# Variables
BINARY_NAME=api
BINARY_PATH=cmd/api
DB_URL=postgresql://user:pass@localhost/tacticians_hub?sslmode=disable

# Commandes principales
.PHONY: build run test clean migrate

build:
	@echo "Building application..."
	go build -o ${BINARY_NAME} ./${BINARY_PATH}

run: build
	@echo "Starting application..."
	./${BINARY_NAME}

test:
	@echo "Running tests..."
	go test -v ./...

clean:
	@echo "Cleaning up..."
	go clean
	rm -f ${BINARY_NAME}

# Commandes de développement
dev:
	@echo "Starting in development mode with hot reload..."
	air

# Database commands
migrate-up:
	@echo "Running database migrations..."
	migrate -path ./migrations -database "${DB_URL}" up

migrate-down:
	@echo "Reverting last migration..."
	migrate -path ./migrations -database "${DB_URL}" down 1

# Installation des dépendances
deps:
	@echo "Downloading dependencies..."
	go mod download
	go mod tidy