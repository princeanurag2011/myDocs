# K8s-cluster-setup
### k8s Master and Node Setup
 ### 1. PREREQUISITES - Install following in ubuntu OS in AWS EC2 instance

 #### note: Instance requirements 2 vCPU  and 8GB RAM  -- t3.large would be sufficient
 #### note: these commands should be run on all masters and nodes
 ```
  apt-get update && apt-get upgrade -y  
  apt-get install -y apt-transport-https  
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add  
  cat <<EOF >/etc/apt/sources.list.d/kubernetes.list  
  deb http://apt.kubernetes.io/kubernetes-xenial main
  EOF  
  apt install -y docker.io  
  apt-get update
  service docker start
  sudo systemctl enable docker.service
 ```
### 2. Kubeadm Kubectl kubelet INSTALLATION
 ##### note: these commands should be run on all masters and nodes  
  ` apt-get install -y kubeadm kubectl kubelet `
  
### 3. To make EC2 instance as a Master (run this command only on Master)
 ##### note: these commands should be run only on masters
  ` kubeadm init `

### 4. To start using your cluster, you need to run following commands as a regular user
 #### This below is auto-generated from step 3:
  ```
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
  ```
### To check the status of instance whether it is initialized as master 
 ` kubectl get nodes -o wide`
  
#### TroubleShoot:
  #### Ensure that all the nodes are in ready state if not we can troubleshoot it. 
  #### Possible reason would be the swap functionality enabled on the node or not.
  
   - TO disable the feature on swap on the current node)    
      ` swapoff -a `
   - If you want it to permenantly disable the swap then
    comment the swap line in /etc/fstab and type the below command   
      ` mount -a ` 
   - For the confirmation run the below command:   
      ```
       free -h
       cat /proc/swaps
      ```
### 5. To add a node to this master run the following command on node instance (Other EC2 INSTANCE)
  #### This below is auto-generated from step 3
  #### In your case it would be different.
     ```
     kubeadm join 192.168.86.129:6443 --token 8951if.kmexn0g6z6xe2vnv --discovery-token-ca-cert-hash sha256:dde332f05cf2a84685dbaeb7324c01db142f213da0664eac94fa1023a3d37e6d
     ``` 
  ##### TroubleShoot:
   - To print the token:     
	 ```
	   kubeadm token create --print-join-command
	 ```
  - To create a new token if token generated is expired:  
     ```
	   kubeadm token create
	   kubeadm token create --print-join-command
	 ```
  
      
## 6 
