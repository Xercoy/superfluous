---
title: "#005: Reflecting"
date: 2018-11-04T18:12:27-08:00
---

From the ground up, let's take a look at what we have here.

### Infrastructure

We have a fresh server ready to do our bidding. We used Terraform to faciliate an automated way to provision that server.

### Web Server 

We wrote a simple web server that says, "Hello, World!" That's it.

### Docker Container

We've encapsulated our web server in a Docker container for plenty of different reasons. Portability, redundancy, to name just two. 

--- 

Where do we go from here? 

Well, given what we have at this point in time, if we were to start from the beginning, we'd have to:

- Use Terraform to create the infrastructure; remember this example uses Digital Ocean. 
- Log into that Droplet and copy over the repo to the server.
- Install Docker and run the container.

All those steps are manual, but remember, we can (and we should!) automate all of that. 

There's much more to be done, and there are scenarios related to performance, security, monitoring, and so many other things that I'm leaving out for now. 

Just thought I'd take some time to reflect on what's been going on. All this code was nothing as of two days ago, so I thought I'd slow down and take some time to reflect. 