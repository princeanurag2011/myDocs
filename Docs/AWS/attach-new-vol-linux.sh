#REFER


https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html



#-------------------------------------------------------------
            #How to attach new EBS volumes 
#-------------------------------------------------------------

#To see all the attached volumes that are mounted and non mounted:
 lsblk
 #say ex: new vol name /dev/xvdf # -> here dev stands for device and xvda is name of the device
 
#To see all mounted volumes available along with its details of memory.
  df -h
#NOTE:
  #new volumes attached are raw volumes and we need to create file system in them before mounting and using them.
  
#To create file system in the newly attached volume.
  file -s /dev/xvdf
  
#To use the following volume we need to create a ext4 file system on the volume
   
   mkfs -t /dev/xvdf
   
#To create Mount point directory for the volume.( say /data1)
   mkdir /data1
  
#To Mount the volume 
   mount /dev/xvdf /data1

#To Check/see all mounted volumes available along with its details of memory.
   df -h
#To add this volume on every system reboot , add an entry in /etc/fstab

 #take backup of file system tables
    cp /etc/fstab /etc/fstab.original
 #Now add the new volume here in /etc/fstab by copying following code at the bottom
    /dev/xvdf /data1 ext4 defaults,nofail 0 0 
    
#-------------------------------------------------------------
            #How to detach  EBS volumes 
#-------------------------------------------------------------

 #To unmount the data volume:
   sudo umount -d /data1
 
 #TROUBLESHOOTING:
   #if we run the above command and it says target is busy. Then
   #To see the list of running process
     sudo lsof /data1
   #If we find any running process kill them using
      sudo kill 9 pid
   #Make all the process using it are killed before detaching it.
   #No try to unmount the volume
     sudo umount -d /data1
   
 #to check whether volume is detached 
    lsblk
    df -h
 #Now in aws we can detach the EBS by using detach volume . 

   
  
