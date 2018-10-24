#!/bin/bash

USER_JENKINS=jenkins
GROUP_DOCKER=docker

function getGroup () {
	echo "$(ls -al /var/run/docker.sock | awk '{print $4}')"
}

echo "***** docker-socket *****"
echo "Current user: $(whoami)"
echo "/var/run/docker.sock is currently in group:" $(getGroup)
echo "Changing group of docker.sock to: $GROUP_DOCKER"

sudo chown :$GROUP_DOCKER /var/run/docker.sock

echo "/var/run/docker.sock is now in group:" $(getGroup)
echo "*************************"

# From https://github.com/jenkinsci/docker/blob/a11bb3e367da9756cc9d95d153b1fb50431ebcaf/Dockerfile
/bin/sh -c "/bin/bash -- /usr/local/bin/jenkins.sh"
