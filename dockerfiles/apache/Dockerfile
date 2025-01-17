# Partimos de la imagen base de Ubuntu
FROM ubuntu:latest

# Actualizamos los paquetes e instalamos apache2 php mod_security git mod_evasive
RUN apt update && \
	apt -y upgrade && \ 
	apt -qq -y install apache2 \ 
	php libapache2-mod-php \ 
	libapache2-mod-security2 git libapache2-mod-evasive

# Activamos el modulo mod_security
RUN a2enmod security2

# Copiamos a la imagen el fichero de configuracion de mod_security
COPY ./config/modsecurity.conf /etc/modsecurity/modsecurity.conf

# Actualizamos las reglas del OWASP para ModSecurity y las habilitamos en Apache
RUN rm -rf /usr/share/modsecurity-crs && \
git clone https://github.com/coreruleset/coreruleset /usr/share/modsecurity-crs && \
mv /usr/share/modsecurity-crs/crs-setup.conf.example /usr/share/modsecurity-crs/crs-setup.conf
COPY ./config/security2.conf /etc/apache2/mods-available/security2.conf

# Copiamos a la imagen el fichero de configuracion global y security.conf
COPY ./config/apache2.conf /etc/apache2/apache2.conf
COPY ./config/security.conf /etc/apache2/conf-available/security.conf

# Copiamos a la imagen el fichero de configuracion del virtualhost
COPY ./config/iesalixar.conf /etc/apache2/sites-available/iesalixar.conf

# Activamos el modulo headers y ssl
RUN a2enmod headers
#RUN a2enmod ssl

# Creamos el directorio raiz del sitio y lo activamos
RUN rm -rf /var/www/html
WORKDIR /var/www
RUN git clone https://github.com/iesalixar/alixar-blue-team-webpage.git iesalixar && \
	chmod 711 /var/www/iesalixar
RUN a2dissite 000-default && a2ensite iesalixar

#Desactivamos el modulo autoindex
RUN a2dismod -f autoindex

# Cambio de propietario de los directorios en los que apache necesita escribir
RUN chown -R www-data:www-data \
 /var/run/apache2 /var/lock/apache2 /var/log/apache2
WORKDIR /var/www/iesalixar
USER www-data


# El contenedor escucha en los puertos TCP 80 y 443
EXPOSE 80 443

# Arrancamos el servidor web
CMD ["apachectl", "-D", "FOREGROUND"]
