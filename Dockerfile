FROM ubuntu:latest

ARG USERNAME=david

RUN apt update && apt install -y curl zsh git sudo supervisor

RUN if [ $(arch) = "amd64" ]; then \
      curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb -o cloudflared.deb; \
    else \
      curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64.deb -o cloudflared.deb; \
    fi && \
    dpkg -i cloudflared.deb

RUN groupadd wheel && groupadd docker
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN useradd -m -s /usr/bin/zsh -G sudo,docker,wheel $USERNAME
RUN usermod --shell /usr/bin/zsh root

RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes

USER $USERNAME
WORKDIR /home/$USERNAME

RUN mkdir -p .config/code-server
COPY shell/ .
COPY private/ .

RUN curl -fsSL https://code-server.dev/install.sh | sh

RUN mkdir -p /home/$USERNAME/.local/share/code-server/User/
COPY code/settings.json /home/$USERNAME/.local/share/code-server/User/settings.json

COPY code/code_extensions.txt .
RUN cat code_extensions.txt | xargs -L 1 code-server --install-extension

COPY code/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
