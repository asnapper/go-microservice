FROM golang:1.10 AS build

WORKDIR /go/src/app
COPY . .
RUN go get -u github.com/golang/dep/cmd/dep
RUN dep ensure
RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags "-w -X main.version=$(git describe --tags --dirty --always)" -o app

FROM scratch
COPY --from=build /go/src/app/app /app
ENTRYPOINT ["/app"]

EXPOSE 8080