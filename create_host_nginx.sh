#!/bin/bash
# Fast way create virtual host for Nginx.
# 1) Don`t use symbol "_" for local domain name.
# 2) Open file `/etc/hosts` and string `#localhost` to the end of file.
# 3) Run script under root user: `sudo -s;sh create_host_nginx.sh domain-name.local`

new_site_name=$1
project_document_root="/var/www/html/$new_site_name"
nginx_site_available="/etc/nginx/sites-available/$new_site_name"
hosts_file="/etc/hosts"

echo "server {
	listen 80;
	listen [::]:80;
	root /var/www/html/$new_site_name;
	index index.php;
	server_name $new_site_name;
	access_log /var/log/nginx/$new_site_name.access.log;
	error_log /var/log/nginx/$new_site_name.error.log;

	location / {
		try_files \$uri \$uri/ =404;

		#fastcgi_pass unix:/var/run/php/php8.0-fpm.sock;
		fastcgi_index index.php;
    fastcgi_param   SCRIPT_FILENAME    \$document_root\$fastcgi_script_name;
    fastcgi_param   SCRIPT_NAME        \$fastcgi_script_name;
		include fastcgi_params;
	}    		
}" > $nginx_site_available

mkdir $project_document_root
chmod 777 -R $project_document_root
echo "your first page" > $project_document_root/index.php
chmod 777 -R $project_document_root/index.php

ln -s $nginx_site_available /etc/nginx/sites-enabled/

sed -i "/\#localhost/a127.0.0.1 $new_site_name" $hosts_file

service nginx restart
