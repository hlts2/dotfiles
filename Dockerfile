FROM hlts2/go:latest AS go

FROM hlts2/kube:latest AS kube

FROM hlts2/dev-base:latest AS dev

ENV TZ Asia/Tokyo
ENV HOME /root
ENV GOPATH /go
ENV GOROOT /usr/local/go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
ENV NVIM_HOME $HOME/.config/nvim
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
COPY alacritty.yml $HOME/.config/alacritty/alacritty.yml

RUN git clone https://github.com/zplug/zplug $HOME/.zplug

CMD ["zsh"]
