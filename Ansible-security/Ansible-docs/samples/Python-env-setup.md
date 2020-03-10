WebApp  Installation Instructions for Centos 7


The installation procedure is a bit different on Centos 7. So those of you following this course from the first course, please follow the below instructions:

# Install Python Pip and dependencies on Centos 7

-------------------------------------------------

sudo yum install -y epel-release python python-pip

sudo pip install flask flask-mysql

# If you come across a certification validation error while running the above command, please use the below command.

# sudo pip install --trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.python.org flask flask-mysql



# Install MySQL Server on Centos 7

---------------------------------------------

wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm

sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm

sudo yum update

sudo yum -y install mysql-server

sudo service mysql start



The complete playbook to get the same workin on CentOS is here:

https://github.com/kodekloudhub/simple_web_application
