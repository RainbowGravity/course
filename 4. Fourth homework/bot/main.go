package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"regexp"
	"strconv"
	"strings"

	tgbotapi "github.com/go-telegram-bot-api/telegram-bot-api"
)

//declaring the fields from API Json respond
type JsonData struct {
	Name string `json:"name"`
	Html string `json:"html_url"`
}

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

func main() {
	r, _ := regexp.Compile("[0-9]+")
	botMode = true
	commandsList := "*/git* — Link to RG's Github course repository;\n*/tasks* — List of completed homework;\n*/task* — Specified homework (*e.g. /task 2*)"
	var msgHmrwk string
	//-------TOKEN--------
	bot, err := tgbotapi.NewBotAPI("-------TOKEN--------")
	if err != nil {
		log.Panic(err)
	}

	bot.Debug = true
	//dunno why I've done this
	gitRepos := "https://api.github.com/repos/"
	gitUser := "RainbowGravity/"
	gitRepo := "course"
	gitUrl := gitRepos + gitUser + gitRepo

	log.Printf("Authorized on account %s", bot.Self.UserName)

	u := tgbotapi.NewUpdate(0)
	u.Timeout = 60
	updates, err := bot.GetUpdatesChan(u)
	if err != nil {
		log.Fatalln("No updates:", err)
	}

	//here I've tired of commenting
	for update := range updates {
		if update.Message == nil {
			continue
		}
		msg = tgbotapi.NewMessage(update.Message.Chat.ID, "")
		msg.ParseMode = "markdown"
		msgHmrwk = ("\nYou can open the homework link via button!")
		log.Printf("[%s] %s", update.Message.From.UserName, update.Message.Text)

		botMode, userStateID, startCommand = getUserState(update.Message.Chat.ID, userStateID)
		if botMode {
			if update.Message.IsCommand() {
				switch update.Message.Command() {
				case "start":
					msg.DisableWebPagePreview = true
					if startCommand {
						msg.Text = "Hi, I'm a Homework bot. I can help you to know about completed [RainbowGravity's](https://t.me/RainbowGravity) homework via these commands:\n\n" + commandsList
						getUserState(update.Message.Chat.ID, userStateID)
					} else {
						msg.Text = "What are you trying to start? I'm working already! \nBut, fine, I can remind you about commands once again: \n\n" + commandsList
					}
				case "cancel":
					msg.Text = "There is nothing to /cancel now, I wasn't do anything. Waiting for your commands.\n\n*Nya!*"
				case "git":
					msg.Text = "*Here is the link to my repository:* \n\n[RainbowGravity/course](https://github.com/RainbowGravity/course)"
				case "tasks":
					msg.ReplyMarkup, err = completedHomework(gitUrl)
					msgHmrwk = ("\nYou can open one of the homework links via button!")
					msg.Text = errorHandling(msgHmrwk, err)
				case "task":
					if r.MatchString(update.Message.CommandArguments()) {
						msg.ReplyMarkup, err = specifiedHomework(gitUrl, update.Message.CommandArguments(), update.Message.Chat.ID, userStateID)
					} else {
						err = errors.New("an argument for the */task* command can't be empty or letter.\n\n*You can choose one of these:*\n" + rangeError(gitUrl))
						botMode, userStateID = setFalseState(update.Message.Chat.ID, userStateID)
					}
					msg.Text = errorHandling(msgHmrwk, err)
				default:
					err = errors.New("there is no *" + update.Message.Text + "* command. \n\n" + commandsList)
					msg.Text = errorHandling(msgHmrwk, err)
					err = nil
				}
				bot.Send(msg)
				if !botMode {
					msg.Text = ("Initialising */task* choosing mode.")
					bot.Send(msg)
				}
			} else {
				switch update.Message.Text {
				case "кошка-жена":
					msg.Text = "Nya!"
				default:
					msg.Text = "Nothing to say about that, try using commands instead of trying to talk to me. "
				}
				bot.Send(msg)
			}
		} else {
			if update.Message.IsCommand() {
				switch update.Message.Command() {
				case "cancel":
					botMode, userStateID = setTrueState(update.Message.Chat.ID, userStateID)
				case "task":
					if r.MatchString(update.Message.CommandArguments()) {
						msg.ReplyMarkup, err = specifiedHomework(gitUrl, update.Message.CommandArguments(), update.Message.Chat.ID, userStateID)
					} else {
						err = errors.New("an argument for the */task* command can't be empty or letter.\n\n*You can choose one of these:*\n" + rangeError(gitUrl))
					}
					msg.Text = errorHandling(msgHmrwk, err)
				default:
					err = errors.New("there is no *" + update.Message.Text + "* command in */task* choosing mode. \n\n*Try one of these:*\n*/cancel* — Exit */task* choosing mode;\n*/task* — Specified homework (*e.g. /task 2*)")
					msg.Text = errorHandling(msgHmrwk, err)
					err = nil
				}
				bot.Send(msg)
			} else {
				if r.MatchString(update.Message.Text) {
					msg.ReplyMarkup, err = specifiedHomework(gitUrl, update.Message.Text, update.Message.Chat.ID, userStateID)
					msg.Text = errorHandling(msgHmrwk, err)
				} else {
					err = errors.New("an argument for the */task* command can't be empty or letter.\n\n*You can choose one of these:*\n" + rangeError(gitUrl))
					msg.Text = errorHandling(msgHmrwk, err)
				}
				bot.Send(msg)
			}
			if botMode {
				msg.ReplyMarkup = tgbotapi.NewRemoveKeyboard(true)
				msg.Text = ("Exiting */task* choosing mode.")
				bot.Send(msg)
			}
		}
	}
}

//processing the API Json respond
func getContents(gitUrl string) {

	resp, err := http.Get(gitUrl + "/contents/")
	if err != nil {
		fmt.Println(err)
	}
	defer resp.Body.Close()
	jsonString, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		fmt.Println(err)
	}
	err = json.Unmarshal([]byte(jsonString), &reading)
	if err != nil {
		fmt.Println(err)
	}
}

//processing the list of all homeworks
func completedHomework(gitUrl string) (hmwrkAll tgbotapi.InlineKeyboardMarkup, err error) {

	getContents(gitUrl)

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

	getContents(gitUrl)
	hmwrkNum, err := strconv.Atoi(hmwrkStr)
	hmwrkNum = hmwrkNum - 1

	if hmwrkNum < len(reading)-1 && hmwrkNum > -1 {
		var tmpBtn []tgbotapi.InlineKeyboardButton
		tmp := tgbotapi.NewInlineKeyboardButtonURL(reading[hmwrkNum].Name, reading[hmwrkNum].Html)
		tmpBtn = append(tmpBtn, tmp)
		hmwrkSpc.InlineKeyboard = append(hmwrkSpc.InlineKeyboard, tmpBtn)
		botMode, userStateID = setTrueState(chatID, userStateID)
	} else {
		if hmwrkNum <= -1 {
			err = errors.New("there is no homework with number less than 1")
		} else {
			err = errors.New("there is no homework with number more than " + fmt.Sprint(len(reading)-1))
		}
		if !botMode {
			err = errors.New(fmt.Sprint(err) + "\n\n*You can choose one of these:*\n" + rangeError(gitUrl))
		}
	}
	return hmwrkSpc, err
}

//displaying an available range of homeworks
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
	if err != nil {
		msg.ReplyMarkup = tgbotapi.NewRemoveKeyboard(true)
		botMessage = ("*You're doing something wrong: *" + fmt.Sprint(err) + ".")
	} else {
		botMessage = ("*Done!* \n " + msgHmrwk)
	}
	return
}

func getUserState(chatID int64, userStateID []BotStateID) (bool, []BotStateID, bool) {

	found := false

	for i := range userStateID {
		if userStateID[i].ChatID == chatID {
			userStateID[i].StartCommand = false
			botMode = userStateID[i].BotMode
			startCommand = userStateID[i].StartCommand
			found = true
			break
		}
	}
	if !found {
		userStateID = append(userStateID, BotStateID{ChatID: chatID, BotMode: true, StartCommand: true})
		botMode = userStateID[len(userStateID)-1].BotMode
		startCommand = userStateID[len(userStateID)-1].StartCommand
	}
	fmt.Println("QWERT", userStateID, "QWERT")
	return botMode, userStateID, startCommand
}

func setFalseState(chatID int64, userStateID []BotStateID) (bool, []BotStateID) {

	for i := range userStateID {
		if userStateID[i].ChatID == chatID {
			botMode = false
			userStateID[i].BotMode = botMode
			break
		}
	}
	fmt.Println("QWERTYFALSE", userStateID, "QWERTYFALSE")
	return botMode, userStateID
}

func setTrueState(chatID int64, userStateID []BotStateID) (bool, []BotStateID) {

	for i := range userStateID {
		if userStateID[i].ChatID == chatID {
			botMode = true
			userStateID[i].BotMode = botMode
			break
		}
	}
	fmt.Println("QWERTYTRUE", userStateID, "QWERTYTRUE")
	return botMode, userStateID
}
