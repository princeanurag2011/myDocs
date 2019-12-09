#To install docker 
sudo yum install docker -y

#To check the version after installing 
docker --version #or
docker version
#note: it will only give the client version if the docker service is not started.

#TO start the docker service 
service docker start

#To check the docker running status
service docker status

#note: if docker service is not running, then following commands wiil not work.

#To check the version after installing 
docker version
#note: after starting docker service , it shows both client and server versions.

#TO see list of images..
docker images 

#TO delete downloaded docker images.
docker rmi <imagename>

#To run image as a container 
docker run <image>

#To run nginx server image as a container 
docker run --publish 80:80 nginx  # --publish or -p 

#the above command hangs the console to avoid that , we can 
#run docker containre in detached mode.

#To run docker container in detached mode 
docker run -d -p 80:80 --name webserver nginx # -d or --detach 

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

#TO delete docker container
#stop the container , then use following command
docker rm <contianerId>
#other we willll get an error like can't stop running container.'

#TO delete docker container forcefully 
docker rm <container-id> -f
#TO delete multiple containers at a time ...  
docker rm <container-id> <container-id> <container-id>

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


#To see docker container stats.. (show details of all running ocntainer cpu mem utilization , block i/o network i/o)
docker stats

#To enter into container ubuntu (-i for interactiv mode and -t for TTY bash shell and this will create a new container)
docker run -it --name ubuntu <container-id> #example: docker run -it --name ubuntu 987ds7787dsd78s9as

#To enter into container other than ubunutu (here bash is mentioned because it is where we need to starts
#but for ubuntu no need to mention that , because it's default location)
docker run -it --name webserver <container-id> bash

# to enter into container wtihout creating a new container.
 docker exec -it <container-id> /bin/bash

#networking................
#TO see which ports are directing traffic to container from host.
docker port <container-id>












