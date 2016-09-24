#! /usr/bin/env bash

echo 'replace nginx configs'
rm /etc/nginx/sites-enabled/default
ln -s /opt/site/current/configs/site_nginx.conf /etc/nginx/conf.d/
# /etc/init.d/nginx restart

echo 'start nginx'
/etc/init.d/nginx start
nginx -t

echo 'run ansible stuff..'
ansible-playbook ansible/main.yml

echo 'start server'
/opt/site/current/venv/bin/uwsgi --ini /opt/site/current/configs/site_uwsgi.ini