#!/bin/bash

# remove comment if you want to enable debugging
#set -x

if [ -e /etc/centos-release ] ; then
  CentOS_BASED=true
  else
  echo "OS Doesn't Support"
  exit
fi

version=`rpm --eval '%{centos_ver}'`

if [ $version -eq 6 ] ; then
   echo "CentOS6 Doesn't Support Dockers"
   exit
fi


# Add Latest versions
TERRAFORM_VERSION="0.15.0"
PACKER_VERSION="1.7.2"

# create new ssh key
#[[ ! -f /home/ubuntu/.ssh/mykey ]] \
#&& mkdir -p /home/ubuntu/.ssh \
#&& ssh-keygen -f /home/ubuntu/.ssh/mykey -N '' \
#&& chown -R ubuntu:ubuntu /home/ubuntu/.ssh

# install packages
if [ ${CentOS_BASED} ] ; then
#  yum -y update
  yum install -y yum-utils epel-release
  yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  yum -y install docker-ce ansible unzip wget
fi

# add docker privileges
#usermod -G docker ubuntu
# install awscli and ebcli
#pip3 install -U awscli
#pip3 install -U awsebcli

#terraform
T_VERSION=$(/usr/local/bin/terraform -v | head -1 | cut -d ' ' -f 2 | tail -c +2) >/dev/nul 2>&1
T_RETVAL=${PIPESTATUS[0]}

[[ $T_VERSION != $TERRAFORM_VERSION ]] || [[ $T_RETVAL != 0 ]] \
&& wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
&& unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin \
&& rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# packer
P_VERSION=$(/usr/local/bin/packer -v) >/dev/null 2>&1
P_RETVAL=$?

[[ $P_VERSION != $PACKER_VERSION ]] || [[ $P_RETVAL != 0 ]] \
&& wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
&& unzip -o packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin \
&& rm packer_${PACKER_VERSION}_linux_amd64.zip

# clean up
#if [ ! ${REDHAT_BASED} ] ; then
#  apt-get clean
#fi
