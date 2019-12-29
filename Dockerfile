FROM golang:1.13.3-alpine as BUILD

WORKDIR /go/src/github.com/etcd-io
ENV ETCD_VERSION v3.4.3

RUN set -x \
  \
  && apk add --no-cache \
    git \
  \
  && git clone -b $ETCD_VERSION \
    https://github.com/etcd-io/etcd.git \
  && cd etcd \
  && mkdir bin \
  && GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -v \
    -installsuffix cgo \
    -o bin/etcd . \
  && GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -v \
    -installsuffix cgo \
    -o bin/etcdctl ./etcdctl

FROM scratch

COPY --from=BUILD /go/src/github.com/etcd-io/etcd/bin/ /usr/local/bin/