#!/bin/bash

## Install node exporter for methrics (commit it if your not need methrics)

echo "[Node Exporter] : download..."
wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
echo "[Node Exporter] : successfully downloaded..."

echo "[Node Exporter] : installation..."
tar xvfz node_exporter-*.linux-amd64.tar.gz
cd node_exporter-*.*-amd64
sudo mv node_exporter /usr/bin/

echo "[Node Exporter] : creating a user..."
sudo useradd -r -M -s /bin/false node_exporter
sudo chown node_exporter:node_exporter /usr/bin/node_exporter

echo "[Node Exporter] : creating a system unit..."
{   echo '[Unit]'; \
    echo 'Description=Prometheus Node Exporter'; \
    echo '[Service]'; \
    echo 'User=node_exporter'; \
    echo 'Group=node_exporter'; \
    echo 'Type=simple'; \
    echo 'ExecStart=/usr/bin/node_exporter'; \
    echo '[Install]'; \
    echo 'WantedBy=multi-user.target'; \
} | tee /etc/systemd/system/node_exporter.service;

echo "[Node Exporter] : reload daemon..."
sudo systemctl daemon-reload
echo "[Node Exporter] : enable node exporter..."
sudo systemctl enable --now node_exporter
sudo systemctl status node_exporter
echo "Node exporter has been setup succefully!"

## Install docker

echo "[Docker] : installing..."

apt update && apt install -y git
curl -sSL https://get.docker.com/ | sh

echo "[Docker] : add user to vagrant group..."
sudo usermod -aG docker vagrant

## Install minikube

echo "[Minikube] : Installing minikube"
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
mkdir -p /usr/local/bin/
install minikube /usr/local/bin/
rm minikube

echo "[Minikube] : Installing kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin/

echo "[Minikube] : add aliases"
echo "alias k='kubectl'" >> /etc/profile.d/00-aliases.sh
echo "alias kg='kubectl get'" >> /etc/profile.d/00-aliases.sh
echo "alias kd='kubectl describe'" >> /etc/profile.d/00-aliases.sh

echo "[Minikube] : add autofill..."
echo "source <(kubectl completion bash)" >> /etc/profile.d/00-aliases.sh

## Clone k8s yaml code examples from slurm

echo "[Git] : clone learning repository..."
su - vagrant -c 'git clone https://github.com/codesshaman/slurm_k8s_tasks.git /home/vagrant/slurm'

echo "[machine : $(hostname)] has been setup succefully!"
