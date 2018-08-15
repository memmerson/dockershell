FROM amazonlinux
WORKDIR /root

RUN yum update -y && yum install -y wget

# Install EPEL
RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    rpm -ihv epel-release-latest-7.noarch.rpm

# Install packages
RUN yum install -y \
      man man-pages gettext openssh vim bind-utils iputils net-tools nmap curl wget less  unzip git \
      python2-pip groff telnet jq tar nmap telnet iotop iftop iptraf-ng mtr traceroute iperf \
      ncdu pv hping3 procps util-linux make ansible && \
    yum install -y mosh protobuf-compiler openssl-devel && \
    pip install awscli boto3 && \
    curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash

# Install Terraform
RUN export TF_LATEST_VERSION="https://releases.hashicorp.com$(curl https://releases.hashicorp.com/terraform/ | grep terraform | egrep -v 'rc|beta' | awk -F'"' '{print $2}' | sort --version-sort --reverse | head -1)" && \
    export TF_FILENAME=$(curl ${TF_LATEST_VERSION} | grep linux_amd64.zip | head -n 1 | awk -F'"' '{print $10}' | awk -F'/' '{print $4}') && \
    curl ${TF_LATEST_VERSION}${TF_FILENAME} -o ${TF_FILENAME} && \
    unzip ${TF_FILENAME} && \
    mv terraform /usr/local/bin

# Install Docker tools
RUN export DOCKER_DL=$(curl https://download.docker.com/linux/static/stable/x86_64/ \
      | grep docker \
      | awk -F'"' '{print $2}' \
      | sort --version-sort --field-separator=- --key=2,2 --reverse \
      | head -1) && \
    wget https://download.docker.com/linux/static/stable/x86_64/${DOCKER_DL} && \
    tar zxvf ${DOCKER_DL} && \
    cp docker/* /usr/bin/

# Misc & Cleanup
RUN rm -rf docker* && \
    rm epel-release-latest-7.noarch.rpm && \
    rm terraform*
