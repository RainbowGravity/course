package main

//https://github.com/google/go-github

//https://api.github.com/repos/RainbowGravity/course/contents/

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

// var reading []JsonData
// var err error
// var botMessage string

func main() {
	botToken := ""
	//https://api.telegram.org/file/bot<token>/<file_path>
	botApi := "https://api.telegram.org/bot"
	botUrl := botApi + botToken
	//processingRequest()
	//println(botMessage)
	for {
		updates, err := getUpdates(botUrl)
		if err != nil {
			log.Println("sag", err.Error())
		}
		fmt.Println(updates)
	}
}

//reading updates from server
func getUpdates(botUrl string) ([]Update, error) {
	resp, err := http.Get(botUrl + "/getUpdates")
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}
	var restResponse RestResponse
	err = json.Unmarshal(body, &restResponse)
	if err != nil {
		return nil, err
	}
	return restResponse.Result, nil
}

func processingRequest() string {
	var hmwrkNum int
	var msg string
	var requestCase strin
	
	gitRepos := "https://api.github.com/repos/"
	gitUser := "RainbowGravity/"
	gitRepo := "course"
	gitUrl := gitRepos + gitUser + gitRep
	
fmt.Println("Choose one of commands: \n- Git - link to my repository\n- Tasks - list of my completed homework\n- Task# - choose completed task"
	fmt.Scan(&requestCase
	
	switch requestCase {
	case "Git":
		botMessage = ("Link to my repository: \nhttps://github.com/RainbowGravity/course")
	case "Tasks":
		msg = completedHomework(gitUrl)
		botMessage = errorHandling(msg, err)
	case "Task#":
		msg, err = specifiedHomework(gitUrl, hmwrkNum)
		botMessage = errorHandling(msg, err)
	default:
		err = errors.New("There is no '" + requestCase + "' command. \nTry one of these:\n- /git\n- /Tasks\n- /Task#")
		botMessage = errorHandling(msg, err)
	}
	return botMessage

//reading information from Guthub API
func getContents(gitUrl string) 
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

//all of the completed homeworks processing
func completedHomework(gitUrl string) (hmwrkAll string) 
	getContents(gitUrl
	for _, val := range reading {
		if !strings.Contains(val.Name+"\t"+val.Html, "README.md") && !strings.Contains(val.Name+"\t"+val.Html, "WIP") {
			tmp := string("\n" + val.Name + "\t" + val.Html)
			hmwrkAll = hmwrkAll + tmp
		}
	}
	return hmwrkAll

//specified homework processing
func specifiedHomework(gitUrl string, hmwrkNum int) (hmwrkSpc string, err error) 
	getContents(gitUrl)
	hwmrkAmount := len(reading)
	specifiedChoice(hwmrkAmount - 1
	fmt.Scan(&hmwrkNum)
	hmwrkNum = hmwrkNum - 
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

//prints amount of choises
func specifiedChoice(hmwrkAmount int) (hmwrkNum int, botMessage string) 
	s := []int{}
	for i := 0; i < hmwrkAmount; i++ {
		s = append(s, i+1)
	}
	botMessage = ("Choose completed homework: \n" + strings.Trim(fmt.Sprint(s), "[ ]"))
	println(botMessage)
	return

//error handling function
func errorHandling(msg string, err error) (botMessage string) {
	if err != nil {
		botMessage = ("An error occurred: " + fmt.Sprint(err))
	} else {
		botMessage = ("List of completed homework: " + msg)
	}
	return
