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
#ENV DOCKERIZE_VERSION v0.6.1

# Supervisord env variables
ENV LOGLEVEL = warn
ENV SD_LOG_MAX_SYZE = 10MB
ENV SD_LOG_BKP = 10

# Install Dependencies =================================================================================================

# Install python and supervisord
RUN apk add --no-cache py-pip \
    && pip install docker==$PYTHON_DOCKER_VERSION \
    && pip install supervisor==$SUPERVISOR_VERSION

#    wget -q0- https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz | tar xzvf - -C /usr/local/bin &&\

#    tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz &&\
#    rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Add Configuration Files ==============================================================================================

# Default configuration
COPY ./supervisord.conf /etc/supervisord.conf

# Add binaries and utilities
COPY ./kill_superd.py /usr/local/bin/kill_superd.py

# Add Entrypoint =======================================================================================================

ENTRYPOINT exec supervisord -c /etc/supervisord.conf
