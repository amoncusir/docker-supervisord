# Use Docker alpine base image
# See [GitHub](https://github.com/alpinelinux/docker-alpine)
#
# Digital Poet
# Aran
#

FROM alpine:3.10.3

# Domain labels ========================================================================================================

LABEL info.digitalpoet.docker-supervisord.maintainer="Aran Moncusi Ramirez <aran@digitalpoet.info>" \
      info.digitalpoet.docker-supervisord.version="1.0.0" \
      info.digitalpoet.docker-supervisord.description="Base image to build applications using Superviusord as entrypoint"

# Argument =============================================================================================================

# Environment ==========================================================================================================

ENV SUPERVISOR_VERSION 3.3.1
ENV PYTHON_DOCKER_VERSION 4.1.0
ENV KILL_SUPERD_VERSION 1.0

# Supervisord env variables
ENV LOGLEVEL warn
ENV SD_LOG_MAX_SYZE 10MB
ENV SD_LOG_BKP 10
ENV KILL_SUPERD_ARGS=""

# Install Dependencies =================================================================================================

# Install dependencies
RUN apk add --no-cache py-pip \
    && pip install docker==$PYTHON_DOCKER_VERSION \
    && pip install supervisor==$SUPERVISOR_VERSION \
    && wget https://github.com/amoncusir/kill_supervisord/releases/download/$KILL_SUPERD_VERSION/kill_superd.py -O /usr/local/bin/kill_superd.py \
    && chmod +x /usr/local/bin/* \
    && mkdir -p /var/log/supervisord

# Add Configuration Files ==============================================================================================

# Default configuration
COPY ./supervisord.conf /etc/supervisord.conf

# Add Entrypoint =======================================================================================================

ENTRYPOINT exec supervisord -c /etc/supervisord.conf
