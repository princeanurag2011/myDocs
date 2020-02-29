# K8s ETCD Backup

### To see the version of ETCD:

  ETCDCTL_API=3 etcdctl version 
  
### To see the ETCD Config File:
  
  cat /etc/kubernetes/manifests/etcd.yaml
  
  NOTE: Find the 'endpoints','cacert','cert','key'  details under the 'command' section and copy them.

### To see the details of members:
 
   ETCDCTL_API=3 etcdctl --endpoints=http://[127.0.0.1]:2379 \
   --cacert=/etc/kubernetes/pki/etcd/ca.crt \
   --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt \
   --key=/etc/kubernetes/pki/etcd/healthcheck-client.key member list 
   
### To take the snapshot of ETCD DB:
   
   ETCDCTL_API=3 etcdctl --endpoints=http://[127.0.0.1]:2379 \
   --cacert=/etc/kubernetes/pki/etcd/ca.crt \
   --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt \
   --key=/etc/kubernetes/pki/etcd/healthcheck-client.key snapshot save /tmp/etcd-backyp.db 
   
       
     #### search for below if installed in kubeadm way:
     
       - --listen-client-urls=https://127.0.0.1:2379,https://172.17.0.25:2379
       - --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
       - --cert-file=/etc/kubernetes/pki/etcd/server.crt
       - --key-file=/etc/kubernetes/pki/etcd/server.key
          
  
       #### To take backup:       
```
		   ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 \
		   --cacert=/etc/kubernetes/pki/etcd/ca.crt \
		   --cert=/etc/kubernetes/pki/etcd/server.crt \
		   --key=/etc/kubernetes/pki/etcd/server.key \
		   snapshot save /tmp/snapshot-pre-boot.db
  ```
  
### To see the status of the snapshot in a table format

   ETCDCTL_API=3 etcdctl --endpoints=http://[127.0.0.1]:2379 \
   --cacert=/etc/kubernetes/pki/etcd/ca.crt \
   --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt \
   --key=/etc/kubernetes/pki/etcd/healthcheck-client.key snapshot status /tmp/etcd-backyp.db -w table
   

  
  