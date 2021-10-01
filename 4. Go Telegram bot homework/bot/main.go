package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"regexp"
	"strconv"
	"strings"

	tgbotapi "github.com/go-telegram-bot-api/telegram-bot-api"
	godotenv "github.com/joho/godotenv"
)

//declaring the fields from API Json respond
type JsonData struct {
	Name string `json:"name"`
	Html string `json:"html_url"`
}
//declaring the fields of botMode struct
type BotStateID struct {
	ChatID       int64
	BotMode      bool
	StartCommand bool
}

var userStateID []BotStateID
var reading []JsonData
var botMode bool
var startCommand bool
var msg tgbotapi.MessageConfig
var botToken string
var apiToken string

func main() {
	r, _ := regexp.Compile("[0-9]+")
	botMode = true
	gitUrl := "https://api.github.com/repos/RainbowGravity/course/contents/"
	commandsList := "*/git* — Link to RG's Github course repository;\n*/tasks* — List of completed homework;\n*/task* — Specified homework (*e.g. /task 2*)"
	var msgHmrwk string
	//loading BOT_TOKEN and API_TOKEN from .env file
	err := godotenv.Load(".env")
	if err != nil {
		log.Fatalf("Error loading .env file")
	}
	botToken = os.Getenv("BOT_TOKEN")
	apiToken = os.Getenv("API_TOKEN")

	bot, err := tgbotapi.NewBotAPI(botToken)
	if err != nil {
		log.Panic(err)
	}
	
	u := tgbotapi.NewUpdate(0)
	u.Timeout = 60

	updates, err := bot.GetUpdatesChan(u)
	if err != nil {
		log.Fatalln("No updates:", err)
	}
	// processing updates from Telegram API
	for update := range updates {
		if update.Message == nil {
			continue
		}
		msg = tgbotapi.NewMessage(update.Message.Chat.ID, "")
		// setting up markdown mod for messages
		msg.ParseMode = "markdown"
		// setting standard reply for bot
		msgHmrwk = ("\nYou can open the homework link via button!")
		// checking for botMode and startCommand status
		botMode, userStateID, startCommand = getUserState(update.Message.Chat.ID, userStateID)
		// checking for botMode, acting normal if true
		if botMode {
			// checking for command
			if update.Message.IsCommand() {
				// switch for the commands
				switch update.Message.Command() {
				case "start":
					msg.DisableWebPagePreview = true
					// checking for startCommand status
					if startCommand {
						msg.Text = "Hi, I'm a Homework bot. I can help you to know about completed [RainbowGravity's](https://t.me/RainbowGravity) homework via these commands:\n\n" + commandsList
						getUserState(update.Message.Chat.ID, userStateID)
					} else {
						msg.Text = "What are you trying to start? I'm working already! \nBut, fine, I can remind you about commands once again: \n\n" + commandsList
					}
				case "cancel":
					msg.Text = "There is nothing to /cancel now, I wasn't do anything. Waiting for your commands.\n\n*Nya!*"
				case "git":
					msg.Text = "*Here is the link to repository:* \n\n[RainbowGravity/course](https://github.com/RainbowGravity/course)"
				case "tasks":
					// setting the ReplyMarkup for reply. If everything is ok then keyboard will be added, if not then error message.
					msg.ReplyMarkup, err = completedHomework(gitUrl)
					msgHmrwk = ("\nYou can open one of the homework links via button!")
					msg.Text = errorHandling(msgHmrwk, err)
				case "task":
					// checking for command argument
					if r.MatchString(update.Message.CommandArguments()) {
						// setting the ReplyMarkup for reply. If everything is ok then keyboard will be added, if not then error message.
						msg.ReplyMarkup, err = specifiedHomework(gitUrl, update.Message.CommandArguments(), update.Message.Chat.ID, userStateID)
					} else {
						err = errors.New("an argument for the */task* command can't be empty or letter.\n\n*You can choose one of these:*\n" + rangeError(gitUrl))
						// setting botMode false status
						botMode, userStateID = setFalseState(update.Message.Chat.ID, userStateID)
					}
					msg.Text = errorHandling(msgHmrwk, err)
				// replying with an error if incorrect command was sent
				default:
					err = errors.New("there is no *" + update.Message.Text + "* command. \n\n" + commandsList)
					msg.Text = errorHandling(msgHmrwk, err)
					err = nil
				}
				// send msg to the user
				bot.Send(msg)
				// checking for botMode and sending message if false
				if !botMode {
					msg.Text = ("Initialising */task* choosing mode.")
					bot.Send(msg)
				}
			} else {
				// replies for random messages
				switch update.Message.Text {
				case "кошка-жена":
					msg.Text = "Nya!"
				default:
					msg.Text = "Nothing to say about that, try using commands instead of trying to talk to me. "
				}
				// send msg to the user
				bot.Send(msg)
			}
		} else {
			// checking for command again
			if update.Message.IsCommand() {
				// swith for the commands
				switch update.Message.Command() {
				case "cancel":
					botMode, userStateID = setTrueState(update.Message.Chat.ID, userStateID)
				case "task":
					// checking for command argument
					if r.MatchString(update.Message.CommandArguments()) {
						msg.ReplyMarkup, err = specifiedHomework(gitUrl, update.Message.CommandArguments(), update.Message.Chat.ID, userStateID)
					} else {
						err = errors.New("an argument for the */task* command can't be empty or letter.\n\n*You can choose one of these:*\n" + rangeError(gitUrl))
					}
					msg.Text = errorHandling(msgHmrwk, err)
				// replying with an error if incorrect command was sent
				default:
					err = errors.New("there is no *" + update.Message.Text + "* command in */task* choosing mode. \n\n*Try one of these:*\n*/cancel* — Exit */task* choosing mode;\n*/task* — Specified homework (*e.g. /task 2*)")
					msg.Text = errorHandling(msgHmrwk, err)
					err = nil
				}
				// send msg to the user
				bot.Send(msg)
			} else {
				// checking for the text message
				if r.MatchString(update.Message.Text) {
					// setting the ReplyMarkup for reply. If everything is ok then keyboard will be added, if not then error message.
					msg.ReplyMarkup, err = specifiedHomework(gitUrl, update.Message.Text, update.Message.Chat.ID, userStateID)
					msg.Text = errorHandling(msgHmrwk, err)
				} else {
					// error reply
					err = errors.New("an argument for the */task* command can't be empty or letter.\n\n*You can choose one of these:*\n" + rangeError(gitUrl))
					msg.Text = errorHandling(msgHmrwk, err)
				}
				// send msg to the user
				bot.Send(msg)
			}
			// checking for botMode and sending msg to the user when true
			if botMode {
				msg.ReplyMarkup = tgbotapi.NewRemoveKeyboard(true)
				msg.Text = ("Exiting */task* choosing mode.")
				bot.Send(msg)
			}
		}
	}
}
// processing the API Json respond
func getContents(gitUrl string) {
	// sending request to the Github API
	resp, err := http.Get(gitUrl)
	resp.Header.Add("Authorization", "token: "+apiToken)
	if err != nil {
		fmt.Println(err)
	}
	// closing the response body
	defer resp.Body.Close()
	jsonString, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		fmt.Println(err)
	}
	// unmarshalling json
	err = json.Unmarshal([]byte(jsonString), &reading)
	if err != nil {
		fmt.Println(err)
	}
}
// processing the list of all homeworks
func completedHomework(gitUrl string) (hmwrkAll tgbotapi.InlineKeyboardMarkup, err error) {
	// getting the json from Github API reply
	getContents(gitUrl)
	// creating the keyboard with the homework list
	for _, val := range reading {
		if !strings.Contains(val.Name, "README.md") && !strings.Contains(val.Name, "WIP") {
			var tmpBtn []tgbotapi.InlineKeyboardButton
			tmp := tgbotapi.NewInlineKeyboardButtonURL(val.Name, val.Html)
			tmpBtn = append(tmpBtn, tmp)
			hmwrkAll.InlineKeyboard = append(hmwrkAll.InlineKeyboard, tmpBtn)
		}
		if err != nil {
			err = errors.New("there is no homework")
		}
	}
	return hmwrkAll, err
}

//processing a specified homework
func specifiedHomework(gitUrl string, hmwrkStr string, chatID int64, userStateID []BotStateID) (hmwrkSpc tgbotapi.InlineKeyboardMarkup, err error) {
	// getting the json from Github API reply
	getContents(gitUrl)
	// converting string to int
	hmwrkNum, err := strconv.Atoi(hmwrkStr)
	hmwrkNum = hmwrkNum - 1
	// checking for number recieved from user, replying with an error if out of range
	if hmwrkNum < len(reading)-1 && hmwrkNum > -1 {
		var tmpBtn []tgbotapi.InlineKeyboardButton
		tmp := tgbotapi.NewInlineKeyboardButtonURL(reading[hmwrkNum].Name, reading[hmwrkNum].Html)
		tmpBtn = append(tmpBtn, tmp)
		hmwrkSpc.InlineKeyboard = append(hmwrkSpc.InlineKeyboard, tmpBtn)
		setTrueState(chatID, userStateID)
	} else {
		if hmwrkNum <= -1 {
			err = errors.New("there is no homework with number less than 1")
		} else {
			err = errors.New("there is no homework with number more than " + fmt.Sprint(len(reading)-1))
		}
		// checking for botMode and adding addintional info about homework range
		if !botMode {
			err = errors.New(fmt.Sprint(err) + "\n\n*You can choose one of these:*\n" + rangeError(gitUrl))
		}
	}
	return hmwrkSpc, err
}
// displaying an available range of homeworks
func rangeError(gitUrl string) string {
	getContents(gitUrl)
	var s []string
	for i := 1; i < len(reading); i++ {
		s = append(s, fmt.Sprint(i))
	}
	q := strings.Join(s, ",  ")
	return q
}

//error handling function
func errorHandling(msgHmrwk string, err error) (botMessage string) {
	// checking for error status
	if err != nil {
		// removing the keyboard for the error message reply
		msg.ReplyMarkup = tgbotapi.NewRemoveKeyboard(true)
		botMessage = ("*You're doing something wrong: *" + fmt.Sprint(err) + ".")
	} else {
		botMessage = ("*Done!* \n " + msgHmrwk)
	}
	return
}

// checking for user state. If there is no user, then add one
func getUserState(chatID int64, userStateID []BotStateID) (bool, []BotStateID, bool) {

	found := false
	// searching for the user in slice by userid
	for i := range userStateID {
		if userStateID[i].ChatID == chatID {
			userStateID[i].StartCommand = false
			botMode = userStateID[i].BotMode
			startCommand = userStateID[i].StartCommand
			found = true
			break
		}
	}
	// if user was not found then add him to the slice
	if !found {
		userStateID = append(userStateID, BotStateID{ChatID: chatID, BotMode: true, StartCommand: true})
		botMode = userStateID[len(userStateID)-1].BotMode
		startCommand = userStateID[len(userStateID)-1].StartCommand
	}
	return botMode, userStateID, startCommand
}

//set a false botMode state for user
func setFalseState(chatID int64, userStateID []BotStateID) (bool, []BotStateID) {

	for i := range userStateID {
		if userStateID[i].ChatID == chatID {
			botMode = false
			userStateID[i].BotMode = botMode
			break
		}
	}
	return botMode, userStateID
}

//set a true botMode state for user
func setTrueState(chatID int64, userStateID []BotStateID) (bool, []BotStateID) {

	for i := range userStateID {
		if userStateID[i].ChatID == chatID {
			botMode = true
			userStateID[i].BotMode = botMode
			break
		}
	}
	return botMode, userStateID
}
