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
2.0 ============Docker persistence volumes =============================

# Container Lifetime & Persistent Data: Volumes, Volumes, Volumes

## Persistent Data: Data Volumes

#To pull official image from docker hub
docker pull mysql

#to see metadata of the image
docker image inspect mysql

#To run mysql DB
docker container run -d --name mysql -e MYSQL_ALLOW_EMPTY_PASSWORD=True mysql

#To see the metadata of mysql image.. here check the volumes and mount data
docker container inspect mysql

#To see the volume inforamtion like where data is being stored.
docker volume ls

#To see the volume inforamtion like where data is being stored.
docker volume inspect <volume-id>

#assging volumes to the container to tore data on host and this will name volumes with some hash code
docker container run -d --name mysql3 -e MYSQL_ALLOW_EMPTY_PASSWORD=True -v /var/lib/mysql mysql

#named volumes:  -v tag is used to give location to store data and name that data volume..
docker container run -d --name mysql3 -e MYSQL_ALLOW_EMPTY_PASSWORD=True -v mysql-db:/var/lib/mysql mysql
#OR we can do it using mount command
docker container run -d --name mysql3 -e MYSQL_ALLOW_EMPTY_PASSWORD=True --mount type=volume, source=mysql-db, \
target=/var/lib/mysql mysql

#bind Mounts: To give common directory to both container and host
docker container run -d --name mysql4 -e MYSQL_ALLOW_EMPTY_PASSWORD=True -v $(pwd):/var/lib/mysql mysql

==================================================================
2.0 ============Docker-Compose.yml =============================

 -------- Installation --------------------------
 
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

docker-compose --version

------------to uninstall ------------------------
sudo rm /usr/local/bin/docker-compose
pip uninstall docker-compose
---------------------------------------------------
------------------------------------
docker-compose.yml
--------------------------------------
---
verison:'2.0'

services:

  wordpress:
    image:wordpress
	ports:
	  - 8080:80
	environment:
	 WORDPRESS_DB_PASSWORD: example
	volumes: 
	  - ./worpress-data:/var/www/html
	  
  mysql:
    image: mariadb
	environment:
	  MYSQL_ROOT_PASSWORD: example
	volumes:
	  - ./mysql-data:/var/lib/mysql
------------------------------------------


#To Setup volumes and networks and run all containers
docker-compose up
docker-composer up -d #To run in detached mode or background.


#To remove volumes and networks and stop all containers
docker-compose down
	
	
=================Docker Swarm=====================================
Why Orchestraitaion is needed?
----------------------------------------------
- To automate contianer life cycle
- Scale  out/up/in
- containre recreation if they failed
- replace container withhout downtime(blue/green deploy
- control/track where container s are running
- create cross node virtual network
- ensure only trusted servers run the containers
- store secrets keys password and get them to the right container (and only that container)?

--------------------------------------------------
v1.13 (2017) docker swarm/node/service/stack/secret
--------------------------------------------------
Docker Swarm components
Manager
 -API  -- accepts command from client and creates service object.
 -ORCHESTRATOR ---reconciliation loop for service objects and creates tasks
 -ALLOCATOR  --allocates ipaddress to tasks
 -SCHEDULER  --Assign nodes to tasks
 -DISPATCHER --checks in workers
NODE:
 -WORKER
 -EXECUTOR
 
 Architecuture:
Manager --> worker/node
 
---------------------------------------------------------------
----------------Docker swarm commands--------------------------

#To start Docker Swarm and make it a leader
docker swarm init

#To start the swarm service 
docker service <command> <image name>

==<command>=====desc==============================================
  create      #Create a new service
  inspect     #Display detailed information on one or more services
  logs        #Fetch the logs of a service or task
  ls          #List services
  ps          #List the tasks of one or more services
  rm          #Remove one or more services
  rollback    #Revert changes to a service's configuration
  scale       #Scale one or multiple replicated services
  update      #Update a service
=================================================================
===============running docker swarm on leader as node============
#To Create a web service
docker service create --name webserver -p 80:80 httpd:latest

#To see the services running and no of replicas..
docker service ls

#To see the status of the replicas like which node it is running..
docker service ps <id>
#or 
docker node ps

#To see service running on docker node 
docker node ps <node-name>

#TO See the services running on node
docker node ls

#To create the replicas to 3
docker service update <id> --replica 3 #ex: docker service update 8t877887t87t --replica 3
#or
docker service scale <id>=3 #ex: docker service update 8t877887t87t=3

#to update the docker service
docker service update --image <imagename:tag> <servicename>

#To update port no
docker service update --publish-rm 8080:80 --publish-add 9090:80

#To converge services automatically
docker service update --force <servicename>

#to rollback 
docker service rollback <id> #ex: docker service rollback 8t877887t87t

#To stop service
docker service rm <id>
#note: after creating replicas and if we try to stop container using command: docker container stop <dockerid>
#it will create the replicas automatically.
--------------------------------------------------------------------
====================================================================
===========running docker swarm on multiple nodes===================

#  Install docker on each node (best os to choose is ubuntu) Minimum no. of nodes should be 3
#  To install latest production version  release use the following comand.
    curl -sSL https:/get.docker.com/ | sh
#  after instllation , start service using command
    service docker start
# To check whether docker swarm running status.
    docker info | grep swarm -i
# TO start the docker service docker swarm init 
    docker swarm init --advertise-addr x.x.x.x  #(give ur machine public ip in place of x.x.x.x if nodes are on different network , if same network give private ip)
# To add another node as worker run the following command on node.
     docker swarm join --token SWMTKN-1-0ch9qaoavoknmp7mbyqyglpcxlh8u-4plhbu40pabr8mma9rvfjgnm8 x.x.x.x:2377
     #note: token generated will be different on ur machine. 
	 #on ur machine to get the token  run the below command on host machineonce you get the token run that command on node which we wanted to add.
	 docker swarm join-token manager
   
# To check whether node is added or not check it using the command on the host 
#  (where docker swarm init command is first executed. beacuase it will show data on only manger node.)
    docker node ls
# To Make node as manager
    docker node update --role manager <hostname>
	
#To check docker network 
docker network ls
#------------------------------------------------------------------
#NETWORK ID          NAME                DRIVER              SCOPE
#764bfb0d468b        bridge              bridge              local
#c72e898c5480        docker_gwbridge     bridge              local
#86ad4bba7820        host                host                local
#q6o1onevbwtn        ingress             overlay             swarm
#c13ea4e57d9f        none                null                local
#------------------------------------------------------------------
#here swarm is runnning on overlay networks

#To create overlay network 
docker network create --driver overlay front_end_network
docker network create --driver overlay backend_network

#to run a service on different overlay networks along with replicas 
docker service create --name webserver --network front_end_network -p 80:80 httpd:latest
#mounting db using name volume mount
docker service create --name mysqldb --mount type=volume, source=db-data, \
target=/var/lib/mysql/data --network backend_network mysql:latest

-------------------docker stack ------------------------------------
#to deploy multiple services at once production level
docker stack deploy -c docker-voting-stack.yml votingapp

#-----------------docker-voting-stack.yml------------------------
version: "3"
services:
  
  redis:
    image: redis
    ports:
      - "6379"
    networks:
      - frontend
    deploy: 
      replicas: 2
      update_config:
        parallelism: 2
        delay: 10s
      restart_policy:
        condition: on-failure
    
  db: 
    image: postgres:9.4
    volumes:
      - db-data:/var/lib/postgresql/data
    networks:
      - backend
    deploy:
      placement:
        constraints: [node.role == manager]
       
  vote:
    image: dockersamples/examplevotingapp_vote:before
    ports:
      - 5000:80
    networks:
      - frontend
    depends_on:
      - redis
    deploy:
      replicas: 2
      update_config: 
        parallelism: 2
      restart_policy: 
        condition: on-failure
    
  result:
    image: dockersamples/examplevotingapp_result:before
    ports:
      - 5001:80
    networks:
      - backend
    depends_on:
      - db
    deploy:
      replicas: 1
      update_config:
        parallelism: 2
        delay: 10s
      restart_policy:
        condition: on-failure
         
  worker:
    image: dockersamples/examplevotingapp_worker
    networks:
      - frontend
      - backend
    deploy:
      mode: replicated
      replicas: 1
      labels: [APP=VOTING]
      restart_policy:
        condition: on-failure
        delay: 10s
        max_attempts: 3
        window: 120s
      placement:
        constraints: [node.role == manager]
        
networks:
  frontend:
    driver: overlay
  backend:
    driver: overlay
    
volumes:
  db-data:
#-----------------------------------------------------------------------------

=======================docker secrets===============================
#adding notes in future
====================================================================

====================Docker Full app life cycle====================
docker-compose up # for dev
docker-compose up # for ci
docker stack deploy # for prodcution

========Private docker registry=================================
#Run the regisry image
docker container run -d -p 5000:5000 --name registry registry

#Re-tag existing image and push it to your new regisrty
docker  tag hello-world 127.0.0.1:5000/hello-world
docker push 127.0.0.1:5000/hello-world

#Remove that image from local cache and pull it from new registry.
docker image remove hello-world
docker image remove 127.0.0.1:5000/hello-world
docker pull 127.0.0.1:5000/hello-world

#recreate registry using a bind mount and see how it store data.
docker container run -d -p 5000:5000 --name registry -v $(pwd)/registry-data:var/lib/registry registry
