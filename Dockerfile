# Using centos because fedora is not supported by synk
FROM docker.io/library/centos:centos8.3.2011

# Update Fedora & add `dev` user
RUN dnf update -y && dnf clean all -y && useradd dev

# Install Snapd: https://snapcraft.io/docs/installing-snap-on-centos
RUN dnf install -y epel-release && dnf upgrade -y && dnf install -y snapd && dnf clean all -y && ln -s /var/lib/snapd/snap /snap

# ASDF Dependencies: https://asdf-vm.com/#/core-manage-asdf
RUN dnf install -y curl git which && dnf clean all -y

# Homebrew Dependencies: https://docs.brew.sh/Homebrew-on-Linux#fedora-centos-or-red-hat
RUN yum groupinstall -y 'Development Tools' && yum install -y curl file git ruby && yum clean all -y && mkdir -p /home/linuxbrew && chown -R dev /home/linuxbrew

# Nix Dependencies:
RUN mkdir -m 0755 /nix && chown dev /nix && dnf install -y sudo

# Install Docker

# Install Podman

USER dev

# Install Nix
RUN /bin/bash -c "$(curl -fsSL https://nixos.org/nix/install) --no-daemon"
# RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
# RUN nix-channel --update

# USER root
# RUN dnf remove -y sudo

USER dev
# Install ASDF: https://asdf-vm.com/#/core-manage-asdf
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0

# Install Homebrew: https://brew.sh/
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

COPY --chown=dev files/home/dev/.profile /home/dev/.profile
COPY --chown=dev files/home/dev/.profile /home/dev/.bash_profile
COPY --chown=dev files/home/dev/.profile /home/dev/.bashrc

WORKDIR /home/dev