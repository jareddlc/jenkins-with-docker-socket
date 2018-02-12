FROM jenkins/jenkins:alpine

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
# From https://github.com/docker-library/docker/blob/5a539ed6ab5d91c5d8ccf0ccbc583500740199a2/17.09/Dockerfile

ENV DOCKER_CHANNEL stable
ENV DOCKER_BUCKET download.docker.com
ENV DOCKER_VERSION 17.12.0-ce
ENV DOCKER_ARCH x86_64
ENV DOCKER_SHA256 692e1c72937f6214b1038def84463018d8e320c8eaf8530546c84c2f8f9c767d

RUN set -ex; \
	apk add --no-cache sudo; \
	apk add --no-cache --virtual .fetch-deps \
		curl \
		tar \
	&& curl -fSL -o docker.tgz "https://${DOCKER_BUCKET}/linux/static/${DOCKER_CHANNEL}/${DOCKER_ARCH}/docker-${DOCKER_VERSION}.tgz" \
	&& echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
	&& tar --extract --file docker.tgz --strip-components 1 --directory /usr/local/bin/ \
	&& rm docker.tgz \
	&& apk del .fetch-deps \
	&& dockerd -v \
	&& docker -v

# Add user jenkins to list of sudoers
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch to user jenkins
USER ${USER_JENKINS}

COPY docker-socket.sh /

ENTRYPOINT ["/docker-socket.sh"]
