FROM golang:1.10 AS build

WORKDIR /go/src/app
COPY . .
RUN go get -u github.com/golang/dep/cmd/dep
RUN dep ensure
RUN go install -v .
RUN go build -o app

FROM scratch
COPY --from=build /go/src/app/app /app
ENTRYPOINT ["./app"]