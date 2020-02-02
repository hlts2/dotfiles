FROM ubuntu:devel AS env

ENV NGT_VERSION 1.8.1
ENV TENSORFLOW_C_VERSION 1.13.1
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y \
    clang \
    cmake \
    ctags \
    curl \
    g++ \
    gauche \
    gawk \
    gcc \
    gem \
    git \
    gnupg \
    graphviz \
    hdf5-helpers \
    hdf5-tools \
    jq \
    libhdf5-dev \
    locales \
    make \
    musl-dev \
    neovim \
    nodejs \
    npm \
    openssh-client \
    openssh-server \
    openssl \
    perl \
    python-pip \
    python3 \
    python3-pip \
    rlwrap \
    sed \
    tar \
    tmux \
    tig \
    tzdata \
    unzip \
    wget \
    zip \
    zsh

RUN pip2 install --upgrade pip neovim \
    && pip3 install --upgrade pip neovim \
    && npm config set user root \
    && npm install -g neovim

RUN pip3 install --upgrade pip \
    ranger-fm \
    thefuck httpie \
    python-language-server \
    vim-vint \
    grpcio-tools 

RUN npm install -g \
    dockerfile-language-server-nodejs \
    bash-language-server \
    resume-cli \
    markdownlint-cli \
    typescript \
    typescript-language-server \

RUN gem install neovim

RUN curl -Lo ngt.tar.gz https://github.com/yahoojapan/NGT/archive/v${NGT_VERSION}.tar.gz \
    && tar zxf ngt.tar.gz -C /tmp \
    && rm -rf ngt.tar.gz \
    && cd /tmp/NGT-${NGT_VERSION} \
    && cmake . \
    && make -j -C /tmp/NGT-${NGT_VERSION} \
    && make install -C /tmp/NGT-${NGT_VERSION}

RUN curl -LO https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-linux-x86_64-${TENSORFLOW_C_VERSION}.tar.gz \
	&& tar -C /usr/local -xzf libtensorflow-cpu-linux-x86_64-${TENSORFLOW_C_VERSION}.tar.gz \
	&& rm -f libtensorflow-cpu-linux-x86_64-${TENSORFLOW_C_VERSION}.tar.gz \
	&& ldconfig
