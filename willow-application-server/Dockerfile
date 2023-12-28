FROM python:3.12.0-slim-bookworm

WORKDIR /app

# Install dependencies for container
RUN apt-get update && apt-get install --no-install-recommends -y wget git gcc libc6-dev libmagic1 && rm -rf /var/lib/apt/lists/*

# Download WAS source code
RUN git clone https://github.com/toverainc/willow-application-server /app

# Download WAS admin panel UI
RUN wget https://github.com/toverainc/willow-application-server-ui/releases/latest/download/willow-application-server-ui.tar.gz
RUN mkdir -p /app/static/admin
RUN tar --directory=/app/static/admin/ --strip-components=1 -xzf willow-application-server-ui.tar.gz
RUN rm willow-application-server-ui.tar.gz

# Install Python dependencies for WAS
RUN pip install -r requirements.txt

# Expose ports
EXPOSE 8501
EXPOSE 8502

# Map volume for persistent data
VOLUME /config

# Copy and run entrypoint script
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
