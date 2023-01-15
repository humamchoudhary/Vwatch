#from Exceptions import *
import random
import json
import pickle
from tinydb import TinyDB, Query



class Node:

    def __init__(self , name , parent = None ):

        self.data = name
        self.parent = parent
        self.ids = []
        


class Genre:
    
    def __init__(self , name):
        self.root = Node(name)


    def make_genre(self , gen):

        action = Node( "Action" , parent = gen)
        adventure = Node( "Adventure" , parent = gen)
        science_fiction = Node( "Science Fiction" , parent = gen)
        fantasy = Node( "Fantasy" , parent = gen)
        drama = Node( "Drama" , parent = gen)
        thriller = Node( "Thriller" , parent = gen)
        horror = Node( "Horror" , parent = gen)
        mystery = Node( "Mystery" , parent = gen)
        family = Node( "Family" , parent = gen)
        war = Node( "War" , parent = gen) 
        comedy = Node( "Comedy" , parent = gen)
        romance = Node( "Romance" , parent = gen)
        music = Node( "Music" , parent = gen)
        animation = Node( "Animation" , parent = gen)


        self.root.ids.append(action)
        self.root.ids.append(adventure)
        self.root.ids.append(science_fiction)
        self.root.ids.append(fantasy)
        self.root.ids.append(drama)
        self.root.ids.append(thriller)
        self.root.ids.append(horror)
        self.root.ids.append(mystery)
        self.root.ids.append(family)
        self.root.ids.append(war)
        self.root.ids.append(comedy)
        self.root.ids.append(romance)
        self.root.ids.append(music)
        self.root.ids.append(animation)




#-----------------------------------------------------------------------------------------------------------------------------------------
#                                                --- Movie funtionalities ---
#-----------------------------------------------------------------------------------------------------------------------------------------
        
    def gen_add_mov(self):

        table = TinyDB("database.json").table("Movie_data")
        for i in self.root.ids:
            for data in table:
                if i.data in data["genres"]:

                    i.ids.append(data["id"])


    def choose_by_gen_mov(self , chose):

       
       for i in self.root.ids:
        
        if i.data == chose:

            return i.ids


    def choose_by_gen_mov_2(self , cho1 , cho2):

        half = self.choose_by_gen_mov(cho1)
        new = []
        print(half)
        for i in self.root.ids:
            if i.data == cho2:
                for ck in half:
                    if ck in i.ids:
                        new.append(ck)
                    
                return new
                        
                    
    def gen_add_mov_1(self , Id):

        table = TinyDB("database.json").table("Movie_data")
        q = Query()
        for data in table.search(q.id == Id):
            for i in self.root.ids:
                if i.data in data["genres"]:
                    i.ids.append(data["id"])


#-----------------------------------------------------------------------------------------------------------------------------------------
#                                                     --- Tv Shows functionality ---
#-----------------------------------------------------------------------------------------------------------------------------------------


    def gen_add_show(self):

        table = TinyDB("database.json").table("Show_data")
        for data in table:
            for i in self.root.ids:
                if i.data in data["genres"]:

                    i.ids.append(data["id"])


    def choose_by_gen_show(self , chose):

       
       for i in self.root.ids:
        
        if i.data == chose:

            return i.ids


    def choose_by_gen_show_2(self , cho1 , cho2):

        half = self.choose_by_gen_show(cho1)
        new = []
        print(half)
        for i in self.root.ids:
            if i.data == cho2:
                for ck in half:
                    if ck in i.ids:
                        new.append(ck)
                    
                return new
                        
                    
    def gen_add_show_1(self , Id):

        table = TinyDB("database.json").table("Show_data")
        q = Query()
        for data in table.search(q.id == Id):
            for i in self.root.ids:
                if i.data in data["genres"]:
                    i.ids.append(data["id"])


#-----------------------------------------------------------------------------------------------------------------------------------------
#                                                    --- Anime functionalities ---
#-----------------------------------------------------------------------------------------------------------------------------------------


    def gen_add_anime(self):

        table = TinyDB("database.json").table("Anime_data")
        for data in table:
            for i in self.root.ids:
                if i.data in data["genres"]:

                    i.ids.append(data["id"])


    def choose_by_gen_anime(self , chose):

       
       for i in self.root.ids:
        
        if i.data == chose:

            return i.ids


    def choose_by_gen_anime_2(self , cho1 , cho2):

        half = self.choose_by_gen_anime(cho1)
        new = []
        print(half)
        for i in self.root.ids:
            if i.data == cho2:
                for ck in half:
                    if ck in i.ids:
                        new.append(ck)
                    
                return new
                        
                    
    def gen_add_anime_1(self , Id):

        table = TinyDB("database.json").table("Anime_data")
        q = Query()
        for data in table.search(q.id == Id):
            for i in self.root.ids:
                if i.data in data["genres"]:
                    i.ids.append(data["id"])


#-----------------------------------------------------------------------------------------------------------------------------------------
#                                                            --- crisis ---
#-----------------------------------------------------------------------------------------------------------------------------------------




# movie_gen = Genre("Movies")
# movie_gen.make_genre(movie_gen)
# movie_gen.gen_add_mov()
# print(movie_gen.choose_by_gen_mov("Music"))
# print(movie_gen.choose_by_gen_mov_2("Thriller","Action"))

# movie_gen.gen_add_mov1("movie/watch-mission-impossible-rogue-nation-19603")


# anime_gen = Genre("Anime")
# anime_gen.make_genre(anime_gen)
# anime_gen.gen_add_anime()




#-----------------------------------------------------------------------------------------------------------------------------------------







