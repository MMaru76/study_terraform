#!/bin/bash
yum -y install -y httpd
systemctl start httpd.service
echo "oreo" > /var/www/html/index.html