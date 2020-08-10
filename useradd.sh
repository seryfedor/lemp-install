#!/bin/bash
budate=`date '+%Y-%m-%d'`
function setuser {
user=`ls -dl $way | awk -F [\ ] '{print substr($2,5),$3}'`

uid=`id $user | awk -F [=,\),\(] '{print substr($2,5),$2}'`
gid=`id $user | awk -F [=,\),\(] '{print substr($2,5),$5}'`


sway=`echo "$way" | rev | cut -d / -f 1 | rev`
subway=/var/www/users/$newuser/$sway

mkdir -p $subway
useradd -o -u $uid -g $gid -G sftpusers -d /var/www/users/$newuser  -s /bin/false $newuser
echo $newuser:$pass | chpasswd
chown $newuser.  $subway
mount --bind $way $subway
cp /etc/fstab /root/backup/fstab-$budate
echo "$way                $subway               none    bind            0 0" >> /etc/fstab
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
