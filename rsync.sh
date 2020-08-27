#!/bin/bash

#$1 - ip адресс удаленного сервера
#$2 - локальный путь
#$3 - удаленный путь

if [ -z "$1" ]; then

which rsync || yum -y install rsync
Настройка
echo "Введите адрес удаленного сервера:"
read addr
echo "Введите имя пользователя:"
read user
echo "Введите пароль:"
read pass

cat /dev/zero | ssh-keygen -b 2048 -t rsa -q -N ""

pubkey=`cat ~/.ssh/id_rsa.pub`
#echo $pubkey

ssh $user@$addr "which rsync || yum -y install rsync"
ssh $user@$addr "echo $pubkey >> ~/.ssh/authorized_keys"
ssh $user@$addr "cat ~/.ssh/authorized_keys"

echo "Введите путь к директории для синхронизации:"
read way

echo "* * * * * root /root/rsync/rsync.sh $addr $way $way" >> /etc/crontab

mkdir -p /root/rsync/        
cp $0 /root/rsync/rsync.sh
chmod +x /root/rsync/rsync.sh

else

rsync -avz -e "ssh" $2 $1:$3

fi
