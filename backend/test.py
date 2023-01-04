# # # from randimage import get_random_image, show_array
# # # import matplotlib

# # # img_size = (64,64)
# # # for i in range(12):
# # #     img = get_random_image(img_size)  #returns numpy array
# # #     # show_array(img) #shows the image
# # #     matplotlib.image.imsave(f"randimage{i}.png", img)
# # # x = []
# # # for i in range(12):
# # #     x.append(f"randimage{i}.png")
# # # # print(x)
# # # import m3u8_To_MP4

# # # if __name__ == '__main__':
# # #     # 1. Download mp4 from uri.
# # #     m3u8_To_MP4.multithread_download("https://wwwx15.gofcdn.com/videos/hls/b-5p-oMHFJnUflYYj5AGJQ/1672690031/25054/027e9529af2b06fe7b4f47e507a787eb/ep.1.1657688710.480.m3u8")

# # import os

# # # Path to the folder
# # folder_path = 'D:\Anime\initial d 4\Initial D Complete\Initial D Stages 1-6\Initial D - Fourth Stage'

# # # List all the files in the folder
# # files = os.listdir(folder_path)

# # # Print the file names
# # for file in files:
# #     print(file)
# import urllib
# from flask import Flask, jsonify, make_response, request, send_file, render_template
# import json
# from tinydb import TinyDB, Query
# from login import Login
# from Essentials.UserTree import *
# from Essentials.Account import *
# from signup import Signup
# import os

# db = TinyDB("database.json")
# query = Query()


# def download_file():
#     table = db.table("Movie_data")
#     data = table.search(query.title == "Poltergeist")

#     # Open a connection to the URL and read the file
#     print(data[0]["url"])
#     file = urllib.request.urlopen(data[0]["url"])
#     # Return the file to the client
#     return send_file(file, as_attachment=True)
# download_file()
import urllib.request

url = 'http://www.example.com/video.mp4'
urllib.request.urlretrieve(url, 'video.mp4')


{
    "id": "movie/watch-ricki-and-the-flash-11576",
    "title": "Ricki and the Flash",
    "coverImg": "https://img.flixhq.to/xxrz/250x400/379/51/ae/51aea729802811efd6db8b4772b3606c/51aea729802811efd6db8b4772b3606c.jpg",
    "desc": "\n        Meryl Streep stars as Ricki Rendazzo, a guitar heroine who made a world of mistakes as she followed her dreams of rock-and-roll stardom. Returning home, Ricki gets a shot at redemption and a chance to make things right as she faces the music with her family.\n    ",
            "genres": [
                "Drama",
                "Comedy",
                "Music"
            ],
    "url": "http://movietrailers.apple.com/movies/sony_pictures/rickiandtheflash/rickiandtheflash-tlr2_h480p.mov"
}
