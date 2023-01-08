#from Exceptions import *
import random
import json
import pickle
from tinydb import TinyDB, Query



class Node:

    def __init__(self , name , parent = None ):

        self.data = name
        self.parent = parent
        self.lind = []
        


class Genre:
    
    def __init__(self):
        self.root = None
        self.children = []



        


movie_gen = Node("Movies")
tv_gen = Node("Tv Shows")
anime_gen = Node("Anime")


def make_genre_mov(gen):

    action = Node( "Action" , parent = gen)
    adventure = Node( "Adventure" , parent = gen)
    science_fiction = Node( "Science_Fiction" , parent = gen)
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