Deploy role
=========

This role is used to deploy jsonservice app. 

Requirements
------------

Installed:
* Docker;
* Docker-compose.

Role Variables
--------------

There are four variables for this role in [<b>defaults/main.yml</b>](defaults/main.yml):
* <b>user</b> - you need to enter name of user on the remote vm/server.
* <b>app_dest</b> - destination of the app on the remote vm/server. It will be instlalled in /home/YOUR_USER/jsonservice by default.
* <b>address</b> - line in the Nginx server config file. You must enter your domain name or IP address of the remote vm/server.
* <b>size</b> - SSL key size.
* <b>auto_ssl</b> - this option allows you to choose between automatically genereated SSL key and cert and 
generated ones by yourself. Your key and cert must be located in [files/ssl](files/ssl) directory and named as **_jsonservice.crt_** and **_jsonservice.key_** and alse be passphraseless.