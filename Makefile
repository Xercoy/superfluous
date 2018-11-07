APP_NAME="superfluous-app"
DOCKERFILE_PATH="./infrastructure/docker/Dockerfile"
DOCKERFILE_PORT=4000
CONTAINER_PORT=8080
SERVER_CODE_PATH=./server
BIN_PATH=./bin/superfluous

GO_PACKAGES=$(shell go list ./...)

APP_CONTAINER=$(shell docker ps |grep ${APP_NAME}| awk '{print $$1}')
OS_NAME=$(shell uname -s | awk '{print $1}')

binary:
	@echo "building binary..."
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o ${BIN_PATH} ${SERVER_CODE_PATH}

docker-build: binary
	@echo "building image from Dockerfile..."
	docker build -f $(DOCKERFILE_PATH) -t $(APP_NAME) .

docker-run: docker-build
	# -d is detached
	# -p <LOCAL PORT>:<CONTAINER PORT>
	@echo "starting container for ${APP_NAME}..."
ifeq ("${OS_NAME}","Darwin")
	docker run -d -p 8080:8080 $(APP_NAME)
else
	docker run --rm -d --network host --name ${APP_NAME} ${APP_NAME}
endif
	
docker-kill:
	@echo "forcefully stopping container for ${APP_NAME}..."
	docker rm -f ${APP_CONTAINER}

docker-clear-all:
	@echo "removing all containers..."
	docker rm -f $(shell docker ps -a -q)

	@echo "removing all images..."
	docker rmi -f $(shell docker images -q)

build-all:
	@echo "running script to install dependencies and run application..."
	./full_installation.sh

# need to have vet, lint, gofmt, and validate
go-test:
	@echo "running tests on all Go packages..."
	go test -race -cover -run "Test[^X]" $(GO_PACKAGES)

go-format:
	@echo "formatting all go files..."
	gofmt -s -l -w $(GO_FILES)

go-vet:
	@echo "vetting all go files..."
	go vet $(GO_PACKAGES)

# docker-clear: clean all running containers and images
# test-all: run validations and all tets