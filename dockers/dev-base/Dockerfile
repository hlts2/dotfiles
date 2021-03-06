FROM ubuntu:devel AS env

# ENV NGT_VERSION 1.37.7
ENV NGT_VERSION 1.13.6
ENV BAT_VERSION 0.18.1
ENV TENSORFLOW_C_VERSION 2.4.0
ENV DEBIAN_FRONTEND noninteractive
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/lib:/usr/local/lib:/lib:/lib64:/var/lib:/usr/local/go/lib:/usr/lib/node_modules/lib

RUN echo $'/lib\n\
/lib64\n\
/var/lib\n\
/usr/lib\n\
/usr/local/lib\n\
/usr/local/go/lib\n\
/usr/lib/node_modules/lib' > /etc/ld.so.conf.d/usr-local-lib.conf \
    && echo $(ldconfig)

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y \
    clang \
    cmake \
    curl \
    docker.io \
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
    python3 \
    python3-pip \
    ruby-dev \
    rlwrap \
    sed \
    sudo \
    tar \
    tmux \
    tig \
    tzdata \
    unzip \
    wget \
    zip \
    zsh

RUN apt-get install -y software-properties-common \
   && apt-add-repository universe \
   && apt-get update -y \
   && apt-get install -y python2

RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py && python2 get-pip.py

RUN pip2 install --upgrade pip neovim \
    && pip3 install --upgrade pip neovim \
    && npm config set user root \
    && npm install -g neovim

RUN pip3 install --upgrade pip \
    ranger-fm \
    thefuck \
    httpie \
    python-language-server \
    vim-vint \
    grpcio-tools

RUN npm install -g \
    yarn \
    dockerfile-language-server-nodejs \
    bash-language-server

RUN gem install neovim

WORKDIR /tmp

 RUN curl -Lo ngt.tar.gz https://github.com/yahoojapan/NGT/archive/refs/tags/v${NGT_VERSION}.tar.gz \
    && tar zxf ngt.tar.gz \
    && rm -rf ngt.tar.gz \
    && cd NGT-${NGT_VERSION} \
    && cmake . \
    && make -j -C /tmp/NGT-${NGT_VERSION} \
    && make install -C /tmp/NGT-${NGT_VERSION}

RUN git clone https://github.com/soimort/translate-shell \
    && cd translate-shell \
    && make

RUN wget https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat-v${BAT_VERSION}-i686-unknown-linux-gnu.tar.gz \
    && tar -zxvf bat-v${BAT_VERSION}-i686-unknown-linux-gnu.tar.gz \
    && cd bat-v${BAT_VERSION}-i686-unknown-linux-gnu \
    && chmod +x bat \
    && mv bat /usr/local/bin/bat

RUN curl -LO https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-linux-x86_64-${TENSORFLOW_C_VERSION}.tar.gz \
	&& tar -C /usr/local -xzf libtensorflow-cpu-linux-x86_64-${TENSORFLOW_C_VERSION}.tar.gz \
	&& rm -f libtensorflow-cpu-linux-x86_64-${TENSORFLOW_C_VERSION}.tar.gz \
	&& ldconfig

RUN rm -rf /tmp/*
