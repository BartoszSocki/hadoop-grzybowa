#!/bin/sh

# useradd -d /home/hadoop -s /bin/bash -r hadoop 
# usermod -aG sudo hadoop
# passwd -d hadoop
# mkdir -p /home/hadoop/.ssh
ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config

service ssh start
