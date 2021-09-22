Deploy role
=========

This role is used to deploy jsonservice app. 

Requirements
------------

Installed:
* Docker;
* Docker-compose.

Some features
-------------
* You can choose auto SSL generation by toggling <b>auto_ssl</b> variable from false to true;
* You also can set a passphrase for your automatically generated SSL key by toggling <b>ssl_passphrase</b> variable to true and write your pass in <b>passphrase</b>;
* And last but not least: you can use your personal keys and serts, just put them in [files/ssl](files/ssl) and your password for them in [ssl_password_file](files/ssl/keys/ssl_password_file) (if key are passwordless, just clear the **_ssl_password_file_**, but <b>DON'T</b> delete it). And of course you must name them as **_jsonservice.crt_** and **_jsonservice.key_**.

Role Variables
--------------

There are variables for this role in [<b>defaults/main.yml</b>](defaults/main.yml):
* <b>user</b> - you need to enter name of user on the remote vm/server.
* <b>app_dest</b> - destination of the app on the remote vm/server. It will be instlalled in /home/YOUR_USER/jsonservice by default.
* <b>address</b> - line in the Nginx server config file. You must enter your domain name or IP address of the remote vm/server.
* <b>size</b> - SSL key size.
* <b>auto_ssl</b> - this option allows you to choose between automatically genereated SSL key and cert and 
generated ones by yourself. Your key and cert must be located in [files/ssl](files/ssl) directory and named as **_jsonservice.crt_** and **_jsonservice.key_** and alse be passphraseless.
* <b>ssl_passphrase</b> - you can choose this to enable automatic generation of the SSL key with passphrase. 
* <b>passphrase</b> - this field is used for passphrase declaration. Cannot be empty when <b>ssl_passphrase</b> is <b>true</b>.
* <b>cipher</b> - you can choose cipher for SSL key.