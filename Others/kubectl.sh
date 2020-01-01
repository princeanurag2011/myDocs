Now first we need to update all our nodes including kube-master, node-01, node-02.

# apt-get update && apt-get upgrade -y (on all nodes kube-master, node-01, node-02)
# apt install -y docker.io (on all nodes kube-master, node-01, node-02)

# curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - (on all nodes kube-master, node-01, node-02)

# vi /etc/apt/sources.list.d/kubernetes.list (on all nodes kube-master, node-01, node-02)

deb https://apt.kubernetes.io/ kubernetes-xenial main

# apt update (on all nodes kube-master, node-01, node-02)

# apt install -y kubelet kubeadm kubectl -y (on all nodes kube-master, node-01, node-02)

# swapoff -a (on all nodes kube-master, node-01, node-02)

# kubeadm init --pod-network-cidr=10.244.0.0/16  (only on master)

Now copy the one long command for kubeadm join for other nodes. In your case it would be different.

master
kubeadm join 10.160.0.10:6443 --token opa696.p5zm11a9iodvr --discovery-token-ca-cert-hash sha256:5b09d984c8fb5191282d5063745be0f9a90e7b23511537172d01e9f

Your need to run the following as a regular user.

# exit

The below command has to be done on kubernetes master.

Now we will exit from our root user and run the three commands mentioned below 

Creating a directory for kube configuration
# mkdir -p $HOME/.kube
Copying the necessary admin configuration files
# sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
Assigning proper permission to access the kube folder.
# sudo chown $(id -u):$(id -g) $HOME/.kube/config

Now we get all the pods

# kubectl get pods --all-namespaces

To start flannel we need to tell kubectl to apply a proper .yaml file

# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml

After that we will check the flannel pod.
# kubectl get pods --all-namespaces


#TROUBLESHOOT:

Ensure that all the nodes are in ready state if not we can troubleshoot it. So the one reason would be the swap functionality enabled on the node or not.

# swapoff -a (which disable the feature on swap on the current node)

If you want it to permenantly disable the swap comment the swap line in /etc/fstab and type the below command

# mount -a

For the confirmation 

# free -h
# cat /proc/swaps

If for some reason the swap feature is disabled than we need to check the kubelet service on that node.

# kubelet logs node-01

Or if that is not working we need to ssh that node and get the logs of kubelet via journalctl command.

# journalctl -u kubelet -f

Next we need to check the services of kubelet kube-proxy process running on the master and worker node

# ps -aux | grep kube-proxy

and also for kubelet

# ps -aux | grep kubelet

and finally we can get the overall information and status of the cluster using the kubectl

# kubectl cluster-info
