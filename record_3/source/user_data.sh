#!/bin/bash
yum install -y httpd
systemctl start httpd.service
ifconfig >> /var/www/html/index.html