# Instrucciones para ejecutar el entorno multicontenedor

1. Modifica el fichero `env.example` con los valores de las variables y cambia el nombre a `.env`.

2. Cambia el nombre (sin .example) y modifica el fichero `dynu-credentials.ini.example` con tu API Key de [Dynu](https://www.dynu.com/). El contenido sería:

   ```ini
   dns_dynu_auth_token = XXXXXXXXXXX
   ```

   Cambia los permisos al fichero de credenciales:
   ```bash
   chmod 600 dynu-credentials.ini
   ```

3. Modifica los ficheros de configuración de los dos sitios en `./dockerfiles/nginx/config` con tu nombre de dominio de Dynu (`server_name`, `ssl_certificate`, `ssl_certificate_key`, `$host`):
   - En `blog.conf`, modifica `blog.iesalixar.freeddns.org` por `blog.tudominio.freeddns.org`.
   - En `iesalixar.conf`, modifica `iesalixar.freeddns.org` por `tudominio.freeddns.org`.

4. Ejecuta los contenedores con el comando:
   ```bash
   docker compose up -d
   ```

5. Comprueba cómo se genera el certificado Let's Encrypt:
   ```bash
   docker logs certbot
   ```

6. Comprueba el estado final de los contenedores:
   ```bash
   docker compose ps
   ```

7. En el equipo cliente, añade los nombres al fichero `/etc/hosts` asociados con la IP del servidor web. Si se trata del mismo equipo, puedes indicar `127.0.0.1` (localhost) en lugar de la IP.
   ```bash
   127.0.0.1	tudominio.freeddns.org
   127.0.0.1	blog.tudominio.freeddns.org
   ```

8. Accede con el navegador a la URL de ambos sitios:
   - [https://tudominio.freeddns.org](https://tudominio.freeddns.org)
   - [https://blog.tudominio.freeddns.org](https://blog.tudominio.freeddns.org)

9. Revisa en el navegador los detalles del certificado (el mismo para ambos nombres): 
   - **Validez**
   - **Emisor**
   - **Subject Alternative Name (SAN)**

   Comprueba que se trata de un certificado wildcard `*.tudominio.freeddns.org`.
   
11. Al finalizar, ejecuta el siguiente comando para parar y eliminar los contenedores y el volumen: 
    ```bash
    docker compose down -v
    ```



