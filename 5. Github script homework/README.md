# Github open pull requests script
## About
This script is used for Github repository open PRs scanning.
Script is sending requests to the Github api and then parsing the json response from it with jq utility. Script can work with and without OAuth token.

## Requirements
* installed <b>curl</b> utility;
* installed <b>jq</b> utility.
* make sure you have the <b>column</b> utility too (but i don't think that you will use it on minimal distro).

## Features 
There are some useful features in this script:
* Script can take and process not only links like ```https://github.com/jackfrued/Python-100-Days```, but you can enter it like ```jackfrued/Python-100-Days``` even with ```/``` at the begginning or at the end of the line or even in both cases at the same time. 
* Script can take and process even only the username! For example, you can enter the ```spring-projects``` and you will get the list of repositories with stars and discriptions.
* The script can take the number of repos displayed per page and the page number. You can skip it and use defaults for repository list and for PRs list by pressing the enter or by using options. 
* In repository PRs section you will be able to see information about most productive contributors and their profile links and open PRs with the titles, lables and links to them too.
## Options
Script have many options which you can use:
* <b>-p</b> - page number (not amount) for script to scan. Example of use: ```-p10``` for 10th page or ```-pn``` to skip questions about pages during script working and use the default number (1).
Some users may have more than 100 repos as some repositories may have more than 100 PRs. The limit of the Github API to display their amount per page is 100. You can use it to specify the page. <b>By specifying it as option you will apply it to repositories list and open PRs list!</b>
* <b>-c</b> - amount of repositories and open PRs to display per page. Can be used like in the previous example. ```-c10``` for 10 results or ```-cn``` to skip questions and use the default amount (30).
* <b>-t</b> - token option. You can specify or skip token questions and run script without it by using this option. Example: ```-t TOKEN``` to use your token or ```-tn``` to skip token question and run the sctipt without it.
* <b>-r</b> - by this option you can set the link or username to skip questions about it during the script running. Example: ```-r https://github.com/foo/bar``` or ```-r foo/bar``` or ```foo```.
## Examples of use
1. For the first example we will use the [spring-projects/spring-boot](https://github.com/spring-projects/spring-boot) repository. 

```
bash script.sh -r spring-projects/spring-boot 

Enter your Github OAuth token, or press enter to work without it:
=========================================================================
Working without Github API OAuth token. Rate limit remaining: 59

Found spring-projects/spring-boot repository!

Enter the number of lines per page, default is 30, can't be more than 100:
=========================================================================
Enter the page number, default is 1:
=========================================================================
Working on spring-projects/spring-boot repository...

Done! Most productive contributors list:

Nickname:  Pull requests:  Profile link:

bono007    2               https://github.com/bono007

=========================================================================

Done! Open pull requests list:

Nickname:       Title:                                                                         Pull request labels:                                                       Pull request link:

dreis2211       Avoid explicit initialization of Atomics with their default values             status: waiting-for-triage                                                 https://github.com/spring-projects/spring-boot/pull/28162
garyrussell     Upgrade to Apache Kafka 3.0.0                                                  type: dependency-upgrade                                                   https://github.com/spring-projects/spring-boot/pull/28151
vignesh1992     Support both kebab-case and camelCase as Spring init CLI Options               status: waiting-for-triage, status: feedback-provided                      https://github.com/spring-projects/spring-boot/pull/28138
jonatan-ivanov  Java Info Contributor                                                          type: enhancement, for: merge-with-amendments                              https://github.com/spring-projects/spring-boot/pull/28136
timtebeek       Support PEM format for Kafka SSL certificates and private key (KIP-651)        status: waiting-for-triage                                                 https://github.com/spring-projects/spring-boot/pull/28123
bono007         Log a fail/warn when config metadata default values are unable to be resolved  status: waiting-for-triage, status: feedback-provided                      https://github.com/spring-projects/spring-boot/pull/28062
eddumelendez    Add RabbitStreamTemplate configuration                                         status: waiting-for-triage, status: feedback-provided                      https://github.com/spring-projects/spring-boot/pull/28060
cdalexndr       Allow WebDriver custom config                                                  status: waiting-for-feedback, status: on-hold, status: waiting-for-triage  https://github.com/spring-projects/spring-boot/pull/27947
Goooler         Add .gitattributes                                                             type: task, status: on-hold                                                https://github.com/spring-projects/spring-boot/pull/27615
vpavic          Allow build info properties to be disabled                                     type: enhancement, status: feedback-provided, for: merge-with-amendments   https://github.com/spring-projects/spring-boot/pull/27412
bono007         Add support for redis-sentinel in spring.redis.url (Lettuce only)              type: enhancement, for: team-attention                                     https://github.com/spring-projects/spring-boot/pull/27373
weixsun         Add more session cookie config property for WebFlux                            type: enhancement, status: on-hold                                         https://github.com/spring-projects/spring-boot/pull/26714
Buzzardo        Wording changes                                                                type: documentation, status: on-hold                                       https://github.com/spring-projects/spring-boot/pull/22113
jkschneider     Health indicators based on Service Level Objectives                            type: enhancement, status: pending-design-work                             https://github.com/spring-projects/spring-boot/pull/21311
dsyer           Add reactive progressive rendering features to MustacheView                    type: enhancement, for: merge-with-amendments                              https://github.com/spring-projects/spring-boot/pull/16829

```
2. For second examlpe we will use [trekhleb/javascript-algorithms](https://github.com/trekhleb/javascript-algorithms) repository.

```
bash script.sh -t TOKEN -c20 -pn
Working with Github API OAuth token

Enter the Github username or link to repository:
trekhleb
=========================================================================
Found trekhleb user!

Searching for trekhleb repositories...

Repository:                   Stars:  Description:

javascript-algorithms         120886  📝 Algorithms and data structures implemented in JavaScript with explanations and links to further readings
homemade-machine-learning     18383   🤖 Python examples of popular machine learning algorithms with interactive Jupyter demos and math being explained
learn-python                  10855   📚 Playground and cheatsheet for learning Python. Collection of Python scripts that are split by topics and contain code examples with explanations.
state-of-the-art-shitcode     2051    💩State-of-the-art shitcode principles your project should follow to call it a proper shitcode
nano-neuron                   2006    🤖 NanoNeuron is 7 simple JavaScript functions that will give you a feeling of how machines can actually "learn"
js-image-carver               1181    🌅 Content-aware image resizer and object remover based on Seam Carving algorithm
machine-learning-experiments  1078    🤖 Interactive Machine Learning experiments: 🏋️models training + 🎨models demo
machine-learning-octave       690     🤖 MatLab/Octave examples of popular machine learning algorithms with code examples and mathematics being explained
promote-your-next-startup     469     🚀 Free resources you may use to promote your next startup
covid-19                      259     📈 Coronavirus (COVID-19) dashboard to show the dynamics of Сoronavirus distribution per country
use-position                  251     🌍 React hook usePosition() for fetching and following a browser geolocation
self-parking-car-evolution    202     🧬 Training the car to do self-parking using a genetic algorithm
angular-library-seed          200     🌾 Seed project for Angular libraries that are AOT/JIT compatible and that use external SCSS-styles and HTML-templates
nodejs-master-class           194     🛠 This repository contains the homework assignment for Node.js Master Class that is focused on building a RESTful API, web app GUI, and a CLI in plain Node JS with no NPM or 3rd-party libraries
links-detector                152     📖 👆🏻 Links Detector makes printed links clickable via your smartphone camera. No need to type a link in, just scan and click on it.
trekhleb.github.io            50      🧬 My personal website with a list of my projects that help people learn and blog posts about life, web-development, and machine-learning.
hello-docker                  42      🐳Example Docker project that is used as illustration for automated continuous delivery flow with DockerCloud and DigitalOcean
giphygram                     22      Experimental React application for searching GIF images on GIPHY
trekhleb                      11      👨🏻‍💻 My GitHub profile intro

Enter one of the displayed repositories:
javascript-algorithms
=========================================================================
Found javascript-algorithms repository!

Working on javascript-algorithms repository...

Done! Most productive contributors list:

Nickname:       Pull requests:  Profile link:

tusba           2               https://github.com/tusba
SewookHan       2               https://github.com/SewookHan
OscarRG         2               https://github.com/OscarRG
muhammederdinc  2               https://github.com/muhammederdinc

=========================================================================

Done! Open pull requests list:

Nickname:       Title:                                                   Pull request labels:  Pull request link:

Suman-kumar23   Updating a typo in " Get bit" section                    There is no labels    https://github.com/trekhleb/javascript-algorithms/pull/777
antkaz          fixed spelling error for hash-table (ru)                 There is no labels    https://github.com/trekhleb/javascript-algorithms/pull/775
qiugu           Add linkedList insert method                             There is no labels    https://github.com/trekhleb/javascript-algorithms/pull/774
OscarRG         fix typos                                                There is no labels    https://github.com/trekhleb/javascript-algorithms/pull/773
trekhleb        Bump tmpl from 1.0.4 to 1.0.5                            dependencies          https://github.com/trekhleb/javascript-algorithms/pull/772
OscarRG         fix typos                                                There is no labels    https://github.com/trekhleb/javascript-algorithms/pull/771
yanglr          Correct inaccurate Chinese translation.                  There is no labels    https://github.com/trekhleb/javascript-algorithms/pull/768
SewookHan       Add Korean translation                                   There is no labels    https://github.com/trekhleb/javascript-algorithms/pull/767
Chahat226       Splaytree                                                There is no labels    https://github.com/trekhleb/javascript-algorithms/pull/761
VasanthKumar14  added pancake sort                                       There is no labels    https://github.com/trekhleb/javascript-algorithms/pull/760
theSatvik       Merkle tree added with implementation and documentation  There is no labels    https://github.com/trekhleb/javascript-algorithms/pull/759
SewookHan       Add Korean translation                                   There is no labels    https://github.com/trekhleb/javascript-algorithms/pull/752
rkr-dev         Added config.yml                                         There is no labels    https://github.com/trekhleb/javascript-algorithms/pull/746
fncolon         [ID] Minor Improvements                                  There is no labels    https://github.com/trekhleb/javascript-algorithms/pull/742
muhammederdinc  Factorial turkish readme                                 There is no labels    https://github.com/trekhleb/javascript-algorithms/pull/740
muhammederdinc  Linked list turkish readme                               There is no labels    https://github.com/trekhleb/javascript-algorithms/pull/739
rafaelbpa       Created Quicksort documentation in pt-BR                 There is no labels    https://github.com/trekhleb/javascript-algorithms/pull/735
vikramnande     Added line in gitignore                                  There is no labels    https://github.com/trekhleb/javascript-algorithms/pull/734
tusba           Fix error in Queue definition from README.ru-RU.md       There is no labels    https://github.com/trekhleb/javascript-algorithms/pull/726
tusba           Typos in a doubly linked list's "ru" readme              There is no labels    https://github.com/trekhleb/javascript-algorithms/pull/724
```

3. And third. My own repository. 

```
bash script.sh -tn -r /RainbowGravity/ -cn -pn
Working without Github API OAuth token. Rate limit remaining: 53

Found RainbowGravity user!

Searching for RainbowGravity repositories...

Repository:  Stars:  Description:

course       0       This repository is created for my homework and progress sharing.

Enter one of the displayed repositories:
course
=========================================================================
Found course repository!

Working on course repository...

There is no users with more than 1 pull request on 1 page with 30 per page results.

=========================================================================

There is no pull requests in this repository on 1 page.

```
