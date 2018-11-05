---
title: "#002: Makefile"
date: 2018-11-03T13:29:59-07:00
---

[Make](https://en.wikipedia.org/wiki/Make_(software)) is a build automation tool. It reads directives from a file called a `Makefile`. People familiar with building or installing Linux application and tools from source will be very familiar with this. 

In Unix and Unix-like operating systems, make is oftentimes built in. You can create your own Makefile and have fun with it without needing to install anything.

In addition to building applications, it can perform certain operations related to preparing and manipulating the project. I basically use it to automate a bunch of commands that I'm too lazy to type. 

Like Git, a Makefile is really powerful, can seem pretty involved and complicated, but a minimal understanding of it can get you far.

Take a look:

```
APP_NAME="superfluous-test"
DOCKERFILE_PATH="./infrastructure/docker/Dockerfile"
DOCKERFILE_PORT=4000
CONTAINER_PORT=8080

docker-build:
        # build the binary of the web server to ensure that the image contains the latest version
        CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o ./bin/superfluous server/*.go

        # build the image
        docker build -f $(DOCKERFILE_PATH) -t $(APP_NAME) .

docker-run:
        # -d is detached
        # -p <LOCAL PORT>:<CONTAINER PORT>
        # create and run a container based on the image
        docker run -d $(APP_NAME)
```

The top is declaring variables, then I'm just creating two directives that can build and run the image.

Makefiles can do so much more. I almost feel bad for not getting into it as much, but the resources Google can bring can do so much more. 

To execute these directives, I simply just need to enter `make docker-build` or `make docker-run`. 

In regards to automation, preparation, and overall saving us time, Makefiles are great.

If we wanted to improve this farther and make it more useful, we could add a directive to run all the tests. The possibilities are endless. 