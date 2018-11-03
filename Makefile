APP_NAME="superfluous-test"
DOCKERFILE_PATH="./infrastructure/docker/Dockerfile"
DOCKERFILE_PORT=4000
CONTAINER_PORT=8080

docker-build:
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o ./bin/superfluous server/*.go
	docker build -f $(DOCKERFILE_PATH) -t $(APP_NAME) .

docker-run:
	# -d is detached
	# -p <LOCAL PORT>:<CONTAINER PORT>
	docker run -d $(APP_NAME)