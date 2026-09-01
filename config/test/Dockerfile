FROM debian:testing

RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    ansible \
    python3 \
    git \
    stow \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ARG USERNAME=devuser
ARG USER_UID=1000
RUN useradd --uid $USER_UID --create-home $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
ENV HOME=/home/$USERNAME
ENV USER=$USERNAME
WORKDIR /home/$USERNAME/Devspace/dotfiles/config
