## Dockerized Ansible playbook

This playbook version is used to deploy app with Docker. Less commands and interactions with Linux system. 

### Requirements:

1. Debian 10.10 or higher or Ubuntu on the targeted machine.

2. <b> Installed:</b>
   * Ansible, of course.
   * sshpass on Ansible-master machine. This ables Ansible to connect to the vm/server with password.
   * ssh on the targeted vm/server.
   * community.crypto.openssl_privatekey.

### Configuring the playbook and setup targeted machine

After installing requirements you must configure the playbook:

* #### There are two playboook files in main folder:
  * <b>main.ylm</b> - main playbook that is used to run roles;
  * <b>ping.ylm</b> - ping playbook for checking available hosts.

* #### And two config files:
  * <b>hosts.txt</b> - inside this file you must specify your targeted host address, user and his password;
  * <b>ansible.cfg</b> - in this file inventory file, host key checking, and python interpreter on the targeted machine are specified.

* #### Keys and certs:
   * You need to generate SSH keys and set path to the public one in [<b>roles/security/defaults/main.yml</b>](roles/security/defaults/main.yml).
   * You can read about SSL in [<b>roles/deploy/README.md</b>](roles/deploy/README.md).

* #### User on the vm/server:
   * You need to create an user on your vm/server and give him sudo rights. After that you must set his username in [<b>roles/deploy/defaults/main.yml</b>](roles/deploy/defaults/main.yml) and [<b>roles/security/defaults/main.yml</b>](roles/security/defaults/main.yml)

### Runnning the playbook

You can run the playbook with ```ansible-playbook main.yml --ask-become-pass``` command (and with ```--ask-vault-pass``` if you have an ectrypted with Ansible vault data). If everything is succeded, 
you will be able to open the service page in your browser on YOUR_ADDRESS:80 and YOUR_ADDRESS:443 and also curl to it.