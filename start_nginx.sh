#!/bin/bash
docker run -d --restart always --name nginx1 -p 80:80 -v /home/andrew/Knowledge-Base/sources/WebDev/edu:/usr/share/nginx/html nginx
