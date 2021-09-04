from flask import Flask, request, render_template
import emoji
import json

def jsonc(data):
    return emoji.emojize('%s says %s \n' % (data['animal'], data['sound'])) * (data['count']) \
           + "\nMade with pyChamp by RainbowGravity\n"

app = Flask(__name__)

@app.route("/", methods = ['POST','GET'])
def curl():
    try:
        return jsonc(data=request.get_json(force=True))
    except:
        return 'Error! Please, enter correct data.\n\nData format:\n{"animal": "value","sound": "value","count": number}. \n If you have opened this from web browser, use https://localhost/web'

@app.route("/web", methods = ['POST','GET'])
def result():
   if request.method == 'POST':
        try:
            return render_template("web.html", result=jsonc(data = json.loads(request.form['js'])) + '\nMethod: POST')
        except:
            return render_template("web.html", result= "Incorrect data request.\n\n Send correct JSON data.")
   else:
       try:
           return render_template("web.html", result=jsonc(data=json.loads(request.args.get('js'))) + '\nMethod: GET')
       except:
           return render_template("web.html", result="Incorrect data request.\n\n Send correct JSON data.")

@app.route("/about", methods = ['POST','GET'])
def about():
    return "\nNice to see you there! This is my first python web app.\n\nMade with pyChamp, built with Docker and " \
           "deployed with Ansible by RainbowGravity.\n\nAndersen DevOps course, Saint Petersburg, 2021\n\n "

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=443, ssl_context=('cert.pem', 'key.pem'), debug=False)
