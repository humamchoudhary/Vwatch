# import urllib
# from flask import Flask, jsonify, make_response, request, send_file, render_template, Response
# import json
# import requests
# from tinydb import TinyDB, Query
# from login import Login
# from Essentials.UserTree import *
# from Essentials.Account import *
# from signup import Signup
# import os
# import gdown
# response = ''
# app = Flask(__name__)
# app.config['UPLOAD_FOLDER'] = os.path.join("")

# db = TinyDB("database.json")
# query = Query()
# movie_table = db.table("Movie_data")


# @app.route("/download")
# def download():

#     url = "https://drive.google.com/drive/folders/1qShpdNhjEZmmOArbfIq2xFNncGDMetSL?usp=sharing"
#     if url.split('/')[-1] == '?usp=sharing':
#         url = url.replace('?usp=sharing', '')

#     gdown.download_folder(url)


# @app.route("/getfile")
# def get_file():
#     file = os.listdir("./")
#     list = []
#     for i in file:
#         list.append(i)
#     response = jsonify({
#         "data":list
#     })
#     return response


# if __name__ == "__main__":
#     app.run(debug=True, host="0.0.0.0")

