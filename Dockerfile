FROM fedora:33

RUN dnf update -y

RUN dnf install -y fish git curl wget direnv htop

# ASDF Installation
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0

