# jenkins-with-docker-socket
Official Jenkins image with Docker socket

[![Docker Build](https://img.shields.io/docker/build/jareddlc/jenkins-with-docker-socket.svg)](https://hub.docker.com/r/jareddlc/jenkins-with-docker-socket/)
[![Docker Stars](https://img.shields.io/docker/stars/jareddlc/jenkins-with-docker-socket.svg)](https://hub.docker.com/r/jareddlc/jenkins-with-docker-socket/)
[![Docker Pulls](https://img.shields.io/docker/pulls/jareddlc/jenkins-with-docker-socket.svg)](https://hub.docker.com/r/jareddlc/jenkins-with-docker-socket/)
[![Docker Layers](https://shields.beevelop.com/docker/image/layers/jareddlc/jenkins-with-docker-socket/latest.svg)](https://hub.docker.com/r/jareddlc/jenkins-with-docker-socket/)
[![Docker Size](https://shields.beevelop.com/docker/image/image-size/jareddlc/jenkins-with-docker-socket/latest.svg)](https://hub.docker.com/r/jareddlc/jenkins-with-docker-socket/)
[![Docker Automated](https://img.shields.io/docker/automated/jareddlc/jenkins-with-docker-socket.svg)](https://hub.docker.com/r/jareddlc/jenkins-with-docker-socket/)
<!-- [![Docker Layers](https://img.shields.io/imagelayers/layers/jareddlc/jenkins-with-docker-socket/latest.svg)](https://hub.docker.com/r/jareddlc/jenkins-with-docker-socket/) -->
<!-- [![Docker Size](https://img.shields.io/imagelayers/image-size/jareddlc/jenkins-with-docker-socket/latest.svg)](https://hub.docker.com/r/jareddlc/jenkins-with-docker-socket/) -->


This image was created to be a small layer on top of jenkins:alpine such that it could have access to the host's docker cli (via docker.sock). This image will run using the jenkins user, however it introduces a docker group and sets ownership of the docker.sock to it, additionally it adds the jenkins user to the list of sudoers.

# How to use this image

`$ docker run -d -v /var/run/docker.sock:/var/run/docker.sock -p 8080:8080 -p 50000:50000 jareddlc/jenkins-with-docker-socket`


For more information and options see official jenkins repo: https://hub.docker.com/_/jenkins/
