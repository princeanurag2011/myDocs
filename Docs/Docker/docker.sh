yum install docker
docker image hello-world
docker image
docker run hello-world
docker ps #to see running contaiers
docker ps -a #to see stopped containers
docker rm hashcode #to remove container
docker run ubuntu:14.04 echo "Hello world"
docker run ubuntu:14.04 ps ax  #one more container
docker run -i -t ubuntu:14.04  # to start container and  enter into docker.   -i std i/o  -t root terminal
docker rmi #to remove images.
docker attach hashcode #to go back to docker.
#shortcut to exit from docker without stopping docker container(ctrl +p +q)


#running centos in detached mode.
 docker run -d centos:7 ping 127.0.0.1 -c 30
 docker logs #hashcode container id
 
 docker logs -f hascode #in plce of hash code give container id 
 
 docker run  -d  -P tomcat:7
 
 #to stop all images 
 docker stop $(docker ps -q)
 #to remove all images 
 docker rm  $(docker ps -a -q)
 
 #to build an image
 docker build -t abcd:1.0 .
 # to enter into bash  when bash is not available
 docker exec -it containerid /bin/bash
 
 
 docker push princeanurag2011/myproject:tagname
 
 
 #TO start container without entering into docker images..
  docker run  -d  -p 80:80 nginx:1.0 
  
  #to start apache in centos7
  CMD ["usr/sbin/httpd" , "k", "start"]
  
  #to start apache in centos7 
  CMD ["usr/sbin/httpd" , "-D", "FOREGROUND"]
  
  #to find Ip address of the container
  dcoker inspect containerid | grep IPAddress
  
  
  
  #overriding proxy through docker file.
  copy proxy.conf /etc/httpd/conf.d
  
  
  
  #install dockr compose
  http://docs.docker.com/compose/install
  
  sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  
  sudo chmod +x /usr/local/bin/docker-compose
  
  sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
  
  docker-compose --version
  
  #to run docker compose file
  docker-compose up -d
  
  
  
  