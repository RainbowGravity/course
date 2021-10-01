# Telegram homework bot
## About the bot
This bot was created as one of the homework and it can display actual information about my completed homework. The bot for now have 3 primary commands and running on the AWS EC2 Instance. 
## Links
* [Homework bot](https://t.me/RGHomeworkBot)
## Commands
* <b>/start</b> - the first command which you will send to the bot. At first time bot will reply to you with greeting, but then will not be happy about that, however bot will remind you about commands once more.
* <b>/git</b> - bot will reply to you with the link to my homework repository. Nothing special.
* <b>/tasks</b> - bot will reply to you with a list of links to my completed homework. Links are in form of the inline Telegram keyboard. You will be able to open them just by clicking on.
* <b>/task</b> - there are few scenarios of this command working:
   1. If you have sent a right request in the manner like ```/task 2``` then you will get a proper reply with the link to the second homework. Nice!
   2. If you have sent the request in the manner like in previous example, but you have missed the range or used a letter or anything else you will get an error like: ```You're doing something wrong: there is no homework with number more than 4.``` or ```an argument for the /task command can't be empty or letter.```.
   3. If you have sent the request without an argument for the ```/task``` command then the <b>/task choosing mode</b> will be initiated. In this mode you will get a reply with the list of the homework and you will need to enter the command like ```/task 2``` or just the right number like ```2```.
   4. If you will type incorrect numbers or letters or other commands you will get replies with the errors like in the second example. Use ```/cancel``` command to exit this mode.  
* <b>/cancel</b> - purpose of this command is only to exit the <b>/task choosing mode</b> and it will not work outside of it. 
## Features
* Currently the bot is running on the AWS EC2 and you don't need to launch it to test and the bot is available for now for 24/7. 
* The bot is remember a state for the each user individually until it will not be restarted. Even if 2 or more users are able to use the bot at the same time it will reply to them individually, because the bot is storing information about each user state in the memory. With every new update bot is checking for the user id in a special slice and then reading information from it. If there is no user in the slice then bot will add him to it and then will set the false state for the ```/start``` command and the <b>/task choosing mode</b> state too.
* Also the bot is authenticating to the Github api via the OAuth token, so there is no risks for the API rate limit exceeding. This was discovered during the bot testing.
## Build and run
To run the bot you need to install [tgbotapi](github.com/go-telegram-bot-api/telegram-bot-api) and [godotenv](github.com/joho/godotenv) packages and create the ```.env``` file with two tokens inside of it:
 ```
BOT_TOKEN=YOUR_BOT_TOKEN
API_TOKEN=YOUR_GITHUB_API_TOKEN
```
