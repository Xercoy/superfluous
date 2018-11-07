---
title: "#003: Dockerize"
date: 2018-11-03T18:29:59-07:00
---

Now that we have a basic web server working with some tests, it's time to Dockerize it. 

This portion is pretty straightforward. There aren't too many dependencies on it, so I created a Dockerfile that basically opened the default port and started it. 

Cue technical, educational stuffs.

---

Docker is another popular buzzword that fills the internet, with good reason. 

In a nutshell, it makes it easy to pack and ship programs. I'm trying really hard to explain this into as little words as possible without spending oodles amount of time on this, so bear with me. Let's start by taking a look at the problem. 

### Big Problem #1: Works on My Machine

To get some peice of software working, sometimes you'd need to install prerequisite software or do all these other obscure and miscellaneous things. We've all been there. To that effect, a lot of unfuriating situations in software come from issues in 'snowflake' environments - snowflake meaning a unique environment. 

You'd expect the test, production, and development environment to look the same, but it's not. They're all snowflakes. "Works on my machine" is the precursor phrase to a bad day. 

### Big Problem #2: Monolith Soup

Another issue is the way applications are developed. Review the definition of a monolithic application from Wikipedia:

`A monolithic application is self-contained, and independent from other computing applications. The design philosophy is that the application is responsible not just for a particular task, but can perform every step needed to complete a particular function.[1][2] Today, some personal finance applications are monolithic in the sense that they help the user carry out a complete task, end to end, and are "private data silos" rather than parts of a larger system of applications that work together.`

Monolithic applications can do many things; they're made up of so many different services and they're all tightly coupled. Not only does this make maintenance and development difficult, but it also makes it brittle. If one service or feature fails, usually the entire application goes down. 

Have you heard of the term microservices? Another great buzzword. The trend of creating applications is shifting from huge monolithic applications into a single application that is comprised of different services. Ergo, microservices. 

Keeping a service, feature, or component of a larger peice of software compartmentalized is immensely helpful. Development is improved in so many ways because all the extra, unrelated "stuff" is out of the way.

Scaling software, that is, changing and reducing growth to service application load, is revolutionized. To scale monolithic applications, you'd literally have to have more instances of that application running. The thing is, oone small part or service of the application could be the bottleneck. The only way to reduce the bottleneck for those one or two features/areas is to literally have more instances of the ENTIRE application running. 

With microservices, you could literally just spin up more instance of that particular service that needs to churn out more work. 

### An Example

Say some awesome application needs one $10,000 computer to run. This application does some kind of amazing stuff, and it can export files too. Let's say the exporter is the bottleneck. Instead of having 5 computers run 5 application instances on a monolithic application to make sure the exporter works fine, we could have a situation where we run everything on one computer, with more instances of the exporter microservice running. Voilà, money saved. 

Note that scaling can and very much does involve more than one machine/computer/whatever.

## Enter Docker

Docker helps with a form of virtualization, called containerization. This technology has existed for quite a while now, but Docker has made containerization much more accessible. 

Through containerization, we can compartmentalize our applications, keep them organized, and facilitate scaling. 

By compartmentalization, we can pack any dependencies and other things involved with getting a service or application running. This fixes Big Problem #1 - no more 'works on my machine' problems or snowflake environments. We can basically eliminate the chance for any environment to vary. 

Again, I'm keeping this explanation really short. There's probably a bit that I'm leaving out. Google is your friend. Google is my savior.

## Dockerfiles, Docker Hub

Like npm, yum, and apt, Docker has a repository for easy access to open source images (which are the result of Dockerfiles) called Docker Hub. Organizations and people alike create images from Dockerfiles and upload them to this public repository for public use.

If you've looked at open source projects out there, you might have come across Dockerfiles that have accompanied them. I was once diving into some gnarly open source projects for machine learning, and instead of going through the installation process, I ran a Docker container based on the image from the Dockerfile provided.

A Dockerfile is basically a list of directives that dictate the characteristics of a container. You describe what OS your application needs to run on. If you'd need to do something like `sudo apt-get update` you can do that too. Copying files over, opening ports, so many other things. Basically, all the steps required to setup the application and start it can be done from a Dockerfile. 

Mine is short and simple, take a look:

```
FROM golang:1.10-alpine 

LABEL maintainer corey@prak.me 

RUN mkdir /server 
ADD ./bin /server/bin

WORKDIR /server 

EXPOSE 8080

ENTRYPOINT ["./bin/superfluous"]
```

The most important things to note is that I'm creating this image with another image as its base and building off of that. To be more specific, the image/OS is Ubuntu Alpine with Go 1.10 installed. This means I don't have to install it myself. DAMN!

You can see in the `EXPOSE` that I'm asking the container to "open" port 8080. This needs to be done, othewise the container is "closed".

The last line is the execution of the binary, AKA starting the web server. That's it. 

Note: This Dockerfile assumes that the creaton will be run from the root of the project, and executed via the Makefile.

## In Closing 

Docker is great, Dockerfiles are awesome, and we now have a Dockerized version of the web server.

Going forward, if we decide to add a database aspect to this overegineered beauty, dockerizing it is something we'd do as well. 

I will say now that the full power of having the web server in the container cannot be realized just yet. Stay with me.

## Corey Notes

[Networking Using the Host Network](https://docs.docker.com/network/network-tutorial-host/)
```
docker run --rm -d --network host --name testingcorey superfluous
```

Need to allow Docker to utilize the host network.

[Docker Container networking](https://docs.docker.com/v17.09/engine/userguide/networking/)

[Use Host Networking](https://docs.docker.com/v17.09/engine/userguide/networking/)