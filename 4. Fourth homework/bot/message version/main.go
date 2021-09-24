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

var reading []JsonData
var botMode bool

func main() {
	var msgHmrwk string
	r, _ := regexp.Compile("[0-9]+")

	bot, err := tgbotapi.NewBotAPI("------ТОКЕН ЗДЕСЬ-------")
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
	botMode = true

	//here I've tired of commenting
	for update := range updates {
		if update.Message == nil {
			continue
		}
		msg := tgbotapi.NewMessage(update.Message.Chat.ID, "")
		msg.ParseMode = "markdown"

		log.Printf("[%s] %s", update.Message.From.UserName, update.Message.Text)

		if botMode == true {
			if update.Message.IsCommand() {
				switch update.Message.Command() {
				case "git":
					msg.Text = "*Here is the link to my repository:* \n\n[RainbowGravity/course](https://github.com/RainbowGravity/course)"
				case "tasks":
					msgHmrwk, err = completedHomework(gitUrl)
					msg.Text = errorHandling(msgHmrwk, err)
				case "task":
					if r.MatchString(update.Message.CommandArguments()) == true {
						msgHmrwk, err = specifiedHomework(gitUrl, update.Message.CommandArguments())
					} else {
						err = errors.New("an argument for the */task* command can't be empty or letter.\n\n*You can choose one of these:*\n" + rangeError(gitUrl))
						botMode = false
					}
					msg.Text = errorHandling(msgHmrwk, err)
				default:
					err = errors.New("there is no *" + update.Message.Text + "* command. \n\n*Try one of these:*\n*/git* — Link to my Github repository;\n*/tasks* — List of my completed homework;\n*/task* — Specified homework (*e.g. /task 2*)")
					msg.Text = errorHandling(msgHmrwk, err)
					err = nil
				}
				bot.Send(msg)
				if botMode == false {
					msg.Text = ("Initialising */task* choosing mode.")
					bot.Send(msg)
				}
			}

		} else {
			if update.Message.IsCommand() {
				switch update.Message.Command() {
				case "cancel":
					botMode = true
				case "task":
					if r.MatchString(update.Message.CommandArguments()) == true {
						msgHmrwk, err = specifiedHomework(gitUrl, update.Message.CommandArguments())
					} else {
						err = errors.New("an argument for the */task* command can't be empty or letter.\n\n*You can choose one of these:*\n" + rangeError(gitUrl))
						botMode = false
					}
					msg.Text = errorHandling(msgHmrwk, err)
				default:
					err = errors.New("there is no *" + update.Message.Text + "* command in */task* choosing mode. \n\n*Try one of these:*\n*/cancel* — Exit */task* choosing mode;\n*/task* — Specified homework (*e.g. /task 2*)")
					msg.Text = errorHandling(msgHmrwk, err)
					err = nil
					botMode = false
				}
				bot.Send(msg)
			} else {
				if r.MatchString(update.Message.Text) == true {
					msgHmrwk, err = specifiedHomework(gitUrl, update.Message.Text)
					msg.Text = errorHandling(msgHmrwk, err)
				} else {
					err = errors.New("an argument for the */task* command can't be empty or letter.\n\n*You can choose one of these:*\n" + rangeError(gitUrl))
					msg.Text = errorHandling(msgHmrwk, err)
					botMode = false
				}
				bot.Send(msg)
			}
			if botMode == true {
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
func completedHomework(gitUrl string) (hmwrkAll string, err error) {

	getContents(gitUrl)

	for _, val := range reading {
		if !strings.Contains(val.Name+" — "+val.Html, "README.md") && !strings.Contains(val.Name+" — "+val.Html, "WIP") {

			tmp := string("\n" + "[" + val.Name + "]" + "(" + val.Html + ")")
			hmwrkAll = hmwrkAll + tmp
			if err != nil {
				err = errors.New("there is no homework")
			}
		}
	}
	return hmwrkAll, err
}

//processing a specified homework
func specifiedHomework(gitUrl string, hmwrkStr string) (hmwrkSpc string, err error) {

	getContents(gitUrl)
	hmwrkNum, err := strconv.Atoi(hmwrkStr)
	hmwrkNum = hmwrkNum - 1

	if hmwrkNum < len(reading)-1 && hmwrkNum > -1 {
		hmwrkSpc = ("\n" + "[" + reading[hmwrkNum].Name + "]" + "(" + reading[hmwrkNum].Html + ")")
		botMode = true
	} else {
		if hmwrkNum <= -1 {
			err = errors.New("there is no homework with number less than 1")
		} else {
			err = errors.New("there is no homework with number more than " + fmt.Sprint(len(reading)-1))
		}
		if botMode == false {
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
		botMessage = ("*An error occurred: *" + fmt.Sprint(err) + ".")
	} else {
		botMessage = ("*List of completed homework:* \n " + msgHmrwk)
	}
	return
}
