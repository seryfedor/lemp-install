#!/bin/bash
function setuser {
user=`ls -dl $way | awk -F [\ ] '{print substr($2,5),$3}'`

uid=`id $user | awk -F [=,\),\(] '{print substr($2,5),$2}'`
gid=`id $user | awk -F [=,\),\(] '{print substr($2,5),$5}'`

useradd -o -u $uid -g $gid -G sftpusers -d $way  -s /bin/false $newuser
echo $newuser:$pass | chpasswd

}

echo  "Enter username for NEW user:"
read  newuser
echo  "Enter password for $newuser:"
read   pass
echo  "Enter homedir for $newuser (default /var/www/default):"
read   way

if [ -z  "$way" ]; then
way="/var/www/default"
setuser

else

if [ ! -d "$way" ]; then
  echo "Directory $way not found"
  exit 1
else
    	setuser
fi
fi
