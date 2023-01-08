#from Exceptions import *
import random
import json
import pickle
from tinydb import TinyDB, Query



class Node:

    def __init__(self , name , parent = None ):

        self.data = name
        self.parent = parent
        


class Genre:
    
    def __init__(self):
        self.root = None


    def make_genre_mov(self):

        action = Node( "Action" , parent = mov_gen)
        adventure = Node( "Adventure" , parent = mov_gen)
        science_fiction = Node( "Science_Fiction" , parent = mov_gen)
        fantasy = Node( "Fantasy" , parent = mov_gen)
        drama = Node( "Drama" , parent = mov_gen)
        thriller = Node( "Thriller" , parent = mov_gen)
        horror = Node( "Horror" , parent = mov_gen)
        mystery = Node( "Mystery" , parent = mov_gen)
        family = Node( "Family" , parent = mov_gen)
        war = Node( "War" , parent = mov_gen) 
        comedy = Node( "Comedy" , parent = mov_gen)
        romance = Node( "Romance" , parent = mov_gen)
        music = Node( "Music" , parent = mov_gen)
        animation = Node( "Animation" , parent = mov_gen)
        


mov_gen = Node("Movies")