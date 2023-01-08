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

        Action = Node( "Action" , parent = mov_gen)
        Adventure = Node( "Action" , parent = mov_gen)
        Science_Fiction = Node( "Action" , parent = mov_gen)
        Fantasy = Node( "Action" , parent = mov_gen)
        Drama = Node( "Action" , parent = mov_gen)
        Thriller = Node( "Action" , parent = mov_gen)
        Horror = Node( "Action" , parent = mov_gen)
        Mystery = Node( "Action" , parent = mov_gen)
        Family = Node( "Action" , parent = mov_gen)
        War = Node( "Action" , parent = mov_gen) 
        Comedy = Node( "Action" , parent = mov_gen)
        Romance = Node( "Action" , parent = mov_gen)
        Music = Node( "Action" , parent = mov_gen)
        Animation = Node( "Action" , parent = mov_gen)
        


mov_gen = Node("Movies")