### Image build

```
mkdir -p build
export TMPDIR=$(pwd)/build

VERSION=v3.5.1
GO_VERSION=1.17

podman build \
  --build-arg VERSION=$VERSION \
  --build-arg GO_VERSION=$GO_VERSION \
  -f Dockerfile \
  -t ghcr.io/randomcoww/etcd:$VERSION
```

```
podman push ghcr.io/randomcoww/etcd:$VERSION
```