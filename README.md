# Superfluous

The most overengineered "hello, World!" app.

# About

It's gonna be "dockerized", "kubernetified", "terraformed", and "other-stuff-ated"...

# Motivation

Just a personal project to help me formally use the knowledge I've gained about writing web applications thus far.

# How to Run

If Go is installed, `go build` should produce a binary. Execute that binary to start the web server which will be listening on port `8080`.

Navigate to the page and you should see:
```
"Hello, world!"
```

via the `curl` command:
```
$ curl 127.0.0.1:8080
> Hello, world!
```

# Changelog

**[11/02/2018]**

- Initial commit, added basic hello world message.
- added tests, refactored files a bit.

# TODOS

- more testing
- logging
- flags for flexibility (ports, etc)
- dockerfile!
- Helm chart + kubernetes