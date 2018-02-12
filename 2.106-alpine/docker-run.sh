#!/bin/bash

docker run -d -v /var/run/docker.sock:/var/run/docker.sock -p 8080:8080 -p 50000:50000 jenkins-with-docker-socket:2.60.3-alpine
