#! /bin/bash
echo "=================================================================";
echo "Installing kube node - started";
echo "=================================================================";

echo "=================================================================";
echo "Installing kube node - Updating packages 1/9"; 
echo "=================================================================";

sudo apt-get update && apt-get upgrade -y;

echo "=================================================================";
echo "Installing kube node - Installing docker 2/9";
echo "=================================================================";

sudo apt install -y docker.io;

sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -;
echo "=================================================================";
echo "Installing kube node - including kube lib.. 3/9";
echo "=================================================================";
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list.d/kubernetes.list;

echo "=================================================================";
echo "Installing kube node - updating kube lib.. 4/9";
echo "=================================================================";
sudo apt update;

echo "=================================================================";
echo "Installing kube node - installing kubelet kubeadm kubectl 5/9";
echo "=================================================================";

sudo apt install -y kubelet kubeadm kubectl -y;

echo "=================================================================";
echo "Installing kube node - turning off swap memory.. 6/9";
echo "=================================================================";
sudo swapoff -a;
echo "=================================================================";
echo "Installing kube node - starting docker service 7/9";
echo "=================================================================";

sudo service docker start;
echo "=================================================================";
echo "Installing kube node - started docker service 8/9";
echo "=================================================================";
echo "===============Adding docker to startup==========================";
sudo systemctl enable docker.service;
echo "=====================Installation complete  9/9==================";
