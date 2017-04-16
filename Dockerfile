FROM jenkins:alpine

MAINTAINER Jared De La Cruz <jared@jareddlc.com>

ARG USER_JENKINS=jenkins
ARG USER_ROOT=root
ARG GROUP_DOCKER=docker
ARG GROUP_DOCKER_GID=1001

# Switch to root
USER ${USER_ROOT}

# Create docker group and add user jenkins to the group
RUN addgroup -g ${GROUP_DOCKER_GID} ${GROUP_DOCKER} \
	&& addgroup ${USER_JENKINS} ${GROUP_DOCKER}

# Install docker
# From https://github.com/docker-library/docker/blob/91d454d113abfb2328c88bbd48b81e495605e809/17.03/Dockerfile
RUN apk add --no-cache \
		ca-certificates \
		curl \
		openssl \
		sudo

ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 17.03.1-ce
ENV DOCKER_SHA256 820d13b5699b5df63f7032c8517a5f118a44e2be548dd03271a86656a544af55

RUN set -x \
	&& curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
	&& echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
	&& tar -xzvf docker.tgz \
	&& mv docker/* /usr/local/bin/ \
	&& rmdir docker \
	&& rm docker.tgz \
	&& docker -v

# Add user jenkins to list of sudoers
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch to user jenkins
USER ${USER_JENKINS}

COPY docker-socket.sh /

ENTRYPOINT ["/docker-socket.sh"]
