# Download and extract iVentoy
FROM gremf/alpine-tools:latest AS init
ARG IVENTOY
WORKDIR /iventoy
RUN echo "Downloading version: ${IVENTOY}" && \
    [ -z "${IVENTOY}" ] && echo "Error: IVENTOY is not set" && exit 1 || true && \
    wget https://github.com/ventoy/PXE/releases/download/v${IVENTOY}/iventoy-${IVENTOY}-linux-free.tar.gz && \
    tar -xvf *.tar.gz && \
    rm -rf iventoy-${IVENTOY}-linux.tar.gz && \
    mv iventoy-${IVENTOY} iventoy

# Build image
FROM ubuntu:24.04
ENV AUTO_START_PXE=true
WORKDIR /app

COPY --from=init /iventoy/iventoy /app
RUN chmod +x /app/iventoy.sh

# Copy iventoy.dat to temporary folder for first run
COPY --from=init /iventoy/iventoy/data/iventoy.dat /app/data_default/iventoy.dat

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose ports
# Web UI
EXPOSE 26000/tcp

# HTTP server
EXPOSE 16000/tcp

# TFTP server
EXPOSE 69/udp

# Default command
CMD ["/entrypoint.sh"]
