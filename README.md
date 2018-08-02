# dockershell

This container is intended to provide me with ephmeral Linux BASH shells for use with OSX and iterm2

It includes packages I commonly use such as various networking tools, awscli, docker and shell integration for iterm2.

##### Build image
docker build -t memmerson/dockershell .

##### Ad-hoc shell command
docker run --rm memmerson/shell .

##### Example container with mounts to local folders/services
/usr/local/bin/docker run \
-it \
--rm \
-v dockershell:/root \
-v ~/Documents:/root/Documents \
-v ~/Downloads:/root/Downloads \
-v ~/.ssh:/root/.ssh \
-v ~/.aws:/root/.aws \
-v /var/run/docker.sock:/var/run/docker.sock \
memmerson/dockershell \
/bin/bash
