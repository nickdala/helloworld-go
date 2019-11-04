FROM golang:1.12-alpine AS build_base

RUN apk add --no-cache git

# Set the Current Working Directory inside the container
WORKDIR /tmp/helloworld-go

COPY main.go .

# Build the Go app
RUN go build -o ./out/helloworld-go .

# Start fresh from a smaller image
FROM alpine:3.9 
RUN apk add ca-certificates

COPY --from=build_base /tmp/helloworld-go/out/helloworld-go /app/helloworld-go

# This container exposes port 8080 to the outside world
EXPOSE 8080

# Run the binary program produced by `go install`
CMD ["/app/helloworld-go"]