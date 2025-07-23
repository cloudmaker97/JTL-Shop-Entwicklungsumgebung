ARG BASE_IMAGE
FROM $BASE_IMAGE
USER root
# Install just from GitHub releases
RUN curl -L "https://github.com/casey/just/releases/download/1.36.0/just-1.36.0-x86_64-unknown-linux-musl.tar.gz" \
    | tar -xz -C /usr/local/bin

# Make just executable
RUN chmod +x /usr/local/bin/just