FROM golang:1.13.3-alpine as BUILD

WORKDIR /go/src/github.com/etcd-io
ARG ETCD_VERSION=v3.4.10

RUN set -x \
  \
  && apk add --no-cache \
    git \
    make \
    bash \
  \
  && git clone -b $ETCD_VERSION \
    https://github.com/etcd-io/etcd.git \
  && cd etcd \
  && GO_LDFLAGS='-s -w' make build

FROM scratch

COPY --from=BUILD /go/src/github.com/etcd-io/etcd/bin/ /usr/local/bin/
