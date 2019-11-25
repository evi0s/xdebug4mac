FROM debian:10

MAINTAINER evi0s

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
	apt-get install wget curl net-tools vim \
	lsb-release gnupg telnet tree \
	ca-certificates apt-transport-https -y

RUN apt-get install mariadb-server -y

RUN apt-get install openssh-server -y

RUN apt-get update -y && \
	apt-get install apache2 php \
	inetutils-ping php-mysql php-gd php-curl \
	php-mbstring php-xml mcrypt php-xdebug -y

RUN useradd -m user -s /bin/bash && \
	echo "user:user" | chpasswd && \
	rm -f /var/www/html/index.html

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT /entrypoint.sh
