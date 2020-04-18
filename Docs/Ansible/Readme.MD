


#  Ansible Security Automation

####  Ansible Components:
 - Inventory Files:
     - This is the host file which contains all the HOST servers and
       group of servers information
 - Group Vars:
     - This is the directory containing YAML files in which
       variable are defined.
     - The variables present here can be utilized all the Playbooks
 - Host Vars:
     - This is the directory containing YAML files in which
       variable are defined.
     - These are the variables used for HOSTS defined in Inventory files
 - Playbook:
     - These are the YAML file in which tasks are defined
     - Tasks mentioned in the Playbooks are executed on the target machines.
 - Roles:
     -  These are used to write the playbooks in a structured way.

#### Ansible variable Precedence:

```
   1. role defaults              /path/to/role/x/defaults/main.yaml
   2. Inventory variables        /path/to/Inventory/hosts
   3. Inventory group Variables  /path/to/inventory/group_vars/group.yaml
   4. Inventory host variables   /path/to/inventory/host_vars/host.yaml
   5. Playbook group_vars        ./group_vars/group.yaml  (PATH relative to playbook)
   6. Playbook host_vars         ./host_vars/host.yaml  (PATH relative to playbook)

   7. Gather HOST Facts           HOST data is collected as playbook starts running
   8. Play vars                   In the playbook used as vars
   9. Play vars_prompt            In the playbook used as vars_prompt
   10. registered_vars            In the playbook registered by tasks
   11. set_facts                  In the playbook used as set_fact
   12. includes                   Either a /path/to/role/x/vars/main.yaml
                                   or vars: for an include
```

####  Ansible directory layout:
 refer: https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html

##### directory-layout:

```
- production                   inventory file for production servers
- staging                      inventory file for staging environment

- group_vars/
     group1.yml                here we assign variables to particular groups
     group2.yml
- host_vars/
     hostname1.yml             here we assign variables to particular systems
     hostname2.yml

- library/                     if any custom modules, put them here (optional)
- module_utils/                if any custom module_utils to support modules, put them here (optional)
- filter_plugins/              if any custom filter plugins, put them here (optional)

- site.yml                     master playbook
- webservers.yml               playbook for webserver tier
- dbservers.yml                playbook for dbserver tier

- roles/
    common/                  this hierarchy represents a "role"
        tasks/             
            main.yml          <-- tasks file can include smaller files if warranted
        handlers/          
            main.yml          <-- handlers file
        templates/            <-- files for use with the template resource
            ntp.conf.j2       <------- templates end in .j2
        files/             
            bar.txt           <-- files for use with the copy resource
            foo.sh            <-- script files for use with the script resource
        vars/              
            main.yml          <-- variables associated with this role
        defaults/          
            main.yml          <-- default lower priority variables for this role
        meta/              
            main.yml          <-- role dependencies
        library/             roles can also include custom modules
        module_utils/        roles can also include custom module_utils
        lookup_plugins/      or other types of plugins, like lookup in this case

  - webtier/                 same kind of structure as "common" was above, done for the webtier role
  - monitoring/              ""
  - fooapp/                  ""
```

####  Ansible roles layout:
 refer: https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html#role-directory-structure

#### Ansible Installation

centos-7:

```
-------------------------------------------------------------------------------------
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm;

subscription-manager repos --enable "rhel-*-optional-rpms" --enable "rhel-*-extras-rpms"  --enable "rhel-ha-for-rhel-*-server-rpms";

sudo subscription-manager repos --enable rhel-7-server-ansible-2.9-rpms;

sudo yum install ansible
-------------------------------------------------------------------------------------
```
centos-8:

```
-------------------------------------------------------------------------------------
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm;
ARCH=$( /bin/arch )
subscription-manager repos --enable "codeready-builder-for-rhel-8-${ARCH}-rpms"
dnf config-manager --set-enabled PowerTools;
sudo subscription-manager repos --enable rhel-7-server-ansible-2.9-rpms;

sudo yum install ansible
-------------------------------------------------------------------------------------
```
ubuntu:

```
-------------------------------------------------------------------------------------
$ sudo apt update
$ sudo apt install software-properties-common
$ sudo apt-add-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible
-------------------------------------------------------------------------------------
```

#### Ansible Configuration

##### Configuration of Control Node:

  Connect to the Control node from MobaXterm using Public IP (if using AWS Cloud):

```
  Switch to Sudo user:
     sudo su

  - 1. Add User 'ansibleadmin' the controller Node
       adduser ansibleadmin

  - 2. Switch to ansibleadmin User
       su - ansibleadmin

  - 3. Using Public and Private Key Using ssh-keygen
       ssh-keygen -t rsa -b 4096 -C "ansibleadmin"

  - 4. Copy the Public Key in your notepad.
       NOTE:
       #### TIP:
         we can use 'ssh-copy-id' to copy public key in remote target machine
         if password based authentication is enabled:
            ssh-copy-id -i id_file user@target_ip

  - 5. Exit the shell and switch back to root.

  - 6. Update the sudoers entry for the ansibleadmin
        chmod u+x /etc/sudoers
        vim /etc/sudoers

  - 7. Add the ansibleadmin user in below format in the above opened file.
        ansibleadmin  ALL=(ALL)    NOPASSWD:ALL
```

##### Configuration of Target Node: (This step is same for all Target Nodes):

   Connect to the target node from MobaXterm using Public IP (if using AWS Cloud)

```
Switch to Sudo user:
  sudo su

- 1. Add User 'ansibleadmin' the target Node:
     adduser ansibleadmin

- 2. Switch to ansibleadmin User:
     su - ansibleadmin

- 3. Create .ssh directory in the home directory and  give rw permissions
     cd ~ && mkdir .ssh && chmod 600 .ssh

- 4. Go to .ssh directory and create 'authorized_keys' file. and give rw permissions
     cd .ssh  && touch authorized_keys && chmod 600 authorized_keys

     **NOTE** : COPY and paste the previously save code in notepad here in 'authorized_keys' file.

- 5. Exit the shell and switch back to root.

- 6. Update the sudoers entry for the ansibleadmin
     chmod u+x /etc/sudoers
     vim /etc/sudoers

- 7. Add the ansibleadmin user in below format in the above opened file.
     ansibleadmin  ALL=(ALL)    NOPASSWD:ALL
```

#### Inventory file:
  /etc/ansible/hosts

#### sample inventory file:
```
  ----------------hosts----------------------------

   [webservers]
   10.2.3.34

   [webservers:vars]
   ansible_user=ansibleadmin

   [dbservers]
   10.2.4.54

   [dbservers:vars]
   ansible_user=ansibleadmin

   [hosts:child]
    webservers
    dbservers

  --------------------------------------------
```
#### Ansible configuration File:
    /etc/ansible/ansible.cfg

##### NOTE:
	  we can change the default settings here
      - path of inventory file
      - fork size:
          - no of parllel executions
      - vault_password_file
      - privilege escalation:
          - become=True
          - become_method=sudo
          - become_user=root
          - become_ask_password=False
       - ssh_connection performance              
       - pipelining:
          - performance improvments:
              enabling this will reduce the no. of ssh operations
              required to execute a module on remote server
       -  host_key_checking

#### Ansible Ad-hoc Commands:
```
  ansible <hostname or ip address or hostgroup>  \
  -m <moduleName> \
  -a <"moduleArguments">  \
  -u <userName>
```
  ex-1 : To ping webservers in hosts file:
   ```
     ansible webservers -m ping
   ```
  ex-2 : To get memory details of webservers in inventory file:
   ```
     ansible webservers -a "free -m" -u ansibleadmin
   ```
  ex-3 : To Copy host details to webservers present in inventory file:
   ```
     ansible webservers -m copy -a "src=/etc/hosts dest=/tmp/hosts"
   ```
  for more examples:
   refer: https://docs.ansible.com/ansible/latest/user_guide/intro_adhoc.html

#### Ansible Playbooks:

  sample ansible playbook:

```
----------------main.yaml--------------------------------------
---
 - hosts: webservers
   become: yes
   tasks:
     - name: create and empty file
       command: touch /tmp/abcd.txt

     - name: register the o/p of command in a varaible 'out'
       command: ls -l /tmp/
       register: out

     - name: print the output store in varibale 'out'
       debug: var=out.stdout_lines

------------------------------------------------------
```
#### To dry-run (test) playbook     
  ```
   ansible-playbook main.yaml -C
  ```
#### To execute playbook     
  ```
   ansible-playbook main.yaml
  ```
#### for more  playbooks examples:
    refer: https://docs.ansible.com/ansible/latest/user_guide/playbooks.html


#### Most Common Modules Used:
```
    Package Management:
    - apt , yum,  pkg, apt_repository - Use 'Package' Instead

    Files and Directories:
    - template, file, lineinfile, blockinfile, copy, fetch and stat

    System:
    - service, user, group, cron, hostname, authorized_keys, iptables, modprobe,
      kernel_blacklist, gluster_volumes, lvm, zfs

    Various_Useful:
    - raw, synchronize, get_url, unarchive, ec2, rds
```
#### for more  playbook modules examples:
    refer: https://docs.ansible.com/ansible/latest/modules/modules_by_category.html

#### Ansible Vault:

  - Encrypt Variables:
     run below command and set password when prompted. Then it will generate the  encrypted code in the console. You can copy it paste in YAML file variables.

	  ```
	      ansible-vault encrypt_string "Password123"
	  ```

  - Encrypt Files:

      - To encrypt files(.txt , .yaml etc., ), run below command and set password when prompted.

		```
		     ansible-vault encrypt secrets.yaml
		```

      - To view the encrypted secrets.yaml

	  	```
	  	     cat secrets.yaml
	  	```

      - To view the content of the **secrets.yaml** run below command and give password when prompted.

	   	```
	   	     ansible-vault view secrets.yaml
	   	```

      - To decrypt the **secrets.yaml** file run below command and give password when prompted.

	       ```
	            ansible-vault decrypt secrets.yaml
	       ```

      - To view the decrypted secrets.yaml

       	```
       	     cat secrets.yaml
       	```

      - To Change the password of encrypted **secrets.yaml**  run the below command, give password when prompted and then set new password

       	```
       	    ansible-vault rekey secrets.yaml
       	```

      - To edit the encrypted file **secrets.yaml** run the below command, give password when prompted and then add/modify the data

	       ```
	           ansible-vault edit secrets.yaml
	       ```

      - To transfer the encrypted file to remote server:
          use the below command and give the password when prompted.

	       ```
	           ansible --ask-vault-pass -bK  -m copy \
	           -a 'src=mysecretcontent.txt dest=/tmp/mysecretcontent.txt' webservers
	       ```


- Encrypted files in Playbook:    
  - tasks file:
```
  -------------roles/secretcontent/taks/main.yaml---------
  ---
  - include_vars: text.yaml
    #roles/secretcontent/vars/text.yaml

  - name: Copy the contents in the server securely
    copy:   
      content="{{ my_content }}"
      dest=/tmp/my_content.txt
  ----------------------------------------------------------
```

- encrypt the text file using the below command and give password when prompted:

```
  ansible-vault encrypt roles/secretcontent/vars/text.yaml
```

- main file in roles:

```
  -------------roles/vault-demo.yaml------------------
  ---
  - host: webservers
   roles:
     - tasks
  ----------------------------------------------------------
```  

- Command to run this playbook and  give password when prompted:
```
  ansible-playbook --ask-vault-pass vault-demo.yaml
```


#### Ansible Security:

 - firewall:

    - iptables: rhel 6
        - rule based firewall system, which controls i/o packets
        - tables -> chains -> rules
        - config files: /etc/sysconfig/iptables
        - refer: https://docs.ansible.com/ansible/latest/modules/iptables_module.html
    - firewallD: rhel 7
        - new UI for RHEL7 and CENTOS7 Fedora like syatems
        - replaces iptables, it is also called dynamic firewall manager.
        - it has both daemon and service
        - config files: /usr/lib/firewalld/
        - /etc/firewalld/
        - refer: https://docs.ansible.com/ansible/latest/modules/firewalld_module.html
    - ufw: debian
        - Canonical’s Uncomplicated Firewall (ufw)
        - refer: https://docs.ansible.com/ansible/latest/modules/ufw_module.html#ufw-module
    - the firewall stack

 - SELinux:

     - Security Enhanced Linux is an implentation of MAC (Mandatory Access Control) mechanism
      in Linux Kernel.

     - It is built into the Linux kernel and enabled by default on Fedora, CentOS, RHEL and a few other  Linux distributions. SELinux allows server admin to define various permissions for all process. It defines how all processes can interact with other parts of the server such as:
        - Pipes
        - Files
        - Network ports
        - Sockets
        - Directories
        - Other process

     - SELinux puts restrictions on each of the above object according to a policy. For example, an apache user with full permission can only access /var/www/html directory, but can not touch other parts of the system such as /etc directory without policy modification.

     - In other words, damage can be now restricted to the particular server and files. The cracker will not able to get a shell on your server via common daemons such as Apache / BIND / Sendmail as SELinux offers the following security features:

        - Protect users’ data from unauthorized access.
        - Protect other daemons or programs from unauthorized access.
        - Protect network ports / sockets / files from unauthorized access.
        - Protect server against exploits.
        - Avoid privilege escalation and much more.

     - The procedure to remove and disable SELinux security features is as follows:

        - Log in to your server
        - Check the current SELinux status, run: sestatus
        - To disable SELinux on CentOS 7 temporarily, run: sudo setenforce 0
        - Edit the /etc/selinux/config file and set the SELINUX to disabled
        - Reboot the Linux server
        - Verify it by running the sestatus and getenforce again

     - Different types of security policy:
         - /etc/selinux/config file controls the state of SELinux on the system. SELINUX= can take one of these three values:

        - enforcing – SELinux security policy is enforced.
        - permissive – SELinux prints warnings instead of enforcing (disabled).
        - disabled – No SELinux policy is loaded (disabled).
        - SELINUXTYPE= can take one of following:

        - targeted – Targeted processes are protected.
        - minimum – Modification of targeted policy. Only selected processes are protected.
        - mls – Multi Level Security protection.

     - Disabling SELinux permanently
        - Edit the /etc/selinux/config file, run:
        - sudo vi /etc/selinux/config

        - Set SELINUX to disabled:
          SELINUX=disabled

        - Save and close the file in vi/vim. Reboot the Linux system:
          sudo reboot

        - After reboot, make sure following commands gives Disabled output indicating that SELinux removed and disabled on your Linux server:
          getenforce
          sestatus
     - Refer: https://docs.ansible.com/ansible/latest/modules/selinux_module.html#selinux-module


 - ntp:
    - ntpServers details for india: https://www.ntppool.org/zone/in
    - centos: https://www.tecmint.com/install-ntp-server-in-centos/
    - https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/chap-configuring_the_date_and_time#sect-Configuring_the_Date_and_Time-timedatectl-NTP

 - ssh hardening:
   - refer: https://medium.com/@jasonrigden/hardening-ssh-1bcb99cd4cef

 
