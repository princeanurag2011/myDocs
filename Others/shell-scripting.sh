$0 #file name of the script
$1---9 # position of argument supplied to script.
$# #no. of arguments supplied to script.
$* # return all the argument s that are double quoted
$@ # return all the argument s that are induvidually double quoted.
$? # exit status of last command. if success return 0
$$ #process no. of current shell for shell script. 


'expr $a + $b'   #add
'expr $a - $b'   #sub
'expr $a / $b'   #divide
'expr $a \* $b'  #multiply
'expr $a % $b'  #modulus remainder calculation
a=$b # assigemnt operator
[$a==$b]
[$a!=$b]

-eq #=    [$a -eq $b]
-ne  
-gt
-lt
-ge
-le

#================================
! #boolean  not   [!false ]
-o #logical or    [$a -lt 20 -o $b -lt 100 ]
-a #logical and   [$a -lt 20 -a $b -lt 100 ]

#==============string============

[ $a = $b ]
[ $a != $b]
	[ -z$a ] #if zero length
	[ -n$a ] #if non-zero 
	[ $a ]   #if not empty

#============for==================
for var  in 0 1 2 3 4 5 6 7 8 9
do
 echo var
  done
#=====while=============================
a=0
while [ $a -lt 100 ]
do
echo $a
  $a=`expr $a + 1`  #` back quote
done

#==========if=============================
 if [ $a -eq $b ]
 then 
   echo $a
 elif [ $a -ne $b ]
 then 
   echo $b
 fi
 
#===============functions=====================

#!/bin/sh
#def function
create_user(){
	echo "Enter username:"
	read username
	useradd $username
	passwd $username
	return 10
}
#Invoke Function
create_user 
ret=$?

if [ ret == 10]
	 then 
	  echo "User with $username is created"
	 else
	  echo "error creating username.."
fi

create_root_user(){
	echo "Enter username:"
	read username
	useradd $username
	passwd $username
	echo "ansadmin ALL=(ALL) ALL" >> /etc/sudoers
    usermod -aG root $username
	return 10
}

make_root_user(){
  echo  
}

============================creating root user=================================================================
#!/bin/sh

echo "Enter username"
read username
useradd $username
passwd $username

echo "Do u want to make him root user? (y/n) : "
read flag
echo "$flag"
if [ "$flag" = "y" -o "$flag" = "Y" ]; then
   echo "making root user"
   echo "$username ALL=(ALL) ALL" >> /etc/sudoers
   usermod -aG root $username
   echo "welcome, $username, $username is now a root user."
  else
        echo "welcome, $username"
fi
echo "User creation succesfully done"
============================================================================================



