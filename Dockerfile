FROM alpine:3.8

ARG KUBEAUDIT_VERSION
ENV KUBEAUDIT_VERSION=$KUBEAUDIT_VERSION

RUN apk add --update ca-certificates && apk add --update -t deps curl \
    && curl -sLo kubeaudit.tgz https://github.com/Shopify/kubeaudit/releases/download/v${KUBEAUDIT_VERSION}/kubeaudit_${KUBEAUDIT_VERSION}_linux_amd64.tar.gz \
    && tar -xzf kubeaudit.tgz \
    && mv kubeaudit /usr/local/bin/ \
    && chmod +x /usr/local/bin/kubeaudit \
    && apk del --purge deps \
    && rm /var/cache/apk/*

# Placeholder, mount manifest folder here
RUN mkdir /work
WORKDIR /work

ENTRYPOINT ["/usr/local/bin/kubeaudit"]
CMD ["help"]
