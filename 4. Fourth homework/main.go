package main

//https://github.com/google/go-github

//https://api.github.com/repos/RainbowGravity/course/contents/

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"strings"
)

type JsonData struct {
	Name string `json:"name"`
	Html string `json:"html_url"`
}

var hmwrk string
var reading []JsonData
var err error

func main() {
	var msg string
	var hmwrkNum int

	gitRepos := "https://api.github.com/repos/"
	gitUser := "RainbowGravity/"
	gitRepo := "course"
	gitUrl := gitRepos + gitUser + gitRepo

	hmwrkNum = 0

	msg = specifiedHomework(gitUrl, hmwrkNum)
	//msg = completedHomework(gitUrl)

	botMessage := ("List of completed homework: " + msg)
	println(botMessage)
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
	return
}

func completedHomework(gitUrl string) (hmwrkAll string) {

	getContents(gitUrl)

	for _, val := range reading {
		if strings.Contains(val.Name+"\t"+val.Html, "homework") {
			tmp := string("\n" + val.Name + "\t" + val.Html)
			hmwrkAll = hmwrkAll + tmp
		}
	}
	return hmwrkAll
}

func specifiedHomework(gitUrl string, hmwrkNum int) (hmwrkSpc string) {

	getContents(gitUrl)

	hmwrkNum = hmwrkNum - 1

	if hmwrkNum < len(reading)-1 {
		hmwrkSpc = ("\n" + reading[hmwrkNum].Name + "\t" + reading[hmwrkNum].Html)
		if err != nil {
			hmwrkSpc = ("\nError!")
		}
	}

	return hmwrkSpc
}

// func contentsParse(gitUrl string) (s []string) {

// 	getContents(gitUrl)

//for _, val := range reading {	if strings.Contains(val.Name+"\t"+val.Html, "homework") {
//	var s []string
//	s = append(s, val.Name+"\t"+val.Html)
///jsonResult := (val.Name + "\t" + val.Html)
///fmt.Println(jsonResult)
// for _, val := range s {
// 	putin := val
// 	return putin, s
// }
//	fmt.Println(s)
//}

// 	}
// 	return s
// }
