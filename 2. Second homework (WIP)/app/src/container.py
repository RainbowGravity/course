from flask import Flask, request

app = Flask(__name__)

@app.route('/', methods = ['POST','GET'])
def main():
    data = request.get_json(force=True)
    return str((data['animal']) + ' says ' + (data['sound']) + '\n') * int(data['count']) + "\nMade with pyChamp by RainbowGravity\n"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=443, ssl_context=('cert.pem', 'key.pem'), debug=False)
