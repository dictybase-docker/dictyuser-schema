FROM golang:1.20.7-alpine3.18
RUN apk add --no-cache git build-base \
    && go install github.com/pressly/goose/v3/cmd/goose@latest

FROM postgres:14-alpine
RUN apk --no-cache add ca-certificates
COPY --from=0 /go/bin/goose /usr/local/bin/
RUN mkdir -p /usr/src/appdata
COPY *.sql /usr/src/appdata/
COPY *.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install_schema.sh
