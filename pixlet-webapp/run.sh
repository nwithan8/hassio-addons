#!/bin/bash

echo "Starting Pixlet Push..."

# Prepare file system
echo "Preparing file system..."
mkdir -p /config/files || true
cp -r /tmp/*.star /config/files || true

# Add shortcuts to .bashrc so if/when user enters container, they're loaded
echo "#!/bin/bash" >> /root/.bashrc
echo "" >> /root/.bashrc
echo "export PATH=$PATH:/pixlet" >> /root/.bashrc
echo "export PIXLET_FILES_DIR=/config/files" >> /root/.bashrc

# Start flask server
/pixlet/pixlet serve /config/files/hello_world.star -i 0.0.0.0
