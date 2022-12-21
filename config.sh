#!/bin/bash
scp moibit@devapi.moinet.io:/home/moibit/datanode.refactor ./
set -e

datanode_install() {

sudo mkdir /bin/config
sudo mv mobdataconfig.yml /bin/config

#installing nodejs
curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh
sudo apt install nodejs 

#installing git
sudo apt-get update 
sudo apt-get install git 

#installing pm2
sudo npm i pm2 -g

    GO="go"
    if [ ! -d "$GO" ]; then
        wget https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz 
        
        tar xvzf go1.14.4.linux-amd64.tar.gz
    else
        cd "$GO"
        echo -en 'go already exist\n'
    fi

    IPFS="go-ipfs"
    if [ ! -d "$IPFS" ]; then
        wget https://github.com/ipfs/go-ipfs/releases/download/v0.10.0/go-ipfs_v0.10.0_linux-amd64.tar.gz 
        
        tar xvzf go-ipfs_v0.10.0_linux-amd64.tar.gz
        
        cd "$IPFS"     

        sudo ./install.sh       
    else
        cd "$IPFS"
        echo -en 'IPFS already exist\n'
    fi

    IPFS_Cluster_Service="ipfs-cluster-service"
    if [ ! -d "$IPFS_Cluster_Service" ]; then
        wget https://dist.ipfs.io/ipfs-cluster-service/v0.14.0/ipfs-cluster-service_v0.14.0_linux-amd64.tar.gz 
        tar xvzf ipfs-cluster-service_v0.14.0_linux-amd64.tar.gz
        sudo cp ipfs-cluster-service/ipfs-cluster-service /usr/local/bin       
    else
        cd "$IPFS_Cluster_Service"
        echo -en 'IPFS cluster already exist\n'
    fi

     IPFS_Cluster_CTL="ipfs-cluster-ctl"
    if [ ! -d "$IPFS_Cluster_CTL" ]; then
        wget https://dist.ipfs.io/ipfs-cluster-ctl/v1.0.4/ipfs-cluster-ctl_v1.0.4_linux-amd64.tar.gz 
        tar xvzf ipfs-cluster-ctl_v1.0.4_linux-amd64.tar.gz
        sudo cp ipfs-cluster-ctl/ipfs-cluster-ctl /usr/local/bin       
    else
        cd "$IPFS_Cluster_CTL"
        echo -en 'IPFS cluster ctl already exist\n'
    fi

}
datanode_install
