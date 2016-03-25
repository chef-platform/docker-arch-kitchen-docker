FROM base/archlinux:latest
MAINTAINER Samuel Bernard "samuel.bernard@s4m.io"

# Let's run stuff
RUN \
  # First, update everything (start by keyring and pacman)
  pacman -Sy && \
  pacman -S archlinux-keyring --noconfirm && \
  pacman -S pacman --noconfirm && \
  pacman-db-upgrade && \
  pacman -Su --noconfirm && \

  # Install docker
  pacman -S docker --noconfirm && \

  # Install what is needed for building native extensions
  pacman -S gcc make --noconfirm && \

  # Install Ruby and Gems
  pacman -S ruby --noconfirm && \
  gem install test-kitchen berkshelf kitchen-docker_cli \
    --no-user-install --no-rdoc --no-ri && \

  # Time to clean
  pacman -Rs gcc make --noconfirm && \
  pacman -Scc --noconfirm

VOLUME ["/var/run/docker.sock"]
CMD ["/usr/bin/bash"]
