package main

//https://github.com/google/go-github

//https://api.github.com/repos/RainbowGravity/course/contents/

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
)

//"fmt"
//"encoding/json"
//"log"

type JsonData []struct {
	Name string `json:"name"`
	// Html string `json:"html_url"`
}

// type JsonData []struct {
// 	Name        string      `json:"name"`
// 	Path        string      `json:"path"`
// 	Sha         string      `json:"sha"`
// 	Size        int         `json:"size"`
// 	URL         string      `json:"url"`
// 	HTMLURL     string      `json:"html_url"`
// 	GitURL      string      `json:"git_url"`
// 	DownloadURL interface{} `json:"download_url"`
// 	Type        string      `json:"type"`
// 	Links       struct {
// 		Self string `json:"self"`
// 		Git  string `json:"git"`
// 		HTML string `json:"html"`
// 	} `json:"_links"`
// }

func main() {
	fmt.Println("Hello World!")

	gitRepos := "https://api.github.com/repos/"
	gitUser := "RainbowGravity/"
	gitRepo := "course"
	gitUrl := gitRepos + gitUser + gitRepo

	resp, err := http.Get(gitUrl + "/contents/")
	if err != nil {
		fmt.Println(err)
	}

	defer resp.Body.Close()
	jsonString, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		fmt.Println(err)
	}

	var reading JsonData
	err = json.Unmarshal([]byte(jsonString), &reading)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Printf("%+v\n", reading)
}

//func gitData(gitUrl string) ([]JsonData, error) {
//	resp, err := http.Get(gitUrl + "/contents/")
//	if err != nil {
//		return nil, err
//	}
//    defer resp.Body.Close()
//    body, err := ioutil.ReadAll(resp.Body)
//    if err != nil {
//        return nil, err
//    }
//
//}
