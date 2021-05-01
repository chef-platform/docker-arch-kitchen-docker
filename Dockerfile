FROM archlinux:latest
MAINTAINER Samuel Bernard "samuel.bernard@gmail.com"

# WORKAROUND for glibc 2.33 and old Docker
# See https://github.com/actions/virtual-environments/issues/2658
# Thanks to https://github.com/lxqt/lxqt-panel/pull/1562
RUN patched_glibc=glibc-linux4-2.33-4-x86_64.pkg.tar.zst && \
    curl -LO "https://repo.archlinuxcn.org/x86_64/$patched_glibc" && \
    bsdtar -C / -xvf "$patched_glibc"

# Let's run stuff
RUN \
  # First, update everything (start by keyring and pacman)
  pacman -Sy && \
  pacman -S archlinux-keyring --noconfirm && \
  pacman -S pacman --noconfirm && \
  pacman-db-upgrade && \
  pacman -Su --noconfirm && \
  # Install Git
  pacman -S git --noconfirm && \
  # Install Docker
  pacman -S docker --noconfirm && \
  # Install kmod for Docker
  pacman -S kmod --noconfirm && \
  # It quite common to need to interact with S3
  pacman -S s3cmd --noconfirm && \
  # Install what is needed for building native extensions
  pacman -S gcc make sed awk gzip grep autoconf automake --noconfirm && \
  # Install useful tools
  pacman -S vim tree iproute2 inetutils openssh --noconfirm && \
  # Install Ruby and Gems
  pacman -S ruby --noconfirm && \
  gem install test-kitchen berkshelf kitchen-docker_cli bundler \
    --no-user-install --no-document && \
  # Install Foodcritic and Rubocop
  gem install foodcritic rubocop --no-user-install --no-document && \
  # Generate locale en_US (workaround for a strange bug in berkshelf)
  echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
  locale-gen && \
  # Time to clean
  pacman -Scc --noconfirm

ENV LANG=en_US.UTF-8
CMD ["/usr/bin/bash"]
