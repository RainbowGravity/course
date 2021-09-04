## Heheheheh

### Some thoughts and plans
So, after some experiments i've decided: app will get web version and will use localhost/web address. 
Tested it and it works perfect, so now i need only to put my app in the container and learn how to 
deploy it with Ansible. 
### Example request:
``` 
curl -XPOST -d '{"animal":"Anime catgirl", "sound":"nya", "count": 6}' -k https://localhost:443  
```
```
Anime catgirl says nya
Anime catgirl says nya
Anime catgirl says nya
Anime catgirl says nya
Anime catgirl says nya
Anime catgirl says nya

Made with pyChamp by RainbowGravity
```
