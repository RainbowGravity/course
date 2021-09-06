from emoji.core import emojize
from flask import Flask, request, render_template
import emoji
import json

def jsonc(data):
    return emoji.emojize('Done! :OK_hand:\n\n') + emoji.emojize(('%s says %s \n' % (data['animal'], data['sound']))) * (data['count']) \
           + emoji.emojize("\nMade with VS Code by :rainbow:Gravity\n")

def error():
    return emoji.emojize(':red_exclamation_mark: Error: Incorrect data request. :red_exclamation_mark:\n\nPlease, enter the correct JSON data.' \
        '\n\n:hollow_red_circle: Data format: :hollow_red_circle:\n\n{"animal": "value", "sound": "value", "count": number}\n')

def curl():
    try:
        return jsonc(data=request.get_json(force=True))
    except:
        return error()

def get():
    try:
        return render_template("web.html", result=jsonc(data=json.loads(request.args.get('js'))) + '\nMethod: GET')
    except:
        return render_template("web.html", result=error())


def post():
    try:
        return render_template("web.html", result=jsonc(data=json.loads(request.form['js'])) + '\nMethod: POST')
    except:
        return render_template("web.html", result=error())

app = Flask(__name__)

@app.route("/", methods = ['POST','GET'])
def result():
   if request.user_agent.browser == None:
        return curl()
   else:
        if request.method == 'POST':
            return post()
        else:
            return get()
            
if __name__ == "__main__":
    app.run(host='0.0.0.0', port=443, ssl_context=('cert.pem', 'key.pem'), debug=False)
