FROM golang:1.10-alpine 

LABEL maintainer corey@prak.me 

RUN mkdir /server 
ADD ./bin /server/bin

WORKDIR /server 

EXPOSE 8080

ENTRYPOINT ["./bin/superfluous"]