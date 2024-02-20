FROM alpine:edge AS kube-base

ENV ARCH amd64
ENV OS linux
ENV OS_UP Linux
ENV BIN_PATH /usr/local/bin
ENV KUBECTL_VERSION v1.19.12
ENV STERN_VERSION 1.11.0
ENV K9S_VERSION v0.24.10
ENV KIND_VERSION v0.11.1
ENV HELM_VERSION v3.6.1
ENV HELMFILE_VERSION v0.139.9
ENV KUBECTX_VERSION v0.9.3
ENV KUBENS_VERSION v0.9.3

RUN apk update \
    && apk upgrade \
    && apk add --no-cache \
    git \
    curl \
    gcc \
    wget \
    bash

FROM kube-base AS kubectl
RUN mkdir -p ${BIN_PATH} \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/${OS}/${ARCH}/kubectl \
    && chmod +x kubectl \
    && mv kubectl ${BIN_PATH}/kubectl

FROM kube-base AS stern
RUN mkdir -p ${BIN_PATH} \
    && curl -Lo stern https://github.com/wercker/stern/releases/download/$STERN_VERSION/stern_${OS}_${ARCH} \
    && chmod +x stern \
    && mv ./stern ${BIN_PATH}/stern

FROM kube-base AS k9s
RUN mkdir -p ${BIN_PATH} \
    && wget https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_${K9S_VERSION}_${OS_UP}_x86_64.tar.gz \
    && tar -xvf k9s_${K9S_VERSION}_${OS_UP}_x86_64.tar.gz \
    && chmod +x k9s \
    && mv ./k9s ${BIN_PATH}/k9s

FROM kube-base AS kind
RUN mkdir -p ${BIN_PATH} \
    && curl -Lo kind https://github.com/kubernetes-sigs/kind/releases/download/${KIND_VERSION}/kind-${OS}-${ARCH} \
    && chmod +x kind \
    && mv ./kind ${BIN_PATH}/kind

FROM kube-base AS helm
RUN mkdir -p ${BIN_PATH} \
    && wget https://get.helm.sh/helm-${HELM_VERSION}-${OS}-${ARCH}.tar.gz \
    && tar -zxvf helm-${HELM_VERSION}-${OS}-${ARCH}.tar.gz \
    && mv ./linux-${ARCH}/helm ${BIN_PATH}/helm

FROM kube-base AS helmfile
RUN mkdir -p ${BIN_PATH} \
    && curl -Lo helmfile https://github.com/roboll/helmfile/releases/download/${HELMFILE_VERSION}/helmfile_${OS}_${ARCH} \
    && chmod +x helmfile \
    && mv ./helmfile ${BIN_PATH}/helmfile

FROM kube-base AS kustomize
RUN mkdir -p ${BIN_PATH} \
    && curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash \
    && mv ./kustomize ${BIN_PATH}/kustomize

FROM kube-base AS kubectx
RUN mkdir -p ${BIN_PATH} \
    && wget https://github.com/ahmetb/kubectx/releases/download/${KUBECTX_VERSION}/kubectx_${KUBECTX_VERSION}_${OS}_x86_64.tar.gz \
    && tar -xvf kubectx_${KUBECTX_VERSION}_${OS}_x86_64.tar.gz \
    && mv ./kubectx ${BIN_PATH}/kubectx

FROM kube-base AS kubens
RUN mkdir -p ${BIN_PATH} \
    && wget https://github.com/ahmetb/kubectx/releases/download/${KUBENS_VERSION}/kubens_${KUBENS_VERSION}_${OS}_x86_64.tar.gz \
    && tar -xvf kubens_${KUBENS_VERSION}_${OS}_x86_64.tar.gz \
    && mv ./kubens ${BIN_PATH}/kubens

FROM kube-base AS kube

COPY --from=kubectl ${BIN_PATH}/kubectl ${BIN_PATH}/kubectl
COPY --from=stern ${BIN_PATH}/stern ${BIN_PATH}/stern
COPY --from=k9s ${BIN_PATH}/k9s ${BIN_PATH}/k9s
COPY --from=kind ${BIN_PATH}/kind ${BIN_PATH}/kind
COPY --from=helm ${BIN_PATH}/helm ${BIN_PATH}/helm
COPY --from=helmfile ${BIN_PATH}/helmfile ${BIN_PATH}/helmfile
COPY --from=kustomize ${BIN_PATH}/kustomize ${BIN_PATH}/kustomize
COPY --from=kubectx ${BIN_PATH}/kubectx ${BIN_PATH}/kubectx
COPY --from=kubens ${BIN_PATH}/kubens ${BIN_PATH}/kubens
