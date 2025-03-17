FROM ubuntu:latest

# Install dependencies
RUN apt update && apt install -y \
    git curl build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget \
    llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev \
    libffi-dev liblzma-dev python3-openssl git libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Install pyenv
ENV HOME /root
ENV PATH "$HOME/.pyenv/bin:$HOME/.pyenv/shims:$HOME/.pyenv/plugins/pyenv-virtualenv/bin:$PATH"
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv && \
    git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
