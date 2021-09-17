## Dockerized Ansible playbook

This playbook version is used to deploy app with Docker. Less commands and interactions with Linux system. 

### Requirements:

1. Debian 10.10 or higher on the targeted machine. (Didn't tested this playbook on other distros, lol)
2. <b> Installed:</b>
   * sshpass on Ansible-master machine. This ables Ansible to connect to the vm/server with password.
   * ssh on the targeted vm/server.
3. <b> Keys and certs:</b>
   * Generated SSH keys and path to the public one in <b>roles/security/defaults/main.yml</b>.
   * You can read about SSL in <b>roles/deploy/README.md</b>.
4. <b> User on the vm/server: </b>
   * You need to create an user on your vm/server and give him sudo rights. After that you must to set his username in <b>roles/deploy/defaults/main.yml</b> and <b>roles/security/defaults/main.yml</b>

### Running the playbook

#### There are two playboook files in main folder:
  * main.ylm - main playbook that is used to run roles;
  * ping.ylm - ping playbook for available hosts.
#### And two config files:
  * hosts.txt - inside this file you must specify your targeted host address, user and his password;
  * ansible.cfg - in this file inventory file, host key checking, and python interpreter on the targeted machine are specified.
#### After configuring
You can run the playbook with ```ansible-playbook main.yml --ask-become-pass``` command. If everything is succeded, 
you will be able to open the service page in your browser on YOUR_ADDRESS:80 and YOUR_ADDRESS:443 and also curl to it.
 
