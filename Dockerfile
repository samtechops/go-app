FROM golang:1.18.3-alpine3.16

WORKDIR /go/src/
COPY . .
RUN  GOPRIVATE=github.com CGO_ENABLED=0 go build -o main .
CMD [ "/main" ]
