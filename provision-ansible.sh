#!/bin/bash
echo "Configuring SSH environment..."
echo "-Installing sshpass..."
sudo apt install sshpass -y

echo "-Getting private RSA key..."
rm -f /home/vagrant/.ssh/id_rsa*
ssh-keygen -f /home/vagrant/.ssh/id_rsa -P ""

echo "-Scanning remote keys..."
rm -f /home/vagrant/.ssh/known_hosts
ssh-keyscan -t ecdsa vm1 >> /home/vagrant/.ssh/known_hosts
ssh-keyscan -t ecdsa vm2 >> /home/vagrant/.ssh/known_hosts

echo "-Copying RSA key to remode hosts..."
sshpass -f /vagrant/passwd_file ssh-copy-id vm1
sshpass -f /vagrant/passwd_file ssh-copy-id vm2

echo "Installing ansible..."
sudo apt install ansible -y