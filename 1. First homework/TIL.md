## Today I've learned
#### Hello there! 

This is my personal TIL. Here you can check my progress and something about my new knowledges.  
You can switch between days and weeks via simple navigation. You can also return to the first page by clicking on the week, and to the week from the name of the day.

* ### [1. First week](#first-week)
* ### [2. Second week](#second-week)

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
 
1. <b> Learned to create the local venv and to copy files. </b>
   * I've created the venv with required packages and copied the app files to the remote server! Now I need only to deploy the Nginx server and try to use the HTTPS protocol with it.
2. <b> Learned to create new users and how to add the ssh keys with Ansible </b>
   *   Achived some cool results today. I've created a new user, added the ssh key and have disabled some unsequre things such as root login, password login and empty password login. 

</p>
 
### [Friday, 10.09.2021](#second-week)

<p>

1. <b> Succesfully deployed my app using uWSGI and Nginx web server </b>
   * Deployed my app with the uWSGI and the Nginx web server. This was not a hard task. Now i need to create an Ansible playbook that will install all the required apps and packages and then deploy my app.
2. <b> Started to work with Ansible and learned some things by practice! </b>
   * Learned more from practical experience about playbooks. My first playbook is used to simply install the Nginx web server and nothing more. 

</p>
 
### [Thursday, 09.09.2021](#second-week)

<p>
 
1. <b> Learned how to use exit codes in bash scripts. </b>
   * I've added many error messages to my script. Most of them is about incorrect options which was applied. 
2. I think that my bash script is completed, but I want to add an option which will allow to show some info from dig about DNS.

</p>

### [Wednesday, 08.09.2021](#second-week)

<p>
 
1. <b> Learned to work with cache! </b>
   * Significantly improved the speed of my script working for 250-300% just by creating a simple text file in which script is writing whois info and then using it to find the chosen paragraphs. That allows to display a message about the missing paragraphs which my script was unable to find in the whois respond.  
2. <b> Learned something new about IDEs, new languages and compiling </b>
   * By myself i'm using the VS Code with many plugins. Light-weight and low processor and ram usage of the VS Code made me fall in love with it. Prevously i've used pyCharm, Intellij IDEA, but i had bad experince with using them on my Ubuntu machine: crashes, bad UI scaling (don't know why, but this is a very common problem), high ram and cpu usage.

</p>

### [Tuesday, 07.09.2021](#second-week)

<p>

1. Learned stuff about bash scripting and built-in networking utilities like ss which allows to investigate sockets.
   * My bash script that is being created for the Third homework is able to work now with built-in ss utility instead of using the netstat and by that there is no more anoying message about root privileges. 
2. Learned to create a custom options for bash scripts.
   * And have added many of them! For example, you can enter process name, paragraphs from whois, amount of the IPs processed and some more. 
  
</p>

### [Monday, 06.09.2021](#second-week)

<p>
 
1. <b>Good news! My app will work on the single page!</b>
   * Learned some about data in the HTTP header. You can read information about a browser, its version, OS type and more useful data from header. Nothing new to me, but i didn't expect that I'll be able to use that in Python code. So now my app just reading the HTTP header data and if type of a browser is None, my app will respond only with a text message without loading the HTML page. It's obvious that if type is not None (for example, Firefox or Edge) it will load the HTML.  
2. <b>Added new feature to my HTML page.</b>
   * At first in my HTML was only one button with a 'Send request' text in it and a toggle switch to the right. Now the text inside the button will change depending on the toggle switch position.
3. Learned more details about SSH keys, Ansible vault and Ansible playbooks. I'll be writing my playbook from today now on.
  
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
 
1. More about Python again:
   * Tried to design the app in the way that it can recieve curl requests and loading Web page if you use browser on the same address, but failed;
   * Learned about the interesting try/except stuff which allows me not to crash the app in <b>INTERNAL SERVER ERROR</b> with every wrong JSON input.
2. Fixed some HTML and CSS stuff.
  
</p>


### [Friday and Saturday, 03.09.2021-04.09.2021](#first-week)

<p>
  
1. <b>Python, HTML, CSS, JS</b>
   * Desined completely my Python app with Flask support and learned some new Python and Flask stuff;
   * Desined the web interface of my app. Web version will be available via 
  localhost/web. For example, you'll be able to send JSON requests from fancy-looking
  web interface and get replies right in it. Also you can chose HTTP method by using 
  a simple toggle switch.
   * Created very simple JS script which changes HTTP request method from GET to POST and backwards.
2. Completely lost in the process of developmet and deployment of my simple app.
3. Bought a very interesting pre-builded HP PC without a videocard and was very surprised about its unusual motherboard and PSU.
   * So, PSU supplies the motherboard only with 12V. I've never seen something like this before. Also PSU are 80 Plus Gold certified.
   * More interesting thing is about 3.3V and 5V. The motherboard converts 12V to 3.3V and 5V by herself and that means you need to connect
  your SATA HDD/SSD power cable in a special socket on the motherboard. 

</p>

### [Thursday, 02.09.2021](#first-week)

<p>
  
1. Learned many interesting Python stuff and created my second Python [app](https://github.com/RainbowGravity/course/tree/main/2.%20Second%20homework%20(WIP))!
   *  <b> And, yes, it works!</b> It is not finished yet, but basic functions works perfectly fine: if you send command like that: ```curl -XPOST -d '{"animal":"Anime catgirl", "sound":"nya", "count": 6}' -k https://localhost``` you will get this reply six times (because value of the "count" key equals 6): ``` Anime catgirl says nya ```
   * Also added <b>SSL keys</b> to the app, so it can work via HTTPS protocol. Of course, i didn't uploaded them to the Github beacuse of security and privacy. If you wanna test my app you can create self-signed keys by yoursef using the OpenSSL.
2. Learned way more about Docker container building and deploying, so i've put my program into container and succesfully deployed it. And it worked too!  
3. Unfortinately, no <b> Cloud Native DevOps with Kubernetes</b> today, but i promise to finish it in next 2 days. Honestly.

</p>
  
### [Wednesday, 01.09.2021](#first-week)

<p> 
  
1. This is getting to be a tradiditon, <b> Cloud Native DevOps with Kubernetes</b>!
   * <b> ConfigMap objects</b>: learned how to create the ConfigMap and Secret objects and how to import variables from them (you can import variables via env or envFrom or connect them as file), how to update pods after  new ConfigMap data. 
   * <b> Confidetial information</b>: learned about RBAC and passive encrypting of the etcd data.
   * <b> Managing of confidetial information</b>: learned about the encrypting data in VCS (you can put there encrypted data, but you need to update her manually (ecrypt and decrypt) which may lead to fatal issues if you forgot to encrypt files), remote encrypted data storage (apps will getting the decrypted data when they are deploying, but you need to develop the process of updating and logging the data) and using the special utilities of confidential data managing (you can monitoring atomatically updated logs, create UIDs and roles, but you need to add some instruments and update apps and services).
   * <b> Data encrypting</b>: learned about the Sops tool from Mozilla (this tool allows to encrypt and decrypt data like passwords or logins automatically via popular encrypting systems like the PGP).   
2. Learned some Python stuff and Stalin's reprssions and purges.

 
</p>


### [Tuesday, 31.08.2021](#first-week)

<p> 
  
1. And again, <b> Cloud Native DevOps with Kubernetes</b>:
   * <b> Container security</b>: principle of minimal privileges, why you need not to run processes inside a container as a root, how to ban root-privileged containers and why, how to give containers read-only rights, how to prevent privilege escalation, capabilities of containers and about security contexts and policies;
   * <b> Volumes</b>: learned about emptyDir (they are used by containers for data transfer between them) and Persistent volumes (for data storage), restart policies (you can change from Always to OnFailure) and imagePullSecrets (used for the private registry pulls).
   * <b> Managing pods</b>: more about labels and selectors (not really), about complicated selectors (they are used for advanced sorting), how to bring the pods together on a single node and how to prevent them to do so (hard/soft Affinity/antiAffinity).
   * <b> Pod controllers</b>: DaemonSet objects (DaemonSet are used to create only one replica of the pod on every single node), StatefulSet (used to run the pods in order), Cronjob  and Job-objects (Cronjob are used to run the Job-objects in ordered time, Job-objects are used to complete limited amount of tasks by limited amount of pods)
   * <b> Ingress Resources</b>: learned about the Ingress (load balancer which manages external connections to the services in a cluster), learned a little about Ingress controllers, Isito and Envoy.
2. Learned more about the Github again, especially about the markdown syntax (URLs, paragraphs, links, tables, etc.)

</p>


### [Monday, 30.08.2021](#first-week)

<p>
  
1. Learned something about Github and created my first repository.
2. Continued to read and practicing with <b> Cloud Native DevOps with Kubernetes </b> and learned:
   * more kubectl commands, flags and their shortening, kubectx, kubens, how to work with jq and JSON files;
   * about imperative kubectl commands, generation and exporting of YALM files and compairing them;
   * how to work with logs, how to connect to a container, how to use busybox commands inside a container and how to add command shell into containers;
   * about contexts and namespaces and how to interact with them by kubectx and kubens apps.
   * more about containers and pods;
   * more about YALM manifests of a containers, "latest" tag using, checksums of a containers, image pull policies.
3. On the first lesson i've learned today:
   * about DevOps engineers and their role in products life cycle;
   * about ways of products development: waterfall, icremetal, iterative, spiral and Agile.

</p>

