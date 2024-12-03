FROM python:3.12-slim-bookworm
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

ENV SSH_KEY=""
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN dpkg --add-architecture i386

RUN apt-get update && apt-get install -y \
    wget \
    xvfb \
    coreutils

RUN mkdir -pm755 /etc/apt/keyrings
RUN wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources
RUN apt install -y --install-recommends wine

RUN apt install -y ssh git
# Download public key for github.com
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

# Clone private repositories
COPY ./check_compile.sh /opt/check_compile
RUN chmod +x /opt/check_compile
RUN ln -s /opt/check_compile /usr/local/bin/check_compile


ENTRYPOINT ["/entrypoint.sh"]
