FROM registry.docker.oney.com/node:10-alpine

# Install Mountebank bash and jq
ENV MOUNTEBANK_VERSION=1.16.0
RUN npm install -g mountebank@${MOUNTEBANK_VERSION} \
 && npm cache clean --force 2>/dev/null \
 && rm -rf /tmp/npm* \
 && apk add --no-cache bash

# Directories and files
ARG CONTAINER_SCRIPT_DIR=/oney
ARG MOUNTEBANK_CONFIG_DIR=/mountebank/config
ARG MOUNTEBANK_CONFIG_FILE=imposters.json
ARG ONEY_CONFIG_DIR=/mountebank/oney
ENV MOUNTEBANK_CONFIG_FILE_FULL=${MOUNTEBANK_CONFIG_DIR}/${MOUNTEBANK_CONFIG_FILE}

# Copy and chmod all scripts for container
COPY src $CONTAINER_SCRIPT_DIR
RUN chmod +x $CONTAINER_SCRIPT_DIR/*

# Init container directories
RUN $CONTAINER_SCRIPT_DIR/init_container_directories.sh $MOUNTEBANK_CONFIG_DIR $ONEY_CONFIG_DIR $CONTAINER_SCRIPT_DIR

# Input configuration for imposters
COPY config $ONEY_CONFIG_DIR

# Start Mountebank with proxy imposter
CMD /oney/wrapper.sh ${MOUNTEBANK_CONFIG_FILE_FULL}
EXPOSE 2525