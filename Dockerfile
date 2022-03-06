FROM golang:alpine as builder

ENV DUMB_INIT_VERSION=1.2.2
ENV YGGDRASIL_TAG=v0.4.2

RUN set -ex \
    && apk --no-cache add build-base \
                          curl \
                          git \
    && git clone --branch  ${YGGDRASIL_TAG} "https://github.com/yggdrasil-network/yggdrasil-go.git" /src \
    && cd /src \
    && ./build \
    && curl -sSfLo /tmp/dumb-init "https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64" \
    && chmod 0755 /tmp/dumb-init

FROM alpine:3.10

RUN set -ex \
    && apk --no-cache add bash python3

COPY --from=builder /src/yggdrasil    /usr/bin/
COPY --from=builder /src/yggdrasilctl /usr/bin/
COPY --from=builder /tmp/dumb-init    /usr/bin/

ENTRYPOINT /yggdrasil/entrypoint.sh
