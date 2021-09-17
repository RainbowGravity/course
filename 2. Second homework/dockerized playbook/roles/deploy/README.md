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

There are three variables for this role in <b>defaults/main.yml</b>:
* <b>user</b> - you need to enter user name on the remote vm/server.
* <b>app_dest</b> - destination of the app on the remote vm/server. It will be instlalled in /home/YOUR_USER/jsonservie by default.
* <b>address</b> - line in the Nginx server config file. You must enter your domain name or IP address of the remote vm/server.
