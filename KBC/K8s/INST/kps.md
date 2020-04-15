# INSTALLAING K8s using KOPS


### 1) Install KOPS
--------------------------------------------------------------------------------
wget https://github.com/kubernetes/kops/releases/download/1.10.0/kops-linux-amd64

chmod +x kops-linux-amd64

mv kops-linux-amd64 /usr/local/bin/kops

--------------------------------------------------------------------------------


### 2) Install Kubectl
--------------------------------------------------------------------------------
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

chmod +x ./kubectl

sudo mv ./kubectl /usr/local/bin/kubectl

--------------------------------------------------------------------------------

### 3) Terraform setup
 https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip
 
--------------------------------------------------------------------------------

### 4) Setup S3 bucket
  create a bucket in s3 with name kbdatacorp.com
  
### 5) Setup hosted Zone
 
### 6) Public keys
--------------------------------------------------------------------------------
ssh-keygen -f ~/.ssh/kbdatacorplogin

--------------------------------------------------------------------------------
### 7) Create a Role with these policies and attach it to EC2
AmazonRDSFullAccess
AWS managed policy

 AmazonEC2FullAccess
AWS managed policy

 IAMFullAccess
AWS managed policy

 AmazonS3FullAccess
AWS managed policy

 AmazonRoute53FullAccess
 AWS managed policy
 
--------------------------------------------------------------------------------
```
kops create cluster \

  --name=kbdatacorp.com \

  --state=s3://kbdatacorp\

  --authorization RBAC \

  --zones=us-east-2a \

  --node-count=2 \

  --node-size=t2.micro \

  --master-size=t2.micro \

  --master-count=1 \

  --dns-zone=kbdatacorp.com \

  --out=kops_terraform \

  --target=terraform \

  --ssh-public-key=~/.ssh/kbdatacorplogin.pub
```

--------------------------------------------------------------------------------

#### Terraform output has been placed into 'kops_terraform'
Run these commands to apply the configuration:
```
   cd kops_terraform
   terraform init
   terraform plan
   terraform apply
```

#### validate cluster: 
```
kops validate cluster --state s3://kbdatacorp.com
```

Validating cluster kbdatacorp.com
--------------------------------------------------------------------------------


#### INSTANCE GROUPS

|NAME                  |  ROLE    |MACHINETYPE   |  MIN  |   MAX  |   SUBNETS  |
|----------------------|----------|--------------|-------|--------|------------|
|master-us-east-2a     |  Master  | t2.micro     |   1   |    1   | us-east-2a |
|nodes                 | Node     | t2.micro     |   2   |    2   | us-east-2a |

--------------------------------------------------------------------------------


#### NODE STATUS
--------------------------------------------------------------------------------

|NAME                                          |  ROLE   | READY|
|----------------------------------------------|---------|------|
|ip-172-20-34-212.us-east-2.compute.internal   | node    | True |
|ip-172-20-35-251.us-east-2.compute.internal   | node    | True |
|ip-172-20-45-162.us-east-2.compute.internal   | master  | True |

--------------------------------------------------------------------------------

Your cluster kbdatacorp.com is ready

### if you want delete cluster:
```terraform destroy```
