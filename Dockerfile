FROM golang:latest

RUN mkdir /build
WORKDIR /build

RUN export GO111MODULE=on 
#RUN go get github.com/AdminTurnedDevOps/GoWebAPI/app
RUN cd /build && git clone https://github.com/samtechops/go-app.git


EXPOSE 80

ENTRYPOINT [ "/build/GoWebAPI/main" ]