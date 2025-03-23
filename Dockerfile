FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends make build-essential tar \
    libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget \
    ca-certificates curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libxml2-dev \
    libxmlsec1-dev libffi-dev liblzma-dev mecab-ipadic-utf8 git vim bc unzip \
    subversion perl zip locales netbase pkg-config zlib1g-dev python3-openssl openssl\
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install pyenv
ENV HOME=/root
ENV PATH="$HOME/.pyenv/bin:$HOME/.pyenv/shims:$HOME/.pyenv/plugins/pyenv-virtualenv/bin:$PATH"
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv && \
    git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
