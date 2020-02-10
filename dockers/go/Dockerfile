FROM golang:1.13-alpine AS go-base

RUN apk update \
    && apk upgrade \
    && apk add --no-cache \
    git \
    curl \
    gcc \
    wget

FROM go-base AS asmfmt
RUN GO111MODULE=on go get -u  \
    github.com/klauspost/asmfmt/cmd/asmfmt

FROM go-base AS dlv
RUN GO111MODULE=on go get -u  \
    github.com/go-delve/delve/cmd/dlv

FROM go-base AS errcheck
RUN GO111MODULE=on go get -u  \
    github.com/kisielk/errcheck

FROM go-base AS fillstruct
RUN GO111MODULE=on go get -u  \
    github.com/davidrjenni/reftools/cmd/fillstruct

FROM go-base AS gocode
RUN GO111MODULE=on go get -u  \
    github.com/mdempsky/gocode

FROM go-base AS gocode-gomod
RUN GO111MODULE=on go get -u  \
    github.com/stamblerre/gocode

FROM go-base AS godef
RUN GO111MODULE=on go get -u  \
    github.com/rogpeppe/godef

FROM go-base AS gogetdoc
RUN GO111MODULE=on go get -u  \
    github.com/zmb3/gogetdoc

FROM go-base AS goimports
RUN GO111MODULE=on go get -u  \
    golang.org/x/tools/cmd/goimports

FROM go-base AS golint
RUN GO111MODULE=on go get -u  \
    golang.org/x/lint/golint

FROM go-base AS gopls
RUN GO111MODULE=on go get \
    golang.org/x/tools/gopls@latest

FROM go-base AS golangci-lint
RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | \
    sh -s -- -b $(go env GOPATH)/bin v1.23.1

FROM go-base AS gomodifytags
RUN GO111MODULE=on go get \
    github.com/fatih/gomodifytags

FROM go-base AS gorename
RUN GO111MODULE=on go get \
    golang.org/x/tools/cmd/gorename

FROM go-base AS gotags
RUN GO111MODULE=on go get \
    github.com/jstemmer/gotags

FROM go-base AS guru
RUN GO111MODULE=on go get \
    golang.org/x/tools/cmd/guru

FROM go-base AS impl
RUN GO111MODULE=on go get \
    github.com/josharian/impl

FROM go-base AS keyify
RUN GO111MODULE=on go get \
    honnef.co/go/tools/cmd/keyify

FROM go-base AS motion
RUN GO111MODULE=on go get \
    github.com/fatih/motion

FROM go-base AS iferr
RUN GO111MODULE=on go get \
    github.com/koron/iferr

FROM go-base AS gojson
RUN GO111MODULE=on go get -u  \
    github.com/ChimeraCoder/gojson/gojson

FROM go-base AS gotests
RUN GO111MODULE=on go get -u  \
    github.com/cweill/gotests/gotests

FROM go-base AS chidley
RUN GO111MODULE=on go get -u  \
    github.com/gnewton/chidley

FROM go-base AS ghq
RUN GO111MODULE=on go get -u  \
    github.com/x-motemen/ghq

FROM go-base AS efm
RUN GO111MODULE=on go get -u  \
    github.com/mattn/efm-langserver

FROM go-base AS goreturns
RUN GO111MODULE=on go get -u  \
    sourcegraph.com/sqs/goreturns

FROM go-base AS go-module-off-base
RUN GO111MODULE=off go get -u \
    github.com/gohugoio/hugo \
    github.com/uber/prototool/cmd/prototool

FROM go-module-off-base AS hugo
RUN cd $GOPATH/src/github.com/gohugoio/hugo \
    && GO111MODULE=on go build -o $GOPATH/bin/hugo main.go

FROM go-module-off-base AS prototool
RUN cd $GOPATH/src/github.com/uber/prototool/cmd/prototool \
    && GO111MODULE=on go build -o $GOPATH/bin/prototool

FROM go-base AS go

COPY --from=asmfmt $GOPATH/bin/asmfmt $GOPATH/bin/asmfmt
COPY --from=dlv $GOPATH/bin/dlv $GOPATH/bin/dlv
COPY --from=errcheck $GOPATH/bin/errcheck $GOPATH/bin/errcheck
COPY --from=fillstruct $GOPATH/bin/fillstruct $GOPATH/bin/fillstruct
COPY --from=gocode $GOPATH/bin/gocode $GOPATH/bin/gocode
COPY --from=gocode-gomod $GOPATH/bin/gocode $GOPATH/bin/gocode
COPY --from=godef $GOPATH/bin/godef $GOPATH/bin/godef
COPY --from=gogetdoc $GOPATH/bin/gogetdoc $GOPATH/bin/gogetdoc
COPY --from=goimports $GOPATH/bin/goimports $GOPATH/bin/goimports
COPY --from=golint $GOPATH/bin/golint $GOPATH/bin/golint
COPY --from=gopls $GOPATH/bin/gopls $GOPATH/bin/gopls
COPY --from=golangci-lint $GOPATH/bin/golangci-lint $GOPATH/bin/golangci-lint
COPY --from=gomodifytags $GOPATH/bin/gomodifytags $GOPATH/bin/gomodifytags
COPY --from=gorename $GOPATH/bin/gorename $GOPATH/bin/gorename
COPY --from=gotags $GOPATH/bin/gotags $GOPATH/bin/gotags
COPY --from=guru $GOPATH/bin/guru $GOPATH/bin/guru
COPY --from=impl $GOPATH/bin/impl $GOPATH/bin/impl
COPY --from=keyify $GOPATH/bin/keyify $GOPATH/bin/keyify
COPY --from=motion $GOPATH/bin/motion $GOPATH/bin/motion
COPY --from=iferr $GOPATH/bin/iferr $GOPATH/bin/iferr
COPY --from=gojson $GOPATH/bin/gojson $GOPATH/bin/gojson
COPY --from=gotests $GOPATH/bin/gotests $GOPATH/bin/gotests
COPY --from=chidley $GOPATH/bin/chidley $GOPATH/bin/chidley
COPY --from=ghq $GOPATH/bin/ghq $GOPATH/bin/ghq
COPY --from=efm $GOPATH/bin/efm-langserver $GOPATH/bin/efm-langserver
COPY --from=goreturns $GOPATH/bin/goreturns $GOPATH/bin/goreturns
COPY --from=prototool $GOPATH/bin/prototool $GOPATH/bin/prototool
COPY --from=hugo $GOPATH/bin/hugo $GOPATH/bin/hugo
