---
title: "#001: Barebones"
date: 2018-11-02T19:26:54-07:00
---

First Post! I never formally created a project with most of the knowledge I've gained ths far, and I wanted to focus on every aspect of the project: how it's built, how the application works, how it's prepared, deployed, etc. I think these posts will be a great introduction into getting a some idea about the "fuzzy" stuff we see in web dev; making sense of the buzzwords and learning how things work. Anyways...

I'm building a web server that's going to say, "Hello, World!". 

Right now, the basics are in the `*.go`

End basic post, cue technical stuff.

---

### What is a Web Server?

[Mozilla's Post, "What is a Web Server?"](https://developer.mozilla.org/en-US/docs/Learn/Common_questions/What_is_a_web_server) is a pretty good primer on understanding what a web server is. They make it distinct that the term can refer to hardware, software, or both.

Their software definition:
`An HTTP server is a piece of software that understands URLs (web addresses) and HTTP (the protocol your browser uses to view webpages)`

**My fuzzy definition: a process that listens to one or more ports and accepts HTTP requests from them.**

### What is a Port?

[Wikipedia's post](https://en.wikipedia.org/wiki/Port_(computer_networking)) is a pretty good primer. From it's simplest description, it's, "an endpoint of communication."

Processes can send and receive information via ports.

Processes can communicate with entities outside of the server/computer via ports as well.

A web server is a process that listens to one or more ports.

Have you ever used FTP or SSH before? You're connecting to that server - an FTP/SSH server (same thing as a process) that is listening on a default port for those protocols. Mind. Blown. *BOOOOOOOM*

While you can have a process listen on a certain range of port numbers, the default port for an HTTP server is 80. There are a list of official and unofficial port numbers that can be reviewed [here](https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers#Well-known_ports). Be mindful of which ones you listen to when writing applications.

**My fuzzy definition: an endpoint of communication.**

No copyright intended, but it really doesn't get simpler than that. 

Think about it from a real world perspective. Before air travel, the main way people, ideas, and cargo went from continent to continent was by ship. The best way for these ships to land on the continent and be "connected" with the continent was via ports. Ship ports! 

Yes, the ships could probably land anywhere they wanted, but that's not the point. If ships landed anywhere, they'd still need to "get connected". Their goods, people, or ideas need to be "received" by businesses who will buy the goods or people who will meet/greet them; entities that will be receiving. 

A ship is a 'payload' of data, some kind of information. In our case, it's an HTTP request. 

Our HTTP server is the `receiving entity`. It listens on a port (it's possible ot listen to multiple ports, let's keep it simple though). **

When you `curl` or navigate to `localhost:8080`, you send an HTTP GET request (GET is an [HTTP Request method](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods) to port `8080`. 

Our web server is listening on that port. It receives the request, analyzes the request, and passes a response. Now let's talk about the web server code.

### Go Go Gadget Golang!

I'm using Go. It's neat. Check out the basic code to run a web server; don't worry about not knowing Go either.

```
package main

import (
    "fmt"
    "log"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello, World!")
}

func main() {
    http.HandleFunc("/", handler)
    log.Fatal(http.ListenAndServe(":8080", nil))
}
```

This is a full code snippet. You can stick this in a `main.go` file, build the binary and run that, or simply just do a `go run main.go` to start a process that will listen on port `8080` on your localhost. Navagat to `localhost:8080` or use the linux `curl` command `curl localhost:8080` from a terminal and you'll get "Hello, World!" as a response. Neato!

### Check it Out

Output of `curl` command on OSX, you can do this for Linux too since `curl` is a Linux tool:
(127.0.0.1 is the same as localhost, or 'home')
```
$ curl 127.0.0.1:8080

> Hello, world!
```

I found a way to check for the process that listens to a specific port [here](https://stackoverflow.com/questions/4421633/who-is-listening-on-a-given-tcp-port-on-mac-os-x):
```
$ lsof -nP -i4TCP:8080 | grep LISTEN

> helloworl 82601 corey_prak    3u  IPv6 0xdedaad31c2f80c4b      0t0  TCP *:8080 (LISTEN)
```

### Testing

So we have a web server, we manually tested it by actually navigating to it on our browser, OR we used the `curl` command.

It's important to have programmatic tests. Test for when things work, when things shouldn't work, unintended and unintended behavior, etc. 

Via programmatic tests, we'll be able to save us time by being able to trigger tests with a simple command. When we automate some processes, you'll see just how powerful programmatic tests are.

In my opinion, as a programmer, automation is the most powerful skill you have.

In this project, all files ending in `_test.go` are test files. Through the most basic way of testing, we can simply run `go test` to execute them.

---

## Conclusion

We now have a sense of web servers, computer ports, and the HTTP protocol. 

We have a basic server in Go.

We wrote programmatic tests, great for saving us time, great for automation.

Pretty good first post, I'd say.