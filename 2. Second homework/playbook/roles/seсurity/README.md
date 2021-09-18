Security role
=========

This role is used to replace default Debian sources.list, update apt repositories, add an SSH key and disable rootlogin, password/paswordless login to the vm/server and then install the UFW and configure it. 

Role Variables
--------------

* <b>user</b> - you need to enter user name on the remote vm/server;
* <b>sshd</b> - name of the ssh daemon on the vm/server;
* <b>sshd_config</b> - path to the sshd_config file on the vm/server;
* <b>key_location</b> - you must enter the location of an SSH public key on your Ansible-master machine