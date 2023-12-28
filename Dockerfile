ARG BUILD_FROM
FROM $BUILD_FROM

WORKDIR /rootfs

# Install APK dependencies for Alpine Linux
RUN \
  apk add --no-cache \
  python3 \
  py3-pip \
  git \
  gcc \
  libc-dev \
  libmagic

# Download WAS source code
RUN git clone https://github.com/toverainc/willow-application-server /rootfs

# Install Python dependencies for WAS
RUN pip3 install -r /rootfs/requirements.txt

# Expose ports
ENV PORT 8501
ENV PORT 8502

# Run the entrypoint script
CMD [ "/rootfs/app/entrypoint.sh" ]
