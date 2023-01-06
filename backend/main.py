import urllib
from flask import Flask, jsonify, make_response, request, send_file, render_template, Response
import json
import requests
from tinydb import TinyDB, Query
from login import Login
from Essentials.UserTree import *
from Essentials.Account import *
from signup import Signup
import os

response = ''
app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = os.path.join("")

db = TinyDB("database.json")
query = Query()
movie_table = db.table("Movie_data")


@app.route('/login', methods=['POST'])
def LoginRoute():

    # fetching the global response variable to manipulate inside the function
    global response

    if (request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))

        # request_data = request.args

        username = request_data['username']
        password = request_data['password']

        try:
            account = Login(username, password)
            account = account.account
            response = jsonify({"error": "Logged in", "account": {
                               "username": account.account.username, "profiles": account.get_all_profiles()}})
            return make_response(response)
        except Exception as e:

            response = jsonify({"error": str(e), "account": 'None'})
            return make_response(response)
    else:
        return response


@app.route('/signup', methods=['POST'])
def SignUpRoute():
    global response

    if (request.method == 'POST'):
        # request_data = request.args

        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))

        username = request_data["username"]
        password = request_data["password"]
        email = request_data["email"]
        name = request_data["name"]
        try:
            signup = Signup(name, email, username, password)
            response = jsonify({"error": "None"})
            signup.Print_Account_Details()
            return make_response(response)
        except Exception as e:
            response = jsonify({"error": str(e)})
            return make_response(response)
    else:

        return response


@app.route('/getimages', methods=['GET'])
def get_image():
    img = request.args.get('img')
    filename = f"images/{img}"
    return send_file(filename, mimetype='image/gif')


# @app.route('/getimages')
# def get_next_eps():
#     data = {
#         "epsName": "Eps 1",
#         "epsid": "eps1",
#         "url": "www.streaming-url.com/abc.mp4",
#         "epsNumber": 1
#     }
#     response = jsonify(data)

#     return make_response(response,200)


@app.route('/get_eps')
def get_eps():
    epsno = request.args.get('epsno')
    id = request.args.get('id')
    file = open(f'{id}.pkl', 'rb')
    animelist = pickle.load(file)
    file.close()
    result = animelist[id].next(epsno)
    response = jsonify(requests)
    return make_response(response)

# {
#     "indidick":LinkList,
# }


@app.route('/stream')
def stream():

    data = movie_table.search(query.title == "Poltergeist")

    response = jsonify(data[0])
    return make_response(response)


@app.route('/download_video')
def download_video():

    data = movie_table.search(query.title == "Poltergeist")
    url = "https://movietrailers.apple.com/movies/fox/thefantasticfour/fantasticfour-tlr2_h480p.mov"
    print(url)
    response = requests.get(url)
    if response.status_code == 200:
        return Response(response.content, mimetype='video/mp4')
    else:
        return "Error"


def stream():
    table = db.table("Movie_data")
    data = table.search(query.title == "Poltergeist")

    response = jsonify(data[0])
    return make_response(response)


@app.route("/getMovies", methods=['GET'])
def AllMovies():
    data = movie_table.all()
    response = jsonify(data)
    return make_response(response)


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0")
