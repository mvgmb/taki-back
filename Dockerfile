FROM golang:latest

WORKDIR /go/src/github.com/mvgmb/taki-back
COPY ./server/api ./server/api
COPY ./server/main.go .

RUN go get -v ./... && \
    go build -v ./...

CMD ["/go/bin/taki-back"]
