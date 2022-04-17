# syntax=docker/dockerfile:1

# Alpine is chosen for its small footprint
# compared to Ubuntu
FROM golang:1.18-alpine AS builder

RUN apk add --no-cache git

RUN mkdir /app
ADD . /app

# We want to populate the module cache based on the go.{mod,sum} files.
COPY go.mod ./app
#COPY go.sum .
#ADD *.go ./
WORKDIR /app

RUN go mod download all

# Unit tests
#RUN go test -v

# Set the Current Working Directory inside the container


# Build the Go app
RUN go build -o main .

#FROM scratch
#COPY --from=builder . /app

# Run the binary`
#CMD ["/app/main"] // owerwritten by ENTRYPOINT

ENTRYPOINT ["/app/main"]

# This container exposes port 8080 to the outside world
EXPOSE 8080