# Comes via Home Assistant Add-On install process inherently
ARG BUILD_FROM

# Use $BUILD_FROM as base image
FROM $BUILD_FROM

# Must define args after FROM:
# https://stackoverflow.com/a/56748289/13343799
# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact

# Comes from Home Assistant Add-On config.json
ARG BUILD_VERSION

# Comes from Home Assistant Add-On install process inherently
ARG BUILD_ARCH

# Install depenendencies
# curl and tar pre-installed in base image
RUN \
  apk add --no-cache \
    python3 py3-pip

# Add shortcuts to .bashrc so if/when user enters container, they're loaded
RUN echo "#!/usr/bin/with-contenv bashio" >> /root/.bashrc
RUN echo "" >> /root/.bashrc
RUN echo "export PATH=$PATH:/pixlet" >> /root/.bashrc
RUN echo "export PIXLET_FILES_DIR=/config/files" >> /root/.bashrc

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
