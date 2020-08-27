#!/bin/bash

echo  "Введите имя сайта"
read  sitename

echo  "Введите имя пользователя сайта $sitename"
read  username

mkdir -p /var/www/$sitename
useradd -d /var/www/$sitename -G sftpusers -s /bin/false $username
chown $username. -R /var/www/$sitename 

cat > /etc/php-fpm.d/$sitename.conf <<EOL

[$sitename]
user = $username
group = $username
listen = /run/php-fpm/php7.4-fpm.$username.sock
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

cat > /etc/nginx/conf.d/$sitename.conf <<EOL

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
        fastcgi_pass  unix:/run/php-fpm/php7.4-fpm.$username.sock;
        fastcgi_index index.php;
        fastcgi_param  SCRIPT_FILENAME  \$document_root\$fastcgi_script_name;
    }
    
	location ~* \.(jpeg|jpg|png|gif|bmp|ico|svg|tif|tiff|css|js|ttf|otf|webp|woff|txt|csv|rtf|doc|docx|xls|xlsx|ppt|pptx|odf|odp|ods|odt|pdf|psd|ai|eot|eps|ps|zip|tar|tgz|gz|rar|bz2) {
	expires      max;

           }

    listen 80;

}
EOL

cat > /etc/nginx/nginx.conf << EOL

user  nginx;
worker_processes  auto;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;


events {
        worker_connections 40000;
         multi_accept on;
}


http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '\$remote_addr - \$remote_user [\$time_local] "\$request" '
                      '\$status \$body_bytes_sent "\$http_referer" '
                      '"\$http_user_agent" "\$http_x_forwarded_for"';

    keepalive_timeout  30;
    keepalive_requests 100;

    client_max_body_size  1m;
    client_body_timeout 10;
    reset_timedout_connection on;
    send_timeout 2;
    sendfile on;
    tcp_nodelay on;
    tcp_nopush on;

    gzip on;
    gzip_disable "msie6";
    gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript application/javascript;

    open_file_cache max=200000 inactive=20s;
    open_file_cache_valid 30s;
    open_file_cache_min_uses 2;
    open_file_cache_errors on;

    include /etc/nginx/conf.d/*.conf;
}
EOL

systemctl restart nginx
systemctl restart php-fpm

echo "Полуить LE сертификат?[Y/y|N/n]:"
read   le


if [[ $le == "Y" || $le == "y" ]]; then
        certbot --nginx -d $sitename
else
        echo "Bye-bye"
	exit 1
fi

