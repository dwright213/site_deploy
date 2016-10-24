#! /usr/bin/env bash

echo 'Make some log files'
touch /var/log/site_uwsgi.log
touch /var/log/access.log
mkdir /var/log/nginx/
touch /var/log/nginx/access.log
touch /var/log/nginx/error.log

echo 'replace nginx configs'
rm /etc/nginx/sites-enabled/default
ln -s /opt/site/current/configs/site_nginx.conf /etc/nginx/conf.d/

echo 'start nginx'
/etc/init.d/nginx start
nginx -t

echo 'run ansible stuff..'
ansible-playbook main.yml

echo 'start server'
/opt/site/current/venv/bin/uwsgi --ini /opt/site/current/configs/site_uwsgi.ini