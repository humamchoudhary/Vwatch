from flask import Flask, jsonify, make_response, request, send_file, render_template,redirect, Response
import json
import requests
from tinydb import TinyDB, Query
from login import Login
from Essentials.UserTree import *
from Essentials.Account import *
from Essentials.EpsLinkedList import *
from signup import Signup
from rafay.history import *
import os
from string import punctuation
from Essentials.Ratingtree import Binarytree

response = ''
app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = os.path.join("")
db = TinyDB("database.json")
query = Query()
admin_table = db.table("Admin_Data")
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


@app.route('/nexteps')
def next_eps():
    # token = request.args.get('token')
    # profile = request.args.get('profile')
    # epsno = request.args.get('epsno')
    # id = request.args.get('id')
    type = "anime"
    token = "9d228589-8dfd-11ed-a1bc-507b9d7ca8a6"
    profile = "humam02"
    id = "tv/watch-initial-d-fourth-stage-project-d-20269"
    epsno = 3

    response = jsonify({"result": nextepisode(type,token,profile,id,epsno)})
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


@app.route("/getAllAnime", methods=["GET"])
def getAllAnime():
    response = jsonify({"result": anime_table.all()})
    return make_response(response)


@app.route("/getAllShow", methods=["GET"])
def getAllShow():
    response = jsonify({"result": show_table.all()})
    return make_response(response)


@app.route("/search", methods=["POST"])
def search():
    request_data = request.args
    print(request_data.keys())
    if "name" in request_data.keys():
        name = request_data["name"].lower()
        searchs = [name]
        for i in punctuation:
            name = name.replace(i, "")
        searchs.extend(name.split())
        print(searchs)
        result = []
        # print(movies_table.all())
        for data in movies_table.all():
            title = data["title"].lower()
            for i in punctuation:
                title = title.replace(i, "")
            [result.append(data)
             for i in searchs if i in title and data not in result]

        for data in anime_table.all():
            title = data["title"].lower()
            for i in punctuation:
                title = title.replace(i, "")
            [result.append(data)
             for i in searchs if i in title and data not in result]

        for data in show_table.all():
            title = data["title"].lower()
            for i in punctuation:
                title = title.replace(i, "")
            [result.append(data)
             for i in searchs if i in title and data not in result]

        if result:
            return make_response(jsonify(result))
        else:
            return make_response(jsonify({"msg": "no data found!"}), 400)

    if "id" in request_data.keys():
        print(request_data["id"])
    if "id" not in request_data.keys() and "name" not in request_data.keys():
        return make_response(jsonify({"msg": "id or name is required"}), 400)
    return "search"

@app.route("/getlink")
def getlink():
    # https://api.consumet.org/movies/flixhq/watch?episodeId=928225&mediaId=tv/watch-initial-d-fourth-stage-project-d-20269

    request_data = request.args
    s_id = request_data["id"]
    eps_id = request_data["epsid"]
    token = request_data["token"]
    profile = request_data["profile"]
    anime_data = anime_table.all()
    r = requests.get(f"https://api.consumet.org/movies/flixhq/watch?episodeId={eps_id}&mediaId={s_id}")
    create_watched(anime_data,token,profile,s_id)
    return make_response(r.json()["sources"][0])
    

@app.route("/files")
def fileget():
    # request_data = request.args
    # file = request_data["file"]
    return "sda"
    # return send_file(f"files/{file}",mimetype='application/x-mpegURL')

@app.route("/get_rating_movie")
def rat_get_mov():
    # request_data = request.args
    # rat = request_data["rating"]
    result = []
    with open(f'Movies.pkl', 'rb') as enc_file:
        tree_mov = pickle.load(enc_file)

    
    result += tree_mov.find_mov(8.1)
    result += tree_mov.find_mov(7.8)
    result += tree_mov.find_mov(7.4)
    result += tree_mov.find_mov(7.3)
    
    return make_response(jsonify(result))

@app.route("/get_rating_show")
def rat_get_show():
    # request_data = request.args
    # rat = request_data["rating"]
    result = []
    with open(f'Tv Show.pkl', 'rb') as enc_file:
        tree_show = pickle.load(enc_file)

    
    result += tree_show.find_show(8.4)
    result += tree_show.find_show(7.3)
    result += tree_show.find_show(6.6)
  
    
    return make_response(jsonify(result))
    

@app.route("/get_rating_anime")
def rat_get_anime():
    # request_data = request.args
    # rat = request_data["rating"]
    result = []
    with open(f'Animation.pkl', 'rb') as enc_file:
        tree_anime = pickle.load(enc_file)

    
    result += tree_anime.find_anime(8.8)
    result += tree_anime.find_anime(8.6)
    result += tree_anime.find_anime(8.5)
    result += tree_anime.find_anime(8.2)
    
    return make_response(jsonify(result))

@app.route("/adminlogin",methods=["GET","POST"])
def adminlogin():

    error = None
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]

        if admin_table.search(query.username == username):
            data = admin_table.search(query.username == username).pop()
            if data["password"] == password:
                return redirect("/add")
            else:
                error = "Invalid Password"
        else:
            error = "Invalid Username"


    return render_template("adminlogin.html",error=error)


@app.route("/add",methods=["GET","POST"])
def add():

    error = None
    if request.method == "POST":
        type = request.form["type"]
        id = request.form["id"]
        epsid = request.form["epsid"]
        epsno = request.form["epsno"]
        pass


    return render_template("add.html",error=error)


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0")
