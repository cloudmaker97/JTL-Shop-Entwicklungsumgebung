FROM debian:bookworm

# Update package repositories and install required packages
RUN apt-get update && \
    apt-get install -y \
    curl \
    wget \
    sudo \
    php \
    php-cli \
    php-mbstring \
    php-xml \
    unzip \
    docker.io

# Set the working directory
WORKDIR /workspace

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

# Install `ddev` for local development
RUN wget -O ./ddev.deb https://github.com/ddev/ddev/releases/download/v1.23.0-alpha1/ddev_1.23.0-alpha1_linux_amd64.deb
RUN apt-get install ./ddev.deb -y && rm ./ddev.deb

# Install the `just` command runner
RUN curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /bin

# Install `node` and `npm`
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Create an developer user with passwordless sudo
RUN useradd -m -s /bin/bash developer && \
    echo 'developer:developer' | chpasswd
RUN chown -R developer:developer /workspace
RUN usermod -aG sudo developer
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER developer

CMD [ "bash" ]