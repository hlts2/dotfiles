FROM hlts2/go:latest AS go

FROM hlts2/kube:latest AS kube

FROM hlts2/dev-base:latest AS dev

FROM dev

LABEL maintainer="hlts2 <hiroto.funakoshi.hiroto@gmail.com>"

ENV TZ Asia/Tokyo
ENV HOME /root
ENV XDG_CONFIG_HOME $HOME/.config
ENV GOPATH /go
ENV GOROOT /usr/local/go
ENV GOBIN $GOPATH/bin
ENV PATH $GOBIN:/usr/local/go/bin:$PATH
ENV LIBRARY_PATH /usr/local/lib:$LIBRARY_PATH
ENV NVIM_HOME $XDG_CONFIG_HOME/nvim
ENV VIM_PLUG_HOME $NVIM_HOME/plugged/vim-plug
ENV ZPLUG_HOME $HOME/.zplug
ENV SHELL /bin/zsh

COPY --from=go /usr/local/go/bin $GOROOT/bin
COPY --from=go /usr/local/go/src $GOROOT/src
COPY --from=go /usr/local/go/lib $GOROOT/lib
COPY --from=go /usr/local/go/pkg $GOROOT/pkg
COPY --from=go /usr/local/go/misc $GOROOT/misc
COPY --from=go /go/bin $GOPATH/bin

COPY --from=kube /usr/local/bin/helm /usr/bin/helm
COPY --from=kube /usr/local/bin/k9s /usr/bin/k9s
COPY --from=kube /usr/local/bin/kind /usr/bin/kind
COPY --from=kube /usr/local/bin/kubectl /usr/bin/kubectl
COPY --from=kube /usr/local/bin/stern /usr/bin/stern

COPY gitconfig $HOME/.gitconfig
COPY gitattributes $HOME/.gitattributes
COPY gitcommit-template $HOME/.gitcommit-template
COPY gitignore $HOME/.gitignore
COPY tmux.conf $HOME/.tmux.conf
COPY zshrc $HOME/.zshrc
COPY vimrc $(HOME)/.vimrc
COPY init.vim $NVIM_HOME/init.vim
COPY coc-settings.json $NVIM_HOME/coc-settings.json

RUN rm -rf $VIM_PLUG_HOME/autoload \
    && git clone https://github.com/junegunn/vim-plug.git $VIM_PLUG_HOME/autoload

RUN yarn global add https://github.com/neoclide/coc.nvim --prefix /usr/local

RUN git clone https://github.com/zplug/zplug $ZPLUG_HOME \
    && rm -rf $HOME/.cache \
    && rm -rf $HOME/.npm/_cacache \
    && rm -rf /usr/local/share/.cache \
    && rm -rf /tmp/*
    && git clone https://github.com/zsh-users/zsh-autosuggestions $ZPLUG_HOME/repos/zsh-users/zsh-autosuggestions \
    && git clone https://github.com/zsh-users/zsh-completions $ZPLUG_HOME/repos/zsh-users/zsh-completions \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZPLUG_HOME/repos/zsh-users/zsh-syntax-highlighting \
    && git clone https://github.com/zsh-users/zsh-history-substring-search $ZPLUG_HOME/repos/zsh-users/zsh-history-substring-search \
    && git clone https://github.com/greymd/tmux-xpanes $ZPLUG_HOME/repos/greymd/tmux-xpanes \
    && git clone https://github.com/b4b4r07/enhancd.git $ZPLUG_HOME/repos/b4b4r07/enhancd \
    && git clone https://github.com/supercrabtree/k.git $ZPLUG_HOME/repos/supercrabtree/k


WORKDIR /go/src

CMD ["zsh"]
