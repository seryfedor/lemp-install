# lemp-install
### centos8-nginx+mariadb+php7.4 Install
- c8-depl.sh - установка окружения nginx+mariadb+php7.4  
- c8-depl-without-maria.sh - установка окружения nginx+php7.4
- default-site.sh - создание дефолтного конфига (nginx)
- site-create.sh - создание дополнительных сайтов(nginx).
- useradd.sh - Добавление sftp пользователей на севрер

Сайты располагаются в диретокрии /var/www/

# useradd.sh
Добавляет sftp пользователя в систему, без доступа к ssh. Создает домашнюю директорию в /var/www/users/$username
Монтрует директорию указанную при создании пользователя, **копируя ее привилегии!!!**, в домашнюю директорию.
Прописывает "mount --bind" в fstab.
Создает копию (с датой) fstab в /root/backup/*

# site-create.sh
Ничего интeресного, кладет конфиги в /etc/nginx/conf.d
