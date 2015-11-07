#!/bin/bash

sudo apt-get update -y;
sudo apt-get install git ansible -y;
sudo mkdir -p /var/scratch;
cd /var/scratch;
sudo git clone https://github.com/amit213/bootcampAL1.git;
sudo ansible-playbook -i "localhost," -c local /var/scratch/bootcampAL1/ansiblescripts/basicprep-allDistro.yml;

sudo apt-add-repository ppa:juju/stable -y;
sudo apt-get update -y;
sudo apt-get install juju-local qemu-kvm libvirt-bin bridge-utils virt-manager qemu-system uvtool-libvirt uvtool -y;
sudo adduser vmuser libvirtd;
sudo adduser vmuser kvm;
sudo apt-get upgrade -y;

sudo add-apt-repository ppa:juju/stable -y;
sudo apt-get update -y;
sudo apt-get install juju-core -y;
sudo apt-get install juju-local -y;
sudo apt-get install python-software-properties -y;

sudo apt-get install software-properties-common python-software-properties -y;


## juju prep work
juju init
cp -f ./juju-environment.yaml ~/.juju/environments.yaml
juju switch local
juju bootstrap --debug
juju set-constraints "cpu-cores=1 mem=4096M root-disk=16384M"


sudo init 6;
