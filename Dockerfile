# Using centos because fedora is not supported by synk
FROM docker.io/library/centos:centos8.3.2011

# Update Fedora & add `dev` user
RUN dnf install -y epel-release && dnf update -y && dnf clean all -y && useradd dev

# Useful tools
RUN dnf install -y jq openssl which wget htop && dnf clean all

# Install Snapd: https://snapcraft.io/docs/installing-snap-on-centos
RUN dnf install -y epel-release && dnf install -y snapd && dnf clean all && ln -s /var/lib/snapd/snap /snap

# ASDF Dependencies: https://asdf-vm.com/#/core-manage-asdf
RUN dnf install -y curl git unzip && dnf clean all

# Python Build Dependencies: https://github.com/pyenv/pyenv/wiki#suggested-build-environment
RUN dnf install -y make gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz && dnf clean all

# Homebrew Dependencies: https://docs.brew.sh/Homebrew-on-Linux#fedora-centos-or-red-hat
RUN dnf group install -y 'Development Tools' && dnf install -y curl file git ruby && dnf clean all && mkdir -p /home/linuxbrew && chown -R dev /home/linuxbrew

# Install Docker
RUN dnf install -y 'dnf-command(config-manager)' && dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && dnf install -y docker-ce docker-ce-cli containerd.io && dnf clean all

# Install Podman: https://podman.io/getting-started/installation#linux-distributions
# RUN dnf install -y podman && dnf clean all

# Nix Dependencies:
RUN mkdir -m 0755 /nix && chown dev /nix && dnf install -y sudo && dnf clean all

# Add System files
COPY --chown=root:root files/etc/ /etc/
COPY --chown=root:root files/usr/ /usr/

USER dev
SHELL ["/bin/bash", "-c", "-l"]

# Install ASDF: https://asdf-vm.com/#/core-manage-asdf
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0

# Install Nix: https://nixos.org/manual/nix/stable/#sect-single-user-installation
RUN /bin/bash -c "$(curl -fsSL https://nixos.org/nix/install) --no-daemon"
RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
RUN nix-channel --update

# USER root
# RUN dnf remove -y sudo
# USER dev

# Install Homebrew: https://brew.sh/
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install useful tools
RUN nix-env -iA nixpkgs.direnv

# Add User files
COPY --chown=dev:dev files/home/dev/ /home/dev/

WORKDIR /home/dev
