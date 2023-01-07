import urllib
from flask import Flask, jsonify, make_response, request, send_file, render_template, Response
import json
import requests
from tinydb import TinyDB, Query
from login import Login
from Essentials.UserTree import *
from Essentials.Account import *
from signup import Signup
from rafay.history import *
import os

response = ''
app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = os.path.join("")
db = TinyDB("database.json")
query = Query()
movies_table = db.table("Movie_data")
show_table = db.table("Show_data")
anime_table = db.table("Anime_data")


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
            return make_response(response, 200)
        except Exception as e:

            response = jsonify({"error": str(e), "account": 'None'})
            return make_response(response, 400)
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
            return make_response(response, 200)
        except Exception as e:
            response = jsonify({"error": str(e)})
            return make_response(response, 400)
    else:

        return response


@app.route('/getimages')
def get_image():
    img = request.args.get('img')
    filename = f"images/{img}"
    return send_file(filename, mimetype='image/gif')


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


@app.route("/get_history")
def get_history():
    player = Watch_history()
    player.Add_history({
        "id": "movie/watch-avengers-age-of-ultron-19729",
        "title": "Avengers: Age of Ultron",
        "coverImg":
        "https://img.flixhq.to/xxrz/250x400/379/76/e8/76e8bc195d6dff37d1fbbf815ce467e9/76e8bc195d6dff37d1fbbf815ce467e9.jpg",
        "genres": ["Action", "Adventure", "Science Fiction"],
    })
    player.Add_history({
        "id": "movie/watch-avengers-age-of-ultron-19729",
        "title": "Avengers: Age of Ultron",
        "coverImg":
        "https://img.flixhq.to/xxrz/250x400/379/76/e8/76e8bc195d6dff37d1fbbf815ce467e9/76e8bc195d6dff37d1fbbf815ce467e9.jpg",
        "genres": ["Action", "Adventure", "Science Fiction"],
    })
    player.Add_history({
        "id": "movie/watch-avengers-age-of-ultron-19729",
        "title": "Avengers: Age of Ultron",
        "coverImg":
        "https://img.flixhq.to/xxrz/250x400/379/76/e8/76e8bc195d6dff37d1fbbf815ce467e9/76e8bc195d6dff37d1fbbf815ce467e9.jpg",
        "genres": ["Action", "Adventure", "Science Fiction"],
    })
    player.Add_history({
        "id": "movie/watch-avengers-age-of-ultron-19729",
        "title": "Avengers: Age of Ultron",
        "coverImg":
        "https://img.flixhq.to/xxrz/250x400/379/76/e8/76e8bc195d6dff37d1fbbf815ce467e9/76e8bc195d6dff37d1fbbf815ce467e9.jpg",
        "genres": ["Action", "Adventure", "Science Fiction"],
    })

    response = jsonify({"data": player.get_all()})
    return make_response(response)  # prints "video3.mp4"

@app.route("/", methods=["GET"])
def main():
    return render_template("index.html")


@app.route("/getAllMovies", methods=["GET"])
def getMovies():
    response = jsonify({"result": movies_table.all()})
    return make_response(response)

@app.route("/getAllAnime",methods = ["GET"])
def getAllAnime():
    response = jsonify({"result": anime_table.all()})
    return make_response(response)
    
@app.route("/getAllShow",methods = ["GET"])
def getAllShow():
    response = jsonify({"result": show_table.all()})
    return make_response(response)

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0")
