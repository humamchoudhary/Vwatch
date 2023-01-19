from flask import Flask, jsonify, make_response, request, send_file, render_template, redirect, Response
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
from Essentials.GenreTree import Genre

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
        print(username, password)

        try:
            account = Login(username, password)
            account = account.account
            response = jsonify({"error": "Logged in", "account": {
                "token": f"{account.account}",
                               "username": account.account.username, "profiles": account.get_all_profiles()}})
            return make_response(response, 200)
        except Exception as e:
            print(str(e))
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
            signup.tree.save_user()
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


@app.route('/preveps')
def prev_eps():
    request_data = request.args
    content_type = request_data["content_type"]
    token = request_data['token']
    profile = request_data['profile']
    epsno = int(request_data['epsno'])
    id = request_data['id']
    # type = "anime"
    # token = "9d228589-8dfd-11ed-a1bc-507b9d7ca8a6"
    # profile = "humam02"
    # id = "tv/watch-initial-d-fourth-stage-project-d-20269"
    # epsno = 3

    response = jsonify(
        {"result": nextepisode(content_type, token, profile, id, epsno)})
    return make_response(response)


@app.route('/nexteps')
def next_eps():
    request_data = request.args
    content_type = request_data["content_type"]
    token = request_data['token']
    profile = request_data['profile']
    epsno = int(request_data['epsno'])
    id = request_data['id']

    # type = "anime"
    # token = "9d228589-8dfd-11ed-a1bc-507b9d7ca8a6"
    # profile = "humam02"
    # id = "tv/watch-initial-d-fourth-stage-project-d-20269"
    # epsno = 3

    response = jsonify(
        {"result": nextepisode(content_type, token, profile, id, epsno)})
    return make_response(response)


@app.route("/completed_eps")
def resume():
    request_data = request.args
    content_type = request_data["content_type"]
    token = request_data['token']
    profile = request_data['profile']
    id = request_data['id']
    if content_type == "anime":
        data = anime_table.all()
    else:
        data = show_table.all()
    response = jsonify(
        {"result": completed_eps(data,token,profile,id)})

    return make_response(response)
    


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
        id = request_data["id"]
        result = []
        # print(movies_table.all())
        for data in movies_table.all():
            if id == data["id"]:
                result.append(data)

        for data in anime_table.all():
            if id == data["id"]:
                result.append(data)

        for data in show_table.all():
            if id == data["id"]:
                result.append(data)

        if result:
            return make_response(jsonify(result))
        else:
            return make_response(jsonify({"msg": "no data found!"}), 400)

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
    content_type = request_data["content_type"]
    data = []
    if content_type == "anime":
        data = anime_table.all()
    elif content_type == "tvshow":
        data = show_table.all()
    else:
        data.extend(anime_table.all())
        data.extend(show_table.all())
        data.extend(movies_table.all())

    r = requests.get(
        f"https://api.consumet.org/movies/flixhq/watch?episodeId={eps_id}&mediaId={s_id}")
    create_watched(data, token, profile, s_id)
    return make_response(r.json()["sources"][0])


@app.route("/files")
def fileget():
    # request_data = request.args
    # file = request_data["file"]
    return "sda"
    # return send_file(f"files/{file}",mimetype='application/x-mpegURL')


# -----------------------------------------------------------------------------------------------------------------------------------------
#                                                --- Genre call functions ---
# -----------------------------------------------------------------------------------------------------------------------------------------

@app.route("/get_gen_movie",methods=["GET","POST"])
def gen_get_mov():
    request_data = request.data
    request_data = json.loads(request_data.decode('utf-8'))
    gen = request_data["gen"]
    print(gen)
    result = []
    with open(f'Movies gen.pkl', 'rb') as enc_file:
        gen_mov = pickle.load(enc_file)

    result = gen_mov.choose_by_gen_mov_2(gen)
    print(result)
    return make_response(jsonify(result))


@app.route("/get_gen_show",methods=["GET","POST"])
def gen_get_show():
    request_data = request.data
    request_data = json.loads(request_data.decode('utf-8'))
    gen = request_data["gen"]
    print(gen)

    result = []
    with open(f'Tv Show gen.pkl', 'rb') as enc_file:
        gen_tv = pickle.load(enc_file)

    result = gen_tv.choose_by_gen_show_2(gen)
    print(result)
    return make_response(jsonify(result))


@app.route("/get_gen_anime",methods=["GET","POST"])
def gen_get_anime():
    request_data = request.data
    request_data = json.loads(request_data.decode('utf-8'))
    gen = request_data["gen"]
    print(gen)
    result = []
    with open(f'Anime gen.pkl', 'rb') as enc_file:
        gen_anime = pickle.load(enc_file)

    result = gen_anime.choose_by_gen_anime_2(gen)
    return make_response(jsonify(result))


# -----------------------------------------------------------------------------------------------------------------------------------------
#                                                --- Rating call functions ---
# -----------------------------------------------------------------------------------------------------------------------------------------
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


@app.route("/adminlogin", methods=["GET", "POST"])
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

    return render_template("adminlogin.html", error=error)


@app.route("/add", methods=["GET", "POST"])
def add():

    error = None
    success = None
    if request.method == "POST":
        content_type = request.form["type"]
        id = request.form["id"]
        epsid = request.form["epsid"]
        epsno = int(request.form["epsno"])
        if content_type == 'anime':
            table = anime_table
            content = "Anime"
        else:
            table = show_table
            content = "TV Show"
        if table.search(query.id == id):

            data = table.search(query.id == id)[0]
            curr_ep = data["episodes"][-1]["epNo"]
            title = data["title"]
            if data["episodes"][-1]["epNo"] == epsno-1:
                data["episodes"].append({'id': epsid,
                                         'epNo': epsno}
                                        )
                table.upsert(data, query.id ==
                             "tv/watch-initial-d-fourth-stage-project-d-20269")
                create_linkedlist(content_type, table)
                success = f"Episode no {epsno} added to {content}: {title}"
            else:
                error = f"The latest episode is {curr_ep}, Please add the next episode"
                return render_template("add.html", error=error)
        else:
            error = f"{content} with this ID doesnt exist"
            return render_template("add.html", error=error)

    return render_template("add.html", error=error, success=success)


@app.route("/get_history")
def get_history():
    request_data = request.args

    response = None
    token = request_data["token"]
    profile = request_data["profile"]
    file = open(f'{token}.pkl', 'rb')
    user_tree = pickle.load(file)
    file.close()
    profile = user_tree.load_profile(profile)
    r = requests.get("http://127.0.0.1:5000/search")
    # profile.watch_history.reset()
    # user_tree.save_user()
    response = jsonify({"data": profile.watch_history.get_all()})
    return make_response(response)


@app.route("/add_history")
def Add_history():
    request_data = request.args
    token = request_data["token"]
    response = None
    id = request_data["id"]
    profile = request_data["profile"]
    file = open(f'{token}.pkl', 'rb')
    user_tree = pickle.load(file)
    file.close()
    profile = user_tree.load_profile(profile)
    result = []
    # print(movies_table.all())
    for data in movies_table.all():
        if id == data["id"]:
            result.append(data)

    for data in anime_table.all():
        if id == data["id"]:
            result.append(data)

    for data in show_table.all():
        if id == data["id"]:
            result.append(data)

    if result:
        for i in result:
            profile.add_to_watch_history(i)

        user_tree.save_user()
        return make_response(jsonify(result))
    else:
        return make_response(jsonify({"msg": "no data found!"}), 400)


@app.route("/add_watchlist")
def watch_later():
    request_data = request.args
    id = request_data["id"]
    token = request_data["token"]
    profile = request_data["profile"]
    with open(f'{token}.pkl', 'rb') as f:
        usertree = pickle.load(f)

    userprofile = usertree.load_profile(profile)

    result = []
    # print(movies_table.all())
    for data in movies_table.all():
        if id == data["id"]:
            result.append(data)

    for data in anime_table.all():
        if id == data["id"]:
            result.append(data)

    for data in show_table.all():
        if id == data["id"]:
            result.append(data)

    if result:
        for i in result:
            userprofile.watch_list.enqueue(i)

        usertree.save_user()
        return make_response(jsonify(result))
    else:
        return make_response(jsonify({"msg": "no data found!"}), 400)


@app.route("/get_watchlist")
def watch_later2():
    request_data = request.args
    token = request_data["token"]
    profile = request_data["profile"]
    with open(f'{token}.pkl', 'rb') as f:
        usertree = pickle.load(f)

    userprofile = usertree.load_profile(profile)
    return make_response(jsonify({"watchlist": list(userprofile.watch_list.l)}))


@app.route("/clean_watchlist")
def watchclear():
    request_data = request.args
    token = request_data["token"]
    profile = request_data["profile"]
    with open(f'{token}.pkl', 'rb') as f:
        usertree = pickle.load(f)

    userprofile = usertree.load_profile(profile)
    userprofile.watch_list.clean()
    usertree.save_user()
    return "ok"


@app.route("/del_watchlist")
def watch_later3():
    request_data = request.args
    s_id = request_data["id"]
    token = request_data["token"]
    profile = request_data["profile"]
    with open(f'{token}.pkl', 'rb') as f:
        usertree = pickle.load(f)

    userprofile = usertree.load_profile(profile)
    userprofile.watch_list.delete(s_id)
    usertree.save_user()
    return "ok"


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0")
