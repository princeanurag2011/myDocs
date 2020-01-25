#! /bin/bash
echo "=================================================================";
echo "Installing kube Master - started";
echo "=================================================================";

echo "=================================================================";
echo "Installing kube Master - Updating packages step- 1/10"; 
echo "=================================================================";

sudo apt-get update && apt-get upgrade -y;

echo "=================================================================";
echo "Installing kube Master - Installing docker step- 2/10";
echo "=================================================================";

sudo apt install -y docker.io;

sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -;
echo "=================================================================";
echo "Installing kube Master - including kube lib.. step- 3/10";
echo "=================================================================";
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list.d/kubernetes.list;

echo "=================================================================";
echo "Installing kube Master - updating kube lib.. step-4/10";
echo "=================================================================";
sudo apt update;

echo "=================================================================";
echo "Installing kube Master - installing kubelet kubeadm kubectl step- 5/10";
echo "=================================================================";

sudo apt install -y kubelet kubeadm kubectl -y;

echo "=================================================================";
echo "Installing kube Master - turning off swap memory.. step- 6/10";
echo "=================================================================";
sudo swapoff -a;
echo "=================================================================";
echo "Installing kube Master - turned off swap memory.. step- 7/10";
echo "=================================================================";
echo "=================================================================";
echo "Installing kube Master - starting docker service step- 8/10";
echo "=================================================================";
sudo service docker start;
echo "=================================================================";
echo "Installing kube Master - started docker service step- 8/10";
echo "=================================================================";
echo "===============Adding docker to startup step- 9/10======================";
sudo systemctl enable docker.service;
echo "=================================================================";
echo "Installing Kube Master.. 9/9"
echo "=================================================================";
sudo kubeadm init --pod-network-cidr=10.244.0.0/16;

echo "=================================================================";
echo "Creating a directory for kube configuration for current user!!";
echo "=================================================================";
mkdir -p $HOME/.kube;
echo "=================================================================";
echo "Copying the necessary admin configuration files...";
echo "=================================================================";
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config;
echo "=================================================================";
echo "Assigning proper permission to access the kube folder.";
echo "=================================================================";
sudo chown $(id -u):$(id -g) $HOME/.kube/config;
echo "Installing kube Master - core DNS - calico network and its policy step- 10/10";
echo "https://kubernetes.io/docs/concepts/cluster-administration/addons/";
echo "=================================================================";
echo "Applying https://docs.projectcalico.org/v3.11/manifests/calico.yaml";
echo "=================================================================";
sudo wget https://docs.projectcalico.org/v3.11/manifests/calico.yaml
sudo kubectl apply -f calico.yaml;
echo "=================================================================";
echo " congrats!! Installing kube Master - successfully 10/10  ";
echo "=================================================================";
