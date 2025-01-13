docker compose -f $HOME/hardening_apache_ssl/docker-compose.yml up certbot
docker compose -f $HOME/hardening_apache_ssl/docker-compose.yml exec webserver apachectl -k graceful
docker compose -f $HOME/docker-compose.yml exec nginx nginx -s reload
