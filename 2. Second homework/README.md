## About

Very simple service that reading your JSON request in following manner: <br>
```
curl -XPOST -d '{"animal":"cat","sound":"meow","count":3}' -k https://localhost
```
and respond to you with an answer like that:<br>
```
Done! 👌

cat says meow 
cat says meow 
cat says meow 

Made with VS Code by 🌈Gravity
```
But if you failed with texting your JSON data you'll get that answer:
```
❗ Error: Incorrect data request. ❗

Please, enter the correct JSON data.

⭕ Data format: ⭕

{"animal": "value<", "sound": "value", "count": number}
```
## Web version

You can also open it in your browser and send the JSON request. Just put it in the top field, choose a method by toggling the switch and click on the "Send GET/POST" button under. <br><br>

<p align=center>

  <img width="700" height="419" src="https://user-images.githubusercontent.com/89798605/132259564-571c2526-f0bb-4fcf-a204-6db0262abf95.png">

</p>

After scrolling down the output field you can see a method that was used.

## Features

* You can choose between different HTTP request methods!
* <b>Web version!</b> Just open it in your browser, put the right JSON data and get an answer! Or error message.
* In the web version you can choose between two methods too by using the <b>toggle switch</b> to the right of the <b>Send GET/POST</b> button!
* <b>Emoji!</b> To give an example, just put your cat or dog in the colons like that :сat: and you'll get an emojized 🐈 (meow!).
