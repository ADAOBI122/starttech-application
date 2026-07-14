FROM golang:1.25-alpine AS builder

WORKDIR /app

COPY MuchToDo/go.mod MuchToDo/go.sum ./

RUN go mod download

COPY MuchToDo .

RUN go build -o backend-api ./cmd/api


FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/backend-api .

EXPOSE 8080

CMD ["./backend-api"]
