# K8s-cluster-setup
### k8s Master and Node Setup
 ### 1. PREREQUISITES - Install following in ubuntu OS in AWS EC2 instance
 #### note: Instance requirements 2 vCPU  and 8GB RAM  -- t3.large would be sufficient
 #### note: these below commands should be run on all masters and nodes
 ```
  apt-get update && apt-get upgrade -y  
  apt-get install -y apt-transport-https  
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -  
  cat <<EOF >/etc/apt/sources.list.d/kubernetes.list  
  deb http://apt.kubernetes.io/ kubernetes-xenial main
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
  
- 1. If Master is not ready status then check the pods: (run only on master)
 ```
  kubectl get pods -o wide --all-namespaces 
 ```
- 2. if issue with core dns then add any of the network plugins for cluster administration
 ```
  https://kubernetes.io/docs/concepts/cluster-administration/addons/ 
 ```
  note: we can select any of the network plugins , we choose `calico`
  ``` 
   https://docs.projectcalico.org/v3.11/getting-started/kubernetes/ 
  ```
- 3. To setup core dns (run only on master)
 ```
  kubectl apply -f https://docs.projectcalico.org/v3.11/manifests/calico.yaml
  kubectl apply -f https://docs.projectcalico.org/v3.11/manifests/calico.yaml
 ```
- note: old versions
 ```
  kubectl apply -f \
  https://docs.projectcalico.org/v3.6/getting-started/kubernetes/installation/hosted/kubernetes-datastorecalico-networking/1.7/calico.yaml
  
  kubectl apply -f \
  https://docs.projectcalico.org/v3.4/getting-started/kubernetes/installation/hosted/etcd.yml
  ```
- 4. To check the status of instance whether it is initialized as master 
 ``` 
  kubectl get pods -o wide --all-namespaces 
  kubectl get nodes -o wide
 ```

  #### Ensure that all the nodes are in ready state if not we can troubleshoot it. 
  #### 2. Possible reason would be the swap functionality enabled on the node or not.
  
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
   - *NOTE*: if we don't turn off swap permanently, then after restarting instances. we will get the connection
       refused error. The connection to the server <master-ip>:6443 was refused - did you specify the right host or port? 
       
   - then To resolve this issue: use the below commands:
       
   - check whether the port is listening
      ```
       netstat -a | grep 6443
      ```
   - if port is not in listening state; then use the following commands:
      ``` 
         sudo -i
         swapoff -a
         exit
         strace -eopenat kubectl version
      ```
### 5. To add a node to this master run the following command on ONLY ON NODE instance (Other EC2 INSTANCE)
  ##### This below command is already auto-generated from step 3 and In your case it would be different.
  ```
    kubeadm join 192.168.86.129:6443 --token 8951if.kmexn0g6z6xe2vnv --discovery-token-ca-cert-hash sha256:dde332f05cf2a84685dbaeb7324c01db142f213da0664eac94fa1023a3d37e6d
   ``` 
  ##### TroubleShoot: (run this only on master)
   - To print the token: (in case if we forget to note down when generated using step 3)
   ```
     kubeadm token create --print-join-command
   ```
  - To create a new token if token generated is expired:
    ```
      kubeadm token create
      kubeadm token create --print-join-command
    ```
    #### we need to check the services of kubelet kube-proxy process running on the master and worker node
     ` ps -aux | grep kube-proxy`
    #### and also for kubelet
    ` ps -aux | grep kubelet`
    #### and finally we can get the overall information and status of the cluster using the kubectl
    ` kubectl cluster-info`
