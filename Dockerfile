FROM golang:latest
WORKDIR /go/src/
COPY . .
RUN  GOPRIVATE=github.com CGO_ENABLED=0 go build -o main .
EXPOSE 80
CMD [ "/go/src/main" ]
