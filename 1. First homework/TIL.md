## Today I've learned
#### Hello there! 

This is my personal TIL. Here you can check my progress and something about my new knowledges.  
You can switch between days and weeks via simple navigation. You can also return to the first page by clicking on the week, and to the week from the name of the day. 

* ### [I. First week](#first-week)
* ### [II. Second week](#second-week)
* ### [III. Third week](#third-week)
* ### [IV. Fourth week](#fourth-week)
* ### [V. Fifth week](#fifth-week)
* ### [VI. Sixth week](#sixth-week)

## [Sixth week](#today-ive-learned) 

| Day   | Date |
| :-----------: | :-----------: |
|[Monday](#monday-04102021)| 04.10.2021 |
|[Tuesday](#tuesday-05102021)| 05.10.2021 |
|[Wednesday](#wednesday-06102021)| 06.10.2021 |
|[Thursday](#thursday-07102021)| 07.10.2021 |
|[Friday](#friday-08102021)| 08.10.2021 |
|[Saturday](#saturday-09102021)| 09.10.2021 |
|[Sunday](#sunday-10102021)| 10.10.2021 |

### [Sunday, 10.10.2021](#sixth-week)

<p>

* <b> Today I've learned some more about terraform: </b>
   * I've created variables and locals, and also I've added counts for my instances, NATs, subnets and AZs. Now template is very flexible and you can create different amounts of subnets, availability zones, disable or enable NATs for private instances and some more. Also CloudWatch alarms was added for every instance, so you will get messages if something is went wrong. Now there is only a wrapper-script I need to create for  my homework.

</p>

### [Saturday, 09.10.2021](#sixth-week)

<p>

* <b> Bastion host is a good thing, but Session Manager is much better! </b>
   * So, after some googling and thinking about access to the private subnets at first I've decided to create a bstion host. Everything  was good until I've tried to connect to my private instances. It was painfull. At first you need to connect by your key to the bastion host, then you need to copy the ssh key for the private instances and only after that you will be able to connect to your instances. Awful experience. 
   * Amazon introduced their SSM for that purpose. You are able to connect to the instances via Session Manager through AWS Console or AWS CLI. And only thing you need is to login to console or a pair of access keys for AWS CLI credentials. You can create them individually in IAM and configure rights, password resets and much more. I think this is much more usable and secure then classic bastion hosts.
 
</p>

### [Friday, 08.10.2021](#sixth-week)

<p>

* <b> Change of plans: </b>
   * Until today I thought that Ubuntu was a good idea, but it was not. Ubuntu image don't have pre-installed AWS tools and can't download from s3 by default and need some tune. There is Amazon Linux 2 image with this tools pre-intalled, Amazon Linux also allows you to update system and install Nginx server without NATs or Internet gateways.
* <b> Bastion host is in action now: </b>
   * I've created a bastion host so now I can connect to my private instances. My template is creating a pairs of SSH keys for my private instances and for the bastion host. After that I'm able to connect to my instances via SSH. It's not very convenience, but it works.

</p>

### [Thursday, 07.10.2021](#sixth-week)

<p>

* <b> Today I've created a template for my ubuntu machines: </b>
   * Now my machines is starting from private subnets with NAT gateways. They are installing the Nginx server and starting with it. But I had some problems with instance debugging. I'll try to create the bastion host for  my instances so I'll be able to connecto to them from the Internet. 

</p>

### [Wednesday, 06.10.2021](#sixth-week)

<p>

* <b> Today I've learned about databases from lession: </b>
   * There are few types of databases: filesystem, relative, graph, column, in memory, document-priented DBs, TimeSeries and key/value.
   * Learned about replication: physical and logical. You can physically copy database or logically by some filters and logic.
   Replication can be async, sync and supersync.
   * Learned about performance troubleshooting. Lector also give us few insteresting examples of real problems. Almost all of the problems is from devs or wrong database usage.
   * We can use Prometheus, system tools, logs, pdBadger and Explain.
   * Also for performance troubleshoots we can add more resources, use indexation, pgBouncer, analyse logic of requests and use denormalisation.
   * We can create different indexes for popular requests. It will increase speed of reading the database. With indexation you will need to download and process significantly less amount of  information instead as for full scanning without indexes.
   * Best practice for backups is to initiate a test backup operation. 

</p>

### [Tuesday, 05.10.2021](#sixth-week)

<p>

* <b> Today I've pushed my final version of the Docker container image to the Github. </b>
* <b> Today I've started to learn AWS and Terraform: </b>
   * Until today I've created my instances from AWS console by me own hands, but now I can write a Terraform template and launch my instances in less than a minute. IaC is a great thing. 

</p>


### [Monday, 04.10.2021](#sixth-week)

<p>

* <b>Today I've learned some more about networks:</b>
   * MAC address is a uniq indentificator of a network devices which is burned-in. Pools of MAC addresses are devided between each manifacturer.
   * VLAN allows to make isolated network segments and have 4096-2 VLANs. Every switch have a lookup table that contains information for each port about VLAN's MACs on them. 
   * On third level there is OSFP, IS-IS, BGP and MPLS routing protocols. Every device in the network is getting information about each other and then they are know how to connect. OSFP and IS-IS have very fast convergence, when BGP is not, but BGP can store much bigger amount of data.
   * Learned about troubleshooting: you must check every layer of OSI model from 7th to 1th.
   * Learned something about VPNs. There are two types of them: secure and tunnel. Secure VPN is encrypting established connection, while tunnels are not. 

</p>

## [Fifth week](#today-ive-learned) 

| Day   | Date |
| :-----------: | :-----------: |
|[Monday](#monday-27092021)| 27.09.2021 |
|[Tuesday](#tuesday-28092021)| 28.09.2021 |
|[Wednesday](#wednesday-29092021)| 29.09.2021 |
|[Thursday](#thursday-30092021)| 30.09.2021 |
|[Friday](#friday-01102021)| 01.10.2021 |
|[Saturday](#saturday-02102021)| 02.10.2021 |
|[Sunday](#sunday-03102021)| 03.10.2021 |

### [Sunday, 03.10.2021](#fifth-week)

<p>
  
* <b> Successfully reworked 3rd homework: </b>
   * Now it works so much better then before. I can make more and more features and enhancements, but it time to stop. Scrip is already works very good and it's the final version of him I've pushed today.
* <b> Also I've improved my Github script: </b>
   * Now script is exiting if there is no more pages to scan and I've secured my tmp files with the mktmp utility. Also did that for the Whois script. There is no problems now with it. I can finnaly start to work on the 7th and 8th homework. 
* <b> And continued conversation with my teammate: </b>
   * We are talking about our task and reviewing each others code, but we have absolutely different realisations of  our tasks. It much easier to work on something with discussing and debating.
  
</p>

### [Saturday, 02.10.2021](#fifth-week)

<p>

* <b> Completely reworked my 3rd homework: </b>
   * I've added special filter for the organization field, changed output and added some more options. Now it works much better and cleaner. Maybe tomorrow I'll end with it and my Github script and then I'll start to work with  Terraform homework. This one is seems really interesting because of real DevOps stuff starting here.
  
</p>

### [Friday, 01.10.2021](#fifth-week)

<p>
  
* <b> Continued to working on my docker container again! </b>
   * Instead of python:3.6-slim I've tried to use the python:3.6-alpine image for the first building stage and it worked out! Now my docker image is only 8.96 MB without the Gunicorn and 9.1 MB with it! 
* <b> And also continued to working on my Github script: </b>
   * I've almost completed my bash script and I've created the pull request and asked one of my collegue to review my code. I've also reviewed his. It was  very good collaboration, because we understood each other and started to discuss about our tasks. I've decided to rework my 3rd homewrok after it. It was incomplete, but I'll try to fix it.

</p>


### [Thursday, 30.09.2021](#fifth-week)

<p>
  
* <b> Continued to working on my docker container: </b>
   * Created the custom python app with my server and the Gunicorn server inside of it. Now I can compile my app up with the Gunicorn inside of it and put in the production. Size of my container slightly encreased from 9.63 MB to 9.76, but it doesn't really matter. 
* <b> Started to work on my Github script: </b>
   * Learned jq util and how to parse json with it. Very usable thing.
</p>
  
### [Wednesday, 29.09.2021](#fifth-week)

<p>

* <b> Basic cloud management tools: </b>
  * Learned about web UIs of the cloud consoles. They are very similar. Almost all of the features are available from the cloud consoles. Consoles allows to see logs, to monitoring and control services. 
  * AWS Cloud9 allows to create instance and test terraform templates. 
  * Programming CLI tools. They are allows to use tokens, env variables, to run commands in different formats and to parse results with the jq tool and create the output in json format. Or create a scripts to read and then remove snapshots and backups for example. 
  * Learned about conditional expressions for Terraform. 

</p>

### [Tuesday, 28.09.2021](#fifth-week)

<p>

* <b> Started to work on my docker container:</b>
  * I've achieved the 9.63 MB with building the app from python:3.9-slim and compiling it by pyinstaller and staticx. Now I want to create a version with the Gunicorn version inside it.

</p>

### [Monday, 27.09.2021](#fifth-week)

<p>
 
* <b>Learned about AWS networking:</b>
  *   Learned about Amazon VPC. VPC is a private cloud with severals availability zones. Zones contains subnets: private ones and public ones. Public ones are opened to the internet via internet subway and private ones only via NAT subway. 
  * Learned about VPC peering. It allows to connect VPCs one to another. Peereng can connect different VPC even between different accounts. For more than 2 VPCs you need to connect them one to another.
  * Learned about AWS Endpoints. It allows to connect to the S3 bucket straight-forward throught endpoint avoiding the internet. By that you can reduce costs for data transfer.
  * AWS Site-to-Site VPN. It allows to create connectivity between cloud and datacenter. You need to create a customer gateway for your router and virtual private gateway for a VPC, then create a VPN connection between them.
  * Almost the same actions for AWS Client VPN.
  * AWS Transit Gateway is created for big amounts of VPCs and clouds. It can connect all VPCs and datacenters. Also it can connect VPCs in different regions. 
  * AWS Direct Connect allows to connect secured connections between infrastructure and cloud.
  * AWS Route53 allows to register domains and to create hosted zones and connect them to the VPCs. Also it allows DNS routing between regions to the closest region for the requests and routing traffic to the healthy regions and latency-based routing. 

</p>

## [Fourth week](#today-ive-learned) 

| Day   | Date |
| :-----------: | :-----------: |
|[Monday](#monday-20092021)| 20.09.2021 |
|[Tuesday](#tuesday-21092021)| 21.09.2021 |
|[Wednesday](#wednesday-22092021)| 22.09.2021 |
|[Thursday](#thursday-23092021)| 23.09.2021 |
|[Friday](#friday-24092021)| 24.09.2021 |
|[Saturday](#saturday-25092021)| 25.09.2021 |
|[Sunday](#sunday-26092021)| 26.09.2021 |

### [Sunday, 26.09.2021](#fourth-week)

<p>

* <b> Yeah! I've deployed my bot on the AWS EC2 instance! </b>
   * So after the last lession I've decided to deploy my first Telegram bot on the AWS EC2. There was no problem with that. But next time I'll create my bot with the webhooks and deploy it with AWS Lambda, instead of EC2. There is no point of running the virtual machine for some simple telegram bot.
   * Also I've created an external file with bot and Github API token inside. There is no need to keep the token inside the code now. 

</p>

### [Saturday, 25.09.2021](#fourth-week)

<p>

* <b> Find out an interesting issue with my bot </b>
   * So, my bot have the state switching feature. Problem is with it. If one of the users will enter the "_/task choosing mode_" it will lead for another user to get in it too. Because of that I need to remember the state of bot mode for every user individually. For start command too.
   * And there is the problem with a Github API rate limit. I need to add an HTTP authentication method with OAuth token for my bot's API requests.   
* <b> And here is the solution! </b>
   * With every new update my bot will check for the user in my weird slice-based database (yeah). If there is no user bot will add him to the database and set for him **true botMode** status which means that the user is not in the "_/task choosing mode_" and **false startCommand** status which means that reply for the **/start** command will be different now for him. But if user in the database already bot will read the **botMode** bool value, same for the **startCommand**.
   * Also there is special functions for **botMode** status switching.

</p>

### [Friday, 24.09.2021](#fourth-week)

<p>

* <b> And problems with the playbooks again!</b>
   * My new _improved_ and _optimized_ algorith brokes the sources.list files on the Debian 11 and Ubuntu 20.04 beause of incorrect when conditions. Fixed it for sure now and tested on every disto.
* <b> Added the /start command for bot and some more:</b>
   * My bot now have the **/start** command. Even after the start you can use it, but my bot will not be happy about it, however he will remind you about commands.


</p>

### [Thursday, 23.09.2021](#fourth-week)

<p>

* <b> Some problems with the playbooks: </b>
   * Started to test my playbooks for sure again, but got an error on the Debian 10: I need to update the python3-pip package after installing it. Don't know why there is this error, because everything works fine until today. **Fixed it.**
   * Also I've improved and optimized the sources.list fixing algorithm. 
* <b> State switching for bot:</b>
   * So, I've decided to add an _"/task choosing mode"_ for my bot. The idea is that if you've sent the **/task** command without arguments, bot will able you to just enter the correct number of the homework and also will display possible variants in following manner: 
   ```You can choose one of these: 1,  2,  3,  4, ...``` You can exit this mode only by choose the correct number, or by using the **/cancel** command.

</p>

### [Wednesday, 22.09.2021](#fourth-week)

<p>

* <b> Working with Ansible and learning it again </b>
   * Added feature for my playbooks which allows you to generate an SSL keys aoutomatically with passphrace or without it, or just use your own keys and certs with and without passphrases. You need only to choose the right options and maybe add some files.
* <b> Started my Telegram bot! </b>
   * Finally I've registred my own bot with BotFather and for the first time I've launched it. Every of the commands works great, but I need to add some more features and interaction.

</p>

### [Tuesday, 21.09.2021](#fourth-week)

<p>

* <b> Learned about Golang cases </b>
   * Started to using the Golang switch with cases. For today there is only three: /git, /tasks, /task and default case with error of incorrect command. In future I will add some more and make my bot with more interesting interaction.

</p>

### [Monday, 20.09.2021](#fourth-week)

<p>

* <b> Finally! Good progress in bot development. </b>
   * Learned how to work with  Go slices and how to append to them, now I can create a slice list of my homework and links to them and print it.
   * Also progress in slice search and error handling. If you for some reason will enter an incorrect number of homework, my script will print an error and you will exactly know what is you doing wrong.

</p>

## [Third week](#today-ive-learned) 

| Day   | Date |
| :-----------: | :-----------: |
|[Monday](#monday-13092021)| 13.09.2021 |
|[Tuesday](#tuesday-14092021)| 14.09.2021 |
|[Wednesday](#wednesday-15092021)| 15.09.2021 |
|[Thursday](#thursday-16092021)| 16.09.2021 |
|[Friday](#friday-17092021)| 17.09.2021 |
|[Saturday](#saturday-18092021)| 18.09.2021 |
|[Sunday](#sunday-19092021)| 19.09.2021 |


### [Sunday, 19.09.2021](#third-week)

<p>

* <b> Small progress in Golang </b>
   * Tried to get a correct homework output, get some progress, but not much.

</p>

### [Saturday, 18.09.2021](#third-week)

<p>

* <b> Tested my playbook on Debian 11 and Ubuntu 20.04 </b> 
   * My playbooks is deploying correctly on these two OS. I've added checks for OS Distro and versions. 
* <b> Started on working on my HomeworkBot: </b>
   * Learned some Golang things. First time using this language, but undestand something.
   * Created a main logic of the bot and algorithms. Found out how to work with the Github API and read json from repos.

</p>

### [Friday, 17.09.2021](#third-week)

<p>

* <b> Almost completed my dockerized playbook: </b>
   * Everything is works fine, but I want to add an ability to generate an SSL keys and certs with Ansible during the process of the app deploying, also SSL keys and certs with the passphrase, which you'll be able to specify. 
* <b> Added the SSL support for dockerized Nginx server:</b>
   * So I just put the key and cert inside the container. I guess there is a better way to do that. 


</p>

### [Thursday, 16.09.2021](#third-week)

<p>
 
* <b>Yeah! Today I've successfully built a container with my app:  </b> 
   * So, as I expected, Gunicorn was the only choise. Container with my app and Gunicorn inside weights about 47.5 MB, not 90+ MB like before when I tried to put uWSGI inside.
   * Created a container with Nginx server inside and successfully launched it. Now my plan is to figure out the best way to use SSL with it.  

### [Wednesday, 15.09.2021](#third-week)

<p>

* Learned a little more about containers, Docker, VMs and orchestration from today's lesson, mostly about the namespaces. Most part of it I've already learned from <b>Cloud Native DevOps with Kubernetes</b> (I must end it, but homeworks are much more interesting)
* Started to working on dockerized version of my playbook. I've ended without success with building container with uWSGI inside beacuse of doubling the weight, I must try something else. Maybe, Gunicorn.

</p>

### [Tuesday, 14.09.2021](#third-week)

<p>

* Nothing really interesting about DevOps today:
   * Updated my bash script: added some better error handlings, error about lost connections because of the whois ping and the script now can store list of connections that was on the script startup.
   * Also created README for the script.
* Learned about some cool music from 60-70s Cambodia (check [this](https://youtu.be/i3QPTefh7bQ) out) and Khmer Rouge. Want a krama scarf now (because it looks cool). 

  
</p>


### [Monday, 13.09.2021](#third-week)

<p>

* <b>Continued to working on my Ansible playbook:</b>
   * I've added SSL and HTTPS support for my playbok. Also I'm using the Ansible vault for encrypting SSL keys and certs, so they are secured by password.
* <b>Learned more about Git from today's lesson</b>:
   * Git is a very useful and practical thing that allows to store project history and stages and to have access to them at any time.
   * Learned main git commands and their purpose.
   * Learned about Git Flow which allows to manage and extend projects.
   * Learned about branches, commits and pull requests.
</p>

## [Second week](#today-ive-learned) 

| Day   | Date |
| :-----------: | :-----------: |
|[Monday](#monday-06092021)| 06.09.2021 |
|[Tuesday](#tuesday-07092021)| 07.09.2021 |
|[Wednesday](#wednesday-08092021)| 08.09.2021 |
|[Thursday](#thursday-09092021)| 09.09.2021 |
|[Friday](#friday-10092021)| 10.09.2021 |
|[Saturday](#saturday-11092021)| 11.09.2021 |
|[Sunday](#sunday-12092021)| 12.09.2021 |

### [Sunday, 12.09.2021](#second-week)

<b> Nothing for my TIL today, just chillin' </b>

### [Saturday, 11.09.2021](#second-week)

<p>
 
* <b> Learned to create the local venv and to copy files. </b>
   * I've created the venv with required packages and copied the app files to the remote server! Now I need only to deploy the Nginx server and try to use the HTTPS protocol with it.
* <b> Learned to create new users and how to add the ssh keys with Ansible </b>
   *   Achived some cool results today. I've created a new user, added the ssh key and have disabled some unsequre things such as root login, password login and empty password login. 

</p>
 
### [Friday, 10.09.2021](#second-week)

<p>

* <b> Successfully deployed my app using uWSGI and Nginx web server </b>
   * Deployed my app with the uWSGI and the Nginx web server. This was not a hard task. Now i need to create an Ansible playbook that will install all the required apps and packages and then deploy my app.
* <b> Started to work with Ansible and learned some things by practice! </b>
   * Learned more from practical experience about playbooks. My first playbook is used to simply install the Nginx web server and nothing more. 

</p>
 
### [Thursday, 09.09.2021](#second-week)

<p>
 
* <b> Learned how to use exit codes in bash scripts. </b>
   * I've added many error messages to my script. Most of them is about incorrect options which was applied. 
* I think that my bash script is completed, but I want to add an option which will allow to show some info from dig about DNS.

</p>

### [Wednesday, 08.09.2021](#second-week)

<p>
 
* <b> Learned to work with cache! </b>
   * Significantly improved the speed of my script working for 250-300% just by creating a simple text file in which script is writing whois info and then using it to find the chosen paragraphs. That allows to display a message about the missing paragraphs which my script was unable to find in the whois respond.  
* <b> Learned something new about IDEs, new languages and compiling </b>
   * By myself i'm using the VS Code with many plugins. Light-weight and low processor and ram usage of the VS Code made me fall in love with it. Prevously i've used pyCharm, Intellij IDEA, but i had bad experince with using them on my Ubuntu machine: crashes, bad UI scaling (don't know why, but this is a very common problem), high ram and cpu usage.

</p>

### [Tuesday, 07.09.2021](#second-week)

<p>

* Learned stuff about bash scripting and built-in networking utilities like ss which allows to investigate sockets.
   * My bash script that is being created for the Third homework is able to work now with built-in ss utility instead of using the netstat and by that there is no more anoying message about root privileges. 
* Learned to create a custom options for bash scripts.
   * And have added many of them! For example, you can enter process name, paragraphs from whois, amount of the IPs processed and some more. 
  
</p>

### [Monday, 06.09.2021](#second-week)

<p>
 
* <b>Good news! My app will work on the single page!</b>
   * Learned some about data in the HTTP header. You can read information about a browser, its version, OS type and more useful data from header. Nothing new to me, but i didn't expect that I'll be able to use that in Python code. So now my app just reading the HTTP header data and if type of a browser is None, my app will respond only with a text message without loading the HTML page. It's obvious that if type is not None (for example, Firefox or Edge) it will load the HTML.  
* <b>Added new feature to my HTML page.</b>
   * At first in my HTML was only one button with a 'Send request' text in it and a toggle switch to the right. Now the text inside the button will change depending on the toggle switch position.
* Learned more details about SSH keys, Ansible vault and Ansible playbooks. I'll be writing my playbook from today now on.
  
</p>


## [First week](#today-ive-learned) 

| Day   | Date |
| :-----------: | :-----------: |
|[Monday](#monday-30082021)| 30.08.2021 |
|[Tuesday](#tuesday-31082021)| 31.08.2021 |
|[Wednesday](#wednesday-01092021)| 01.09.2021 |
|[Thursday](#thursday-02092021)| 02.09.2021 |
|[Friday](#friday-and-saturday-03092021-04092021)| 03.09.2021 |
|[Saturday](#friday-and-saturday-03092021-04092021)| 04.09.2021 |
|[Sunday](#sunday-05092021)| 05.09.2021 |

### [Sunday, 05.09.2021](#first-week)

<p>
 
* More about Python again:
   * Tried to design the app in the way that it can recieve curl requests and loading Web page if you use browser on the same address, but failed;
   * Learned about the interesting try/except stuff which allows me not to crash the app in <b>INTERNAL SERVER ERROR</b> with every wrong JSON input.
* Fixed some HTML and CSS stuff.
  
</p>


### [Friday and Saturday, 03.09.2021-04.09.2021](#first-week)

<p>
  
* <b>Python, HTML, CSS, JS</b>
   * Desined completely my Python app with Flask support and learned some new Python and Flask stuff;
   * Desined the web interface of my app. Web version will be available via 
  localhost/web. For example, you'll be able to send JSON requests from fancy-looking
  web interface and get replies right in it. Also you can chose HTTP method by using 
  a simple toggle switch.
   * Created very simple JS script which changes HTTP request method from GET to POST and backwards.
* Completely lost in the process of developmet and deployment of my simple app.
* Bought a very interesting pre-builded HP PC without a videocard and was very surprised about its unusual motherboard and PSU.
   * So, PSU supplies the motherboard only with 12V. I've never seen something like this before. Also PSU are 80 Plus Gold certified.
   * More interesting thing is about *3V and 5V. The motherboard converts 12V to *3V and 5V by herself and that means you need to connect
  your SATA HDD/SSD power cable in a special socket on the motherboard. 

</p>

### [Thursday, 02.09.2021](#first-week)

<p>
  
* Learned many interesting Python stuff and created my second Python [app](https://github.com/RainbowGravity/course/tree/main/*%20Second%20homework%20(WIP))!
   *  <b> And, yes, it works!</b> It is not finished yet, but basic functions works perfectly fine: if you send command like that: ```curl -XPOST -d '{"animal":"Anime catgirl", "sound":"nya", "count": 6}' -k https://localhost``` you will get this reply six times (because value of the "count" key equals 6): ``` Anime catgirl says nya ```
   * Also added <b>SSL keys</b> to the app, so it can work via HTTPS protocol. Of course, i didn't uploaded them to the Github beacuse of security and privacy. If you wanna test my app you can create self-signed keys by yoursef using the OpenSSL.
* Learned way more about Docker container building and deploying, so i've put my program into container and successfully deployed it. And it worked too!  
* Unfortinately, no <b> Cloud Native DevOps with Kubernetes</b> today, but i promise to finish it in next 2 days. Honestly.

</p>
  
### [Wednesday, 01.09.2021](#first-week)

<p> 
  
* This is getting to be a tradiditon, <b> Cloud Native DevOps with Kubernetes</b>!
   * <b> ConfigMap objects</b>: learned how to create the ConfigMap and Secret objects and how to import variables from them (you can import variables via env or envFrom or connect them as file), how to update pods after  new ConfigMap data. 
   * <b> Confidetial information</b>: learned about RBAC and passive encrypting of the etcd data.
   * <b> Managing of confidetial information</b>: learned about the encrypting data in VCS (you can put there encrypted data, but you need to update her manually (ecrypt and decrypt) which may lead to fatal issues if you forgot to encrypt files), remote encrypted data storage (apps will getting the decrypted data when they are deploying, but you need to develop the process of updating and logging the data) and using the special utilities of confidential data managing (you can monitoring atomatically updated logs, create UIDs and roles, but you need to add some instruments and update apps and services).
   * <b> Data encrypting</b>: learned about the Sops tool from Mozilla (this tool allows to encrypt and decrypt data like passwords or logins automatically via popular encrypting systems like the PGP).   
* Learned some Python stuff and Stalin's reprssions and purges.

 
</p>


### [Tuesday, 31.08.2021](#first-week)

<p> 
  
* And again, <b> Cloud Native DevOps with Kubernetes</b>:
   * <b> Container security</b>: principle of minimal privileges, why you need not to run processes inside a container as a root, how to ban root-privileged containers and why, how to give containers read-only rights, how to prevent privilege escalation, capabilities of containers and about security contexts and policies;
   * <b> Volumes</b>: learned about emptyDir (they are used by containers for data transfer between them) and Persistent volumes (for data storage), restart policies (you can change from Always to OnFailure) and imagePullSecrets (used for the private registry pulls).
   * <b> Managing pods</b>: more about labels and selectors (not really), about complicated selectors (they are used for advanced sorting), how to bring the pods together on a single node and how to prevent them to do so (hard/soft Affinity/antiAffinity).
   * <b> Pod controllers</b>: DaemonSet objects (DaemonSet are used to create only one replica of the pod on every single node), StatefulSet (used to run the pods in order), Cronjob  and Job-objects (Cronjob are used to run the Job-objects in ordered time, Job-objects are used to complete limited amount of tasks by limited amount of pods)
   * <b> Ingress Resources</b>: learned about the Ingress (load balancer which manages external connections to the services in a cluster), learned a little about Ingress controllers, Isito and Envoy.
* Learned more about the Github again, especially about the markdown syntax (URLs, paragraphs, links, tables, etc.)

</p>


### [Monday, 30.08.2021](#first-week)

<p>
  
* Learned something about Github and created my first repository.
* Continued to read and practicing with <b> Cloud Native DevOps with Kubernetes </b> and learned:
   * more kubectl commands, flags and their shortening, kubectx, kubens, how to work with jq and JSON files;
   * about imperative kubectl commands, generation and exporting of YALM files and compairing them;
   * how to work with logs, how to connect to a container, how to use busybox commands inside a container and how to add command shell into containers;
   * about contexts and namespaces and how to interact with them by kubectx and kubens apps.
   * more about containers and pods;
   * more about YALM manifests of a containers, "latest" tag using, checksums of a containers, image pull policies.
* On the first lesson i've learned today:
   * about DevOps engineers and their role in products life cycle;
   * about ways of products development: waterfall, icremetal, iterative, spiral and Agile.

</p>

