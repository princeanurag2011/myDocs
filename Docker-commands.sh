==========docker installation============================

#To install docker 
 sudo yum install docker -y

#To check the version after installing 
 docker --version #or
 docker version
#note: it will only give the client version if the docker service is not started.

#TO start the docker service 
 service docker start
=============================================================
#To check the docker running status
 service docker status

#note: if docker service is not running, then following commands will not work.

#To check the version after installing 
 docker version
#note: after starting docker service , it shows both client and server versions.

#To check the status of all running containers images  and metadata ..
 docker info
=====================docker images and containers========================
#TO see list of images..
 docker images 

#TO delete downloaded docker images.
 docker rmi <imagename>

#To run image as a container 
 docker run <image>

#To run nginx server image as a container 
 docker run --publish 80:80 nginx  # --publish or -p 

#the above command hangs the console to avoid that , we can 
#run docker container in detached mode.

#To run docker container in detached mode 
 docker run -d -p 80:80 --name webserver nginx # -d or --detach 
 #or
 docker run -d -p 8080:80 --rm --name apacheweb httpd:latest 
 #note: --rm if this is used , when docker container is stopped, it
 #autmatically removes container image.

#To see list of running containers any of 3 below will work.
 docker ps 
#or 
 docker container ps
#or 
 docker container ls 

#To see list of all containers any of 3 below will work.
 docker ps -a
#or
 docker container ps -a
#or 
 docker container ls -a

#To stop running container 
 docker stop <container id> # ex: docker stop 8as7d897s97sa7d7da98
#note: container id looks like hashcode as shown in above example

#TO delete multiple containers at a time ...  
 docker rm <container-id> <container-id> <container-id>
 
#To stop all containers at a time.
 docker stop $(docker ps -q)

#TO delete docker container
#stop the container , then use following command
 docker rm <contianerId>
#Other we willll get an error like can't stop running container.'

#TO delete docker container forcefully 
 docker rm <container-id> -f
#TO delete multiple containers at a time .. 
 docker rm <container-id> <container-id> <container-id>
 #or
#To delete all containers at a time.
 docker rm  $(docker ps -a -q)

#TO see docker container logs 
 docker logs <container id>

#note: docker starts the containe using CMD command in image docker file.

#To see all process running in docker (inside it runs with different process id)
 docker top <container-id>

#To see all process running in linux system
 ps aux 

#To RUN MYSQL 
docker run -d -p 3306:3306 --name mysqlDB -e MYSQL_RANDOM_ROOT_PASSWORD=yes mysql
#to check the root password check docker  logs.
# look's like [Entrypoint]: GENERATED ROOT PASSWORD: iingie4cae5maWiiwoocee4IKiwaiwo3

#To RUN apache 
docker run -d -p 8080:80 --name webserver httpd
#note: here 8080 is host portno. and 80 is container port 
#the ip of docker container and host will be different. if we want to skip virtual network and use host ip  then --net=host

#To see conatiner metadata ( details of container port networking status etc.,)
 docker inspect <container-id>
#to see spefic details (for example network ip)
 docker inspect --format '{{.NetworkSettings.IPAddress}}' webserver
 docker inspect <container-id> | grep IPAddress


#To see docker container stats.. (show details of all running ocntainer cpu mem utilization , block i/o network i/o)
 docker stats
============to enter into running docker container ==========================
#To enter into container ubuntu (-i for interactiv mode and 
#-t for TTY bash shell and this will create a new container)
 docker run -it --name ubuntu <container-id> 
 #example: docker run -it --name ubuntu 987ds7787dsd78s9as

#To enter into container other than ubunutu (here bash is mentioned 
#because it is where we need to start
#but for ubuntu no need to mention that , because it's default location)
 docker run -it --name webserver <container-id> bash

# to enter into container wtihout creating a new container.
 docker exec -it <container-id> /bin/bash
 
 #to exit from the container console 
 #short cut 
 ctrl+p+q
====================================================================
==================DOCKER NETWORKING================================
#networking................
#TO see which ports are directing traffic to container from host.
 docker port <container-id>

#To see all created networks of docker
 docker network ls
 
#o/p looks like following ..
# =======================================================
# NETWORK ID          NAME                DRIVER              SCOPE
# d374b36031dd        bridge              bridge              local
# 86ad4bba7820        host                host                local
# c13ea4e57d9f        none                null                local 
# =======================================================
 
#name: bridge network 
#note: docker runs on bridge network by default 
#and network ipv4:172.17.0.0
     #subnetmask: 172.17.0.0/16
	 #gateway: 172.0.0.1
	
#name: host network	
#to increase performance there is a virtual host network to establish 
#connection b/w containers.

#name: none
#it is an extra interface like eth0 that is not connected to anything.

#To inspect a network 
 docker network inspect <name> 
#note: running this command we can 
#get the metadata of all networks on which contaner are running

#To create a network 
 docker network create <network name>
 #example: docker network create my-network

#To attach a n/w to container 
 docker network connect  old-container-old-netwrok new-container-in-new-nwetork
 #example: docker network connect a8sdysa90asd8 b23h9324h923h
 #to check attached network:
 docker network inspect b23h9324h923h
 #check the meatadata it shows the attached n/w in network section.
 
#To detach a n/w from container
 docker network disconnect old-container-old-netwrok new-container-in-new-nwetork
 #example: docker network disconnect a8sdysa90asd8 b23h9324h923h
 #to check detached network:
 docker network inspect b23h9324h923h
 #check the meatadata it removes the previously attached n/w in network section.


#To see the image layers
 docker history <image-name>
 
#To see the image meatadata
 docker image inspect <image-name>
 
===================================docker HUb===================

#To login to docker HUb from docker CLI
docker login 
#enter username and password

#docker authenticaiton url is stored in the .docker/config.json file
#this is actual url to connect to docker hub dev/stage/prodcution

#To logout of the Docker hub 
docker logout

#Docker image tagging
#to upload into the docker hub we need to do the tagging ex: username/repo:tagname
docker image tag nginx:latest princeanurag2011/nginx:dev-1-0 #tag or -t

#upload image to the docker hub 
docker push princeanurag2011/nginx:dev-1-0
#note: to push to docke hub we should login to docker hub using docker login command.


===============Docker images Building=================================
# docker images can be build in 2 ways:
# 1.0 DockerFile
# 2.0 Docker Compose
#
1.0 ================Docker File===========================================
#here is an example to create apache web server image using docker file.
# -create DockerFile using the command 
 vim DockerFile
 #copy below content in it.
-------------------------------------
FROM centos:7
RUN yum install -y httpd
#COPY proxy.conf /etc/httpd/conf.d/
EXPOSE 80
CMD /usr/sbin/httpd -D FOREGROUND
-------------------------------------

#To build docker image
docker build -t princeanurag2011/apache:dev .
#note: in the above command - dot(.) at the end repressents
#file from current directory.

=======================================================================
2.0 ============Docker Compose=========================================
















