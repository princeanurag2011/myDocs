# ====================JENKINS SETUP FOR EC2============================================== #
# PREREQUISITES;
# 1. JDK 1.8
# 2. MAVEN
# 3. GIT
#-----------------------------------------------------------------------------------------
# 1.	JDK 8 Setup.
# Use the following commands
  sudo yum install -y java-1.8.0-openjdk-devel.x86_64;
  
# set the java version using following commands:
# When prompted, enter the number for Java 8
   sudo /usr/sbin/alternatives --config java;
   sudo /usr/sbin/alternatives --config javac;
   
#for ubuntu
 sudo update-alternatives --config java
 sudo update-alternatives --config javac
#-----------------------------------------------------------------------------------------
# 2.	MAVEN setup
# Use the following commands
   sudo wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo;
   sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo;
   sudo yum install -y apache-maven;
#-----------------------------------------------------------------------------------------
# 3.	GIT setup
#Use the following commands
    sudo yum install -y git;
#-----------------------------------------------------------------------------------------
# 4.	Jenkins Setup:
# Use the following commands

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo;
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key;
sudo yum install -y jenkins;
#-----------------------------------------------------------------------------------------
# 5.	Configure Jenkins
# Use the following commands.
  sudo service jenkins start;
# To get IP address.
  curl ifconfig.co;  
# Go to Browser: To access jenkins ->   http://ipaddress:8080/ 
# enter the jenkins secret password (see below note section) 

# Note:
# To get the password use the following command
cat /var/lib/jenkins/secrets/initialAdminPassword
#-----------------------------------------------------------------------------------------
# 6.	Install Jenkins Plugins
# 1. Click on install suggested plugins. (#takes some time to install, may be 5 min..)
# 2. Enter new Username, Password and email when asked.
# 3. click on save and continue.

That’s It Jenkins Loaded..!!
#-----------------------------------------------------------------------------------------
# For Deployments: 
# Install plugin:   Deploy to container 
# Click on manage jenkins > click on manage plugins > click on Available > search for Deploy to container plugin  and then Install it. 	
