from flask import Flask, request
import emoji

app = Flask(__name__)

@app.route('/', methods = ['POST','GET'])
def main():
    data = request.get_json(force=True)
    return ('%s says %s \n' % (data['animal'], data['sound'])) * (
    data['count']) + "\nMade with pyChamp by RainbowGravity\n"

@app.route("/emoji", methods=['POST', 'GET'])
def emoj():
    data = request.get_json(force=True)
    return emoji.emojize(':%s: says %s \n' % (data['animal'], data['sound'])) * (
    data['count']) + "\nMade with pyChamp by RainbowGravity\n"

@app.route("/about", methods=['POST', 'GET'])
def about():
    return "\nNice to see you there! This is my first python web app.\n\nMade with pyChamp, built with Docker and deployed with Ansible by RainbowGravity.\n\nAndersen DevOps course, Saint Petersburg, 2021\n\n"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=443, ssl_context=('cert.pem', 'key.pem'), debug=False)
