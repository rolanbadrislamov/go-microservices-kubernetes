# base go image
FROM golang:1.21.0-alpine as builder

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN CGO_ENABLED=0 go run -o listenerApp ./cmd/api

RUN chmod +x /app/listenerApp

# build a tiny docker image
FROM alpine:latest

RUN mkdir /app

COPY --from=builder /app/listenerApp /app

CMD [ "/app/listenerApp" ]