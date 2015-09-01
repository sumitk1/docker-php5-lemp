FROM centos:7
MAINTAINER Sumit Kumar <sumitk.85@gmail.com>

## Remi Dependency on CentOS 7 and Red Hat (RHEL) 7 ##
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
 
## CentOS 7 and Red Hat (RHEL) 7 ##
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

COPY ./etc/yum.repos.d/nginx.repo /etc/yum.repos.d/

RUN yum -y --enablerepo=remi,remi-php56 install nginx php-fpm php-common

RUN yum -y install php-mysql \
    && yum -y install php-cli \
    && yum -y install php-xml \
    && yum -y install tar wget \
    && yum -y install python-pip

RUN rpm -Uvh http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
RUN yum -y install mysql-community-server
RUN /usr/bin/systemctl enable mysqld

RUN yum -y install supervisor
RUN pip install supervisor-stdout

COPY ./etc/supervisord.conf /etc/

RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php-fpm.conf

#RUN sed -i 's/^listen.allowed_clients/;listen.allowed_clients/' /etc/php-fpm.d/www.conf && \

RUN mkdir -p /srv/http && \
    chown -R apache:apache /srv/http && \
    chown -R apache:apache /var/run/php-fpm

COPY ./site/index.php /srv/http/
COPY ./conf/nginx.conf /etc/nginx/

EXPOSE 9000 80
VOLUME /srv/http
COPY ./site/ /srv/http

COPY ./start.sh /start/
LABEL stack=LEMP5 
CMD sh /start/start.sh
