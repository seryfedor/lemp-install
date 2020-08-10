#!/bin/bash

echo  "Введите имя сайта"
read  sitename

echo  "Введите имя пользователя сайта $sitename"
read  username

mkdir -p /var/www/$sitename
useradd -d /var/www/$sitename -s /bin/false $username
chown $username. -R /var/www/$sitename
usermod -a -G  nginx $username


cat > /etc/php-fpm.d/default.conf <<EOL

[$sitename]
user = $username
group = $username
listen = /run/php-fpm/php7.4-fpm.default.sock
listen.owner = $username
listen.group = $username
listen.mode = 0777
pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
php_admin_value[sendmail_path] = /usr/sbin/sendmail -t -i -f admin@$sitename
php_flag[display_errors] = On
php_admin_value[error_log] = /var/log/fpm7.4-php.$sitename.log
php_admin_flag[log_errors] = on
php_admin_value[memory_limit] = 512M
php_admin_value[date.timezone] ="Asia/Almaty"
php_admin_value[max_execution_time] = 10000
php_admin_value[upload_max_filesize] = 128M
php_admin_value[post_max_size] = 128M
php_admin_flag[short_open_tag] = On
EOL

cat > /etc/nginx/conf.d/default.conf <<EOL

server {

        access_log /var/log/nginx/$sitename-access.log;
        error_log /var/log/nginx/$sitename-error.log;

        root /var/www/$sitename;

        index index.php index.html index.htm ;

        server_name $sitename www.$sitename;

        location / {
                try_files \$uri \$uri/ /index.php?\$args;
        }

location ~ \.(php|htm|html|phtml)$ {
        try_files \$uri \$uri/ /index.php?\$query_string;
        include fastcgi_params;
        fastcgi_pass  unix:/run/php-fpm/php7.4-fpm.default.sock;
        fastcgi_index index.php;
        fastcgi_param  SCRIPT_FILENAME  \$document_root\$fastcgi_script_name;
    }
    
location ~* \.(jpeg|jpg|png|gif|bmp|ico|svg|tif|tiff|css|js|htm|html|ttf|otf|webp|woff|txt|csv|rtf|doc|docx|xls|xlsx|ppt|pptx|odf|odp|ods|odt|pdf|psd|ai|eot|eps|ps|zip|tar|tgz|gz|rar|bz2) {
	expires      max;

           }

    listen 80 default_server;

}
EOL

systemctl restart nginx
systemctl restart php-fpm

echo "Полуить LE сертификат?[Y/y|N/n]:"
read   le


if [[ $le == "Y" || $le == "y" ]]; then
        certbot --nginx --no-redirect -d $sitename
else
        echo "Bye-bye"
	exit 1
fi

