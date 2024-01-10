ARG TYPESENSE_VER="0.25.2"

FROM python:3.12.0-slim-bookworm
ARG TYPESENSE_VER

# Install typesense-server with md5sum workaround
ARG BUILD_ARCH
# Set BUILD_ARCH to arm64 if aarch64
RUN if [ "$BUILD_ARCH" = "aarch64" ]; then export BUILD_ARCH="arm64"; fi

# Install dependencies for container
RUN apt-get update && apt-get install --no-install-recommends -y wget jq git coreutils curl && rm -rf /var/lib/apt/lists/*

# Download typesense-server
WORKDIR /usr/local/sbin
RUN curl -o typesense-server.tar.gz https://dl.typesense.org/releases/${TYPESENSE_VER}/typesense-server-${TYPESENSE_VER}-linux-${BUILD_ARCH}.tar.gz && \
    tar xf typesense-server.tar.gz && echo -n '  typesense-server' >> typesense-server.md5.txt \
    md5sum -c typesense-server.md5.txt && rm typesense-server*.*

# Switch back to app directory
WORKDIR /app

# Define WAS versions
ARG WAC_BRANCH=main

# Download WAS source code (checkout specified tag)
RUN git clone https://github.com/toverainc/willow-autocorrect /app
RUN git fetch --all --tags
RUN git checkout $WAC_BRANCH

# Install Python dependencies for WAS
RUN pip install -r requirements.txt

# Expose ports
EXPOSE 9241

# Map volume for persistent data
VOLUME /config

# Copy and run entrypoint script
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
