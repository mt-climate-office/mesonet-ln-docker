FROM python:3.12-slim-bookworm
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

ENV SSH_KEY=""
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Install some tools required for creating the image
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		curl \
		unzip \
		ca-certificates \
		xvfb \
        git

# Install wine and related packages
RUN dpkg --add-architecture i386 \
		&& apt-get update \
		&& apt-get install -y \
				wine-stable \
				winetricks \
				wine32 \
				libgl1-mesa-glx:i386 \
		&& rm -rf /var/lib/apt/lists/*

# Download public key for github.com
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

# Clone private repositories
COPY ./check_compile.sh /opt/check_compile
RUN chmod +x /opt/check_compile
RUN ln -s /opt/check_compile /usr/local/bin/check_compile


ENTRYPOINT ["/entrypoint.sh"]
