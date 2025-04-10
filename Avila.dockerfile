# Usar una imagen base de Ubuntu
FROM ubuntu:latest

# Evitar prompts interactivos durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Instalar Apache, MySQL, PHP, git y rsync
RUN apt-get update && apt-get install -y \
    apache2 \
    mysql-server \
    php \
    libapache2-mod-php \
    php-mysql \
    git \
    rsync \
    && apt-get clean

# Clonar el repositorio de GitHub
RUN git clone --depth 1 https://github.com/NachoSKD/Solemne1.git /tmp/html

# Verificar los archivos clonados en /tmp/html (útil para depuración)
RUN ls -al /tmp/html

# Limpiar el directorio de Apache y mover los archivos HTML usando rsync
RUN rm -rf /var/www/html/* && rsync -a /tmp/html/ /var/www/html/

# Exponer el puerto 80
EXPOSE 80

# Iniciar Apache y MySQL al arrancar el contenedor
CMD service mysql start && apache2ctl -D FOREGROUND
