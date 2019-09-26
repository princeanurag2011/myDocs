sudo yum-config-manager --enable epel;

sudo yum install ansible;

sudo yum install pip;

############################################
(#epel -extra package for enterprise linux)
############################################
sudo ansible --version


sudo ansible -m ping all
sudo ansible-doc -l
sudo ansible -m command -a df -h

# http://www.yamllint.com/

# 
vi apache.yml
---
- hosts: webservers
  tasks:
   - name: install apache
     yum: name=httpd state=installed
   - name: start apache
     service: name=httpd state=restarted

ansible-playbook apache.yml --syntax-check
ansible-playbook apache.yml
ansible-playbook -i inventory_prd template.yml

