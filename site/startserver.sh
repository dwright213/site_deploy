#! /usr/bin/env bash

echo 'set log permissions'
chmod -R 666 /var/log

echo 'replace nginx configs'
ln -s /opt/site/current/configs/site_nginx.conf /etc/nginx/conf.d/

echo 'start nginx'
/etc/init.d/nginx start
nginx -t

echo 'run ansible stuff..'
ansible-playbook ansible/main.yml

echo 'start server'
/opt/site/current/venv/bin/uwsgi --ini /opt/site/current/configs/site_uwsgi.ini