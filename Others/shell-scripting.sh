#!/bin/bash
#Above line is callled SHEBANG line. it specifies where to run the sricpt
#====VARIABLES=======================================
#-----------invalid variable-----------------------

MY-NAME='Anurag'  #invalid variable
46MY_NAME='Anurag' #invalid variable
MY_NAME = 'Anurag' #invalid variable

#-----------valid variable-----------------------
ID=0000
MY_NAME='Anurag' #valid variable
MY_id=25  #valid variable
_my_name_='Anurag' #valid variable
hostName=$(hostname)  #echo $hostName gives the host name
hostName=`hostname` #echo $hostName gives the host name
hostName='hostname' #echo $hostName gives the text 'hostname'
my_id=$(uid) 
my_id=$ID

echo "My name is $MY_NAME and my password is ${MY_NAME}02120  and id is $my_id";



#----------------------------MATH---------------------------------------------------------
a=10
b=20

#note this special charecter '  is single quote and this special charecter ` is backquote.
# in the below code we used backquote.
`expr $a + $b`   #add 
`expr $a - $b`   #sub
`expr $a / $b`   #divide
`expr $a \* $b`  #multiply
`expr $a % $b`  #modulus remainder calculation
a=$b # assigemnt operator
[ $a==$b ]
[ $a!=$b ]
-----------------------logic----------------

-eq # equal =    [ $a -eq $b ]
-ne  # not equal !=
-gt  # >
-lt   # <
-ge # >=
-le # <=

#================================
! #boolean  not   [!false ]  
-o #logical OR      [$a -lt 20 -o $b -lt 100 ]
-a #logical AND   [$a -lt 20 -a  $b -lt 100 ]

&&  #logical AND
||     #logical OR

#example: 
HOST="google.com"
  ping -c 1 HOST   && echo "$HOST reachable"    #both statements will be executed. 
  ping -c 1 HOST   ||  echo "$HOST unreachable"  #only one of the two will work. 

#=============FILE======================
FILE1=/etc/hosts
FILE2=/home/anurag/1.txt
[ -e /etc/hosts ]                 #here 'hosts' is a file 
[ -e /home/anurag/1.txt]  #here '1.txt' is the file.
[ -e FILE1 ] 
[ -e FILE2 ] 
-e    #to check file exists
-r    #to check whether  file is readable
-w   #to check whether  file is readable
-x    #to check whether  file is executable
-d   #to check whether  file is directory
-f    #to check whether  file exists and is regular file
-s    #to check whether  file exists and is not empty

#==============string============
a="HELLO"
b=""

[ $a = $b ]  #To check whether string is empty
[ $a != $b]  #To check whether string is empty 
[ -z $a ]       #To check whether string is empty
[ -n $a ]       #To check whether string is not- empty 
[ $a ]           #if not empty

#============case==========================

================special======================
#file name of the script
    $0
# position of argument supplied to script.
    $1---9 
#no. of arguments supplied to script.
    $#
# return all the argument s that are double quoted
    $*
# return all the argument s that are induvidually double quoted.
    $@
# exit status of last command. if success return 0
    $?
#process no. of current shell for shell script.
   $$ 
=======================================

#Example:1

case "$1" in
  start)
      /usr/sbin/sshd
    ;;
    stop)
      kill $(cat /var/run/sshd.pid)
      ;;
         *)
      echo "Usage:  $0  start | stop" ; exit 1
      ;;
  esac    

#Example:2

case "$1" in
  start | START)
    /usr/sbin/sshd
    ;;
    stop | STOP)
      kill $(cat /var/run/sshd.pid)
      ;;
         *)
      echo "Usage:  $0  start | stop" ; exit 1
      ;;
  esac    

#Example:3 
read -p "Enter y or n :"  ANSWER
case "$ANSWER" in
    [yY] | [yY] [eE] [sS] )
            echo "yes"
        ;;
      [nN] | [nN] [oO] )
          echo "no"
        ;;
           *)
          echo "Invalid answer"
        ;;
  esac

#==========if=============================
#EXAMPLE-1:
    
 if [ $a -eq $b ]
 then 
   echo $a
 elif [ $a -ne $b ]
 then 
   echo $b
 fi

#EXAMPLE-2:

MY_AGE=18;
if [ MY_AGE -lt 14 -a  MY_AGE -ge 3]
  then
  echo "your age is ${MY_AGE}, GO TO SCHOOL"
elif [ MY_AGE -ge 14  -a MY_AGE -lt 18]
  then 
    echo "your age is ${MY_AGE}, GO TO COLLEGE"
 elif [MY_AGE -ge 18 -a MY_AGE -lt 21  ] 
  then  
    echo "your age is ${MY_AGE}, eligible to apply driving license"
  elif [ MY_AGE -lt 3] 
   then
     echo "your age is ${MY_AGE}, Go to nursery"
   else
    echo "your age is ${MY_AGE}, You are major now" 
 fi
#============for==================
for var  in 0 1 2 3 4 5 6 7 8 9
do
 echo var
 done

#Example-3 rename pictures in a directory
PICTURES=$(ls *jpg)
DATE=$(date +%F)
for picture in PICTURES
  do 
    echo "renaming pictures started.. "
    echo "renaming $picture  to ${DATE}-${picture} . "  
    mv $picture ${DATE}-${picture}
  done
 
 #Example-2  - print 100 natural numbers

#=====while=============================
a=0
while [ $a -lt 100 ]
 do
   echo $a
   a=`expr $a + 1`  #` back quote
 done


 
#===============functions=====================

#!/bin/sh
#def function
create_user(){
  echo "Enter username:"
  read username
  useradd $username
  passwd $username
  return 0
}
#Invoke Function
create_user 
ret=$?    #return status of last function

if [ ret == 0]
   then 
      echo "User with $username is created"
   else
      echo "error creating username.."
fi

create_root_user(){
  echo "Enter username:"
  read username
  # read -p "Please enter your username: " username
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
#save this filename as createUser.sh
# $0 gives the current file name
echo "  Executing script   $0"
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
----------------WILDCARDS------------------------------

?.txt to match one char
*.txt to match all chars

*
?
[]
[0-3]

[[:alpha:]]
[[:alnum:]]
[[:digit:]]
[[:lower:]]
[[:space:]]
[[:upper:]]

\   escape char
*\? match all that ends with ?

cp *.html /var/www/html/
-------------------------------------------------------------------

