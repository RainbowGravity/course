package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"strconv"
	"strings"

	tgbotapi "github.com/go-telegram-bot-api/telegram-bot-api"
)

type JsonData struct {
	Name string `json:"name"`
	Html string `json:"html_url"`
}

var reading []JsonData

func main() {
	var msgHmrwk string

	bot, err := tgbotapi.NewBotAPI("1961403382:AAE3FNO6HeZ-6fjNqAV1qEXCfAdBFhA-as8")
	if err != nil {
		log.Panic(err)
	}

	bot.Debug = true

	gitRepos := "https://api.github.com/repos/"
	gitUser := "RainbowGravity/"
	gitRepo := "course"
	gitUrl := gitRepos + gitUser + gitRepo

	log.Printf("Authorized on account %s", bot.Self.UserName)

	u := tgbotapi.NewUpdate(0)
	u.Timeout = 60

	updates, err := bot.GetUpdatesChan(u)

	for update := range updates {
		if update.Message == nil {
			continue
		}

		log.Printf("[%s] %s", update.Message.From.UserName, update.Message.Text)

		if update.Message.IsCommand() {
			msg := tgbotapi.NewMessage(update.Message.Chat.ID, "")
			switch update.Message.Command() {
			case "Git":
				msg.Text = "Link to my repository: \nhttps://github.com/RainbowGravity/course"
			case "Tasks":
				msgHmrwk = completedHomework(gitUrl)
				msg.Text = errorHandling(msgHmrwk, err)
			case "Task":
				hmwrkStr := (update.Message.CommandArguments())
				msgHmrwk, err = specifiedHomework(gitUrl, hmwrkStr)
				msg.Text = errorHandling(msgHmrwk, err)
			default:
				err = errors.New("There is no " + update.Message.Text + " command. \nTry one of these:\n- /Git\n- /Tasks\n- /Task")
				msg.Text = errorHandling(msgHmrwk, err)
			}
			bot.Send(msg)
		}

	}
}

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

func completedHomework(gitUrl string) (hmwrkAll string) {

	getContents(gitUrl)

	for _, val := range reading {
		if !strings.Contains(val.Name+"\t"+val.Html, "README.md") && !strings.Contains(val.Name+"\t"+val.Html, "WIP") {
			tmp := string("\n" + val.Name + "\t" + val.Html)
			hmwrkAll = hmwrkAll + tmp

		}
	}
	return hmwrkAll
}

func specifiedHomework(gitUrl string, hmwrkStr string) (hmwrkSpc string, err error) {

	getContents(gitUrl)
	hmwrkNum, err := strconv.Atoi(hmwrkStr)
	hmwrkNum = hmwrkNum - 1

	if hmwrkNum < len(reading)-1 && hmwrkNum > -1 {
		hmwrkSpc = ("\n" + reading[hmwrkNum].Name + "\t" + reading[hmwrkNum].Html)
	} else {
		if hmwrkNum <= -1 {
			err = errors.New("task number cannot be less than 1")
		} else {
			err = errors.New("task number cannot be more than " + fmt.Sprint(len(reading)-1))
		}
	}
	return hmwrkSpc, err
}

//error handling function
func errorHandling(msgHmrwk string, err error) (botMessage string) {
	if err != nil {
		botMessage = ("An error occurred: " + fmt.Sprint(err))
	} else {
		botMessage = ("List of completed homework: " + msgHmrwk)
	}
	return
}
