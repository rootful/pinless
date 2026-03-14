FROM golang:1.25.6-alpine3.19 AS build
WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
RUN go build -o pinless

FROM alpine:3.19
COPY --from=build /app/pinless /pinless
COPY templates /templates
COPY static /static
EXPOSE 3000
CMD ["/pinless"]