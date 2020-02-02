FROM alpine:edge AS kube

ENV ARCH amd64
ENV OS Linux
ENV BIN_PATH /usr/local/bin
ENV KUBECTL_VERSION v1.17.0
ENV STERN_VERSION 1.11.0
ENV K9S_VERSION 0.13.6
ENV KIND_VERSION v0.7.0
ENV HELM_VERSION v3.0.3

RUN apk update \
    && apk upgrade \
    && apk add --no-cache \
    git \
    curl \
    gcc \
    wget \
    bash

RUN cd "$(mktemp -d)" \
    && mkdir -p ${BIN_PATH} \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/${ARCH}/kubectl \
    && chmod +x kubectl \
    && mv kubectl ${BIN_PATH}/kubectl \
    && curl -Lo stern https://github.com/wercker/stern/releases/download/$STERN_VERSION/stern_${OS}_${ARCH} \
    && chmod +x stern \
    && mv ./stern ${BIN_PATH}/stern \
    && wget https://github.com/derailed/k9s/releases/download/v0.13.6/k9s_${K9S_VERSION}_${OS}_x86_64.tar.gz \
    && tar -xvf k9s_${K9S_VERSION}_${OS}_x86_64.tar.gz \
    && rm -rf k9s_${K9S_VERSION}_${OS}_x86_64.tar.gz \
    && chmod +x k9s \
    && mv ./k9s ${BIN_PATH}/k9s \
    && curl -Lo kind https://github.com/kubernetes-sigs/kind/releases/download/${KIND_VERSION}/kind-${OS}-${ARCH} \
    && chmod +x kind \
    && mv ./kind ${BIN_PATH}/kind \
    && wget https://get.helm.sh/helm-${HELM_VERSION}-linux-${ARCH}.tar.gz \
    && tar -zxvf helm-${HELM_VERSION}-linux-${ARCH}.tar.gz \
    && mv ./linux-${ARCH}/helm ${BIN_PATH}/helm
