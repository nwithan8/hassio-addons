FROM python:3.12.0-slim-bookworm

# Comes from Home Assistant Add-On config.json
ARG BUILD_VERSION=0.28.0

# Comes from Home Assistant Add-On install process inherently
ARG BUILD_ARCH=amd64

# Install dependencies for container
RUN apt-get update && apt-get install --no-install-recommends -y curl tar && rm -rf /var/lib/apt/lists/*

# Copy Python server files into container
COPY /server.py /server/
COPY /requirements.txt /server/
RUN chmod a+x /server/server.py

# Install pixlet binary
RUN mkdir /pixlet
RUN echo "Pixlet version: ${BUILD_VERSION}, target arch: ${BUILD_ARCH}"
RUN curl -sSLf -o /pixlet/tmp "https://github.com/tidbyt/pixlet/releases/download/v${BUILD_VERSION}/pixlet_${BUILD_VERSION}_linux_${BUILD_ARCH}.tar.gz"
RUN tar -zxf /pixlet/tmp --directory /pixlet
RUN chmod a+x /pixlet/pixlet
RUN rm /pixlet/tmp

# Install Python dependencies for server
RUN pip3 install -r /server/requirements.txt

# Make the temporary storage directory for flask
RUN mkdir /tmp/flask

# Map volume for persistent data
VOLUME /config

# Copy and run entrypoint script
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
