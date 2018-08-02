FROM amazonlinux

RUN yum update -y && yum install -y wget

# Install EPEL
RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -ihv epel-release-latest-7.noarch.rpm

# Install packages
RUN yum install -y \
	man man-pages gettext openssh-client vim \
	bind-utils net-tools nmap curl wget less \
	unzip git python2-pip groff telnet jq tar \
	mosh nmap telnet iotop iftop iptraf-ng mtr \
	traceroute iperf ncdu pv hping3 procps \
	util-linux

RUN pip install awscli boto3
RUN curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash

# Install Docker tools
RUN export DOCKER_DL=$(curl https://download.docker.com/linux/static/stable/x86_64/ \
	| grep docker \
	| awk -F'"' '{print $2}' \
	| sort --version-sort --field-separator=- --key=2,2 --reverse \
	| head -1) && \
	wget https://download.docker.com/linux/static/stable/x86_64/${DOCKER_DL} && \
	tar zxvf ${DOCKER_DL} && \
	cp docker/* /usr/bin/

# Cleanup
RUN	rm -rf docker/ ${DOCKER_DL} epel-release-latest-7.noarch.rpm

WORKDIR /root
