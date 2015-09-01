# docker-php5-lemp

Download a working image from 

https://hub.docker.com/r/sumitk1/php56-lemp/

Or

```$ docker pull sumitk1/php56-lemp```

This is a dockerfile for projects that can be run on
- Centos7
- Nginx (nginx version: nginx/1.8.0)
- php-fpm (PHP 5.6.12)
- MySql (mysql Ver 14.14 Distrib 5.6.26)

To build an image - 
```bash
  $ git clone https://github.com/sumitk1/docker-php5-lemp.git
  $ cd docker-php5-lemp
  $ docker build -t test/php5-lemp:1.0 . 
```
To mount you project which is at `/srv/project_lemp_dir` this is how you start the container
```
  $ docker run -d -P -v /srv/project_lemp_dir:/srv/http --name  test/php5-lemp:1.0
```
