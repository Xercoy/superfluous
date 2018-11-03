# Superfluous

The most overengineered "hello, World!" app.

Currently built using: Go, Docker, Terraform.

# About

It's gonna be "dockerized", "kubernetified", "terraformed", and "other-stuff-ated"...

# Motivation

Just a personal project to help me formally use the knowledge I've gained about writing web applications thus far.

# How to Run

This can be run locally or via Docker.

### Running Locally
If Go is installed, `go build` should produce a binary. Execute that binary to start the web server which will be listening on port `8080`.

### Via Docker 
Assuming Docker is installed, there are commands in the Makefile directives set to build and run the server. `make docker-build` will build the image from the Dockerfile and `docker-run` will execute the container. Note: The container will not run in detached mode for now AKA as a "background container". 

## Test if Things are Running

Navigate to the page and you should see:
```
"Hello, world!"
```

via the `curl` command:
```
$ curl 127.0.0.1:8080
> Hello, world!
```
---

# Changelog

**[11/02/2018]**

- Initial commit, added basic hello world message.
- added tests, refactored files a bit.
- Post #1 done

**[11/03/2018]**

- Added Dockerfile, Makefile, gitignore

# TODOS

- Post #2: dockerfile, makefile, gitignore
- more testing
- logging
- flags for flexibility (ports, etc)
- dockerfile!
- Helm chart + kubernetes
- GO: something with middleware, something with context
- SSL? WEBTOKENS?
- API KEY?
- Secret Store?
- database: migration, setup, separate docker container, etc.
- internationalization (hello world in different languages)
- makefile
- bling (go convey, badges, etc)
- continuous integration
- continuous delivery
- monitoring
- webhooks
- ansible playbook to run, install, etc
- push to dockerhub

# Things to learn 

- gitref
- triggering releases