FROM golang:1.23.4 AS builder

WORKDIR /app

COPY go.mod main.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o /app/main .

FROM scratch

COPY --from=builder /app/main /main

ENTRYPOINT ["/main"]