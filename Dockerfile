## https://www.youtube.com/watch?v=o9iZucYSkQA& -- tutorial follow up container 
FROM voidlinux/voidlinux:latest

# Fix mirror URL to reliable official mirror
RUN sed -i 's|https://alpha.de.repo.voidlinux.org|https://repo-default.voidlinux.org|g' /usr/share/xbps.d/*.conf \
    && xbps-install -Syu xbps \
    && xbps-install -Syu \
    && xbps-install -y \
       bash \
       coreutils \
       gcc \
       make \
       strace \
       lsof \
       procps-ng \
       man-pages \
       man-db \
       vim \
       nano \
       less \
       curl \
       tree \
       shadow \
       sudo \
    && xbps-remove -Ooy

# Create user 'kiskaadee' (UID 1000)
RUN useradd -m -u 1000 -s /bin/bash kiskaadee \
    && echo "kiskaadee ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && echo 'PS1="\u - void linux \w \$ "' >> /home/kiskaadee/.bashrc

# Set workspace directory
WORKDIR /home/kiskaadee/fds
RUN chown -R kiskaadee:kiskaadee /home/kiskaadee

USER kiskaadee
CMD ["/bin/bash"]
