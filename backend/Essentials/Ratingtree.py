#from Exceptions import *
import random
import json
import pickle
from tinydb import TinyDB, Query

class Node():
    def __init__(self, data):
        self.data = data
        self.left = None
        self.right = None
        self.ids  = []


class Binarytree():
    def __init__(self , name):
        self.name = name
        self.root = None

#-----------------------------------------------------------------------------------------------------------------------------------------
#                                                --- Movie funtionalities ---
#-----------------------------------------------------------------------------------------------------------------------------------------

    def insert_mov(self, rat , tree):

        
        if self.root == None:
            self.root = Node(rat)
            table = TinyDB("database.json").table("Movie_data")
            q = Query()
            for data in table.search(q.rating == rat):
                self.root.ids.append(data["id"])




        elif rat < tree.data:
            if tree.left is None:
             tree.left = Node(rat)
             table = TinyDB("database.json").table("Movie_data")
             q = Query()
             for data in table.search(q.rating == rat):
                tree.left.ids.append(data["id"])

            else:
                self.insert_mov(rat, tree.left)

        elif rat > tree.data:
            if tree.right is None:
             tree.right = Node(rat)
             table = TinyDB("database.json").table("Movie_data")
             q = Query()
             for data in table.search(q.rating == rat):
                tree.right.ids.append(data["id"])

            else:
                self.insert_mov(rat, tree.right)


    def add_mov(self , ids):
        
        table = TinyDB("database.json").table("Movie_data")
        q = Query()

        for data in table.search(q.id == ids):
            rating = data['rating']

        self._add_mov(rating , self.root , ids)

    def _add_mov(self , data , root , ids):
            
        if data == root.data:
            
            root.ids.append(ids) 

        elif data < root.data:

    
            self._add_mov(data , root.left ,ids)

        elif data > root.data:

    
            self._add_mov(data , root.right ,ids)
        


    def find_mov(self , rating):
        return self.rating_based_mov(rating , self.root)
         
    def rating_based_mov(self , data , root):

        if data == root.data:
            
            return root.ids
           
        elif data < root.data:
            
            return self.rating_based_mov(data , root.left)

        elif data > root.data:

            return self.rating_based_mov(data , root.right)


    def remove_mov(self ,ids):

        table = TinyDB("database.json").table("Movie_data")
        q = Query()

        for data in table.search(q.id == ids):
            rating = data['rating']

        self._remove_mov(rating , self.root , ids)


    def _remove_mov(self , data , root , ids):

        if data == root.data:
            
            if ids in root.ids:


                root.ids.remove(ids)



        elif data < root.data:

    
            self._remove_mov(data , root.left , ids)

        elif data > root.data:

    
            self._remove_mov(data , root.right , ids)

#-----------------------------------------------------------------------------------------------------------------------------------------
#                                                     --- Tv Shows functionality ---
#-----------------------------------------------------------------------------------------------------------------------------------------
 
    def insert_show(self, rat , tree):


        if self.root == None:
            self.root = Node(rat)
            table = TinyDB("database.json").table("Show_data")
            q = Query()
            for data in table.search(q.rating == rat):
                self.root.ids.append(data["id"])


        elif rat < tree.data:
            if tree.left is None:
             tree.left = Node(rat)
             table = TinyDB("database.json").table("Show_data")
             q = Query()
             for data in table.search(q.rating == rat):
                tree.left.ids.append(data["id"])

            else:
                self.insert_show(rat, tree.left)

        elif rat > tree.data:
            if tree.right is None:
             tree.right = Node(rat)
             table = TinyDB("database.json").table("Show_data")
             q = Query()
             for data in table.search(q.rating == rat):
                tree.right.ids.append(data["id"])

            else:
                self.insert_show(rat, tree.right)


    def add_show(self , ids):
        
        table = TinyDB("database.json").table("Show_data")
        q = Query()

        for data in table.search(q.id == ids):
            rating = data['rating']

        self._add_show(rating , self.root , ids)

    def _add_show(self , data , root , ids):
            
        if data == root.data:

            root.ids.append(ids) 

        elif data < root.data:

    
            self._add_show(data , root.left , ids)

        elif data > root.data:

    
            self._add_show(data , root.right , ids)
        

    def find_show(self , rating):
        return self.rating_based_mov(rating , self.root)
        

    def rating_based_show(self , data , root):

        if data == root.data:
            
            return root.ids
           
        elif data < root.data:
    
            return self.rating_based_show(data , root.left)

        elif data > root.data:

           return self.rating_based_show(data , root.right)


    def remove_show(self ,ids):

        table = TinyDB("database.json").table("Show_data")
        q = Query()

        for data in table.search(q.id == ids):
            rating = data['rating']

        self._remove_show(rating , self.root , ids)


    def _remove_show(self , data , root , ids):

        if data == root.data:
            
            if ids in root.ids:
                root.ids.remove(ids)
   


        elif data < root.data:

    
            self._remove_show(data , root.left , ids)

        elif data > root.data:

    
            self._remove_show(data , root.right , ids)


#-----------------------------------------------------------------------------------------------------------------------------------------
#                                                    --- Anime functionalities ---
#-----------------------------------------------------------------------------------------------------------------------------------------
    def insert_anime(self, rat , tree):


        if self.root == None:
            self.root = Node(rat)
            table = TinyDB("database.json").table("Anime_data")
            q = Query()
            for data in table.search(q.rating == rat):
                self.root.ids.append(data["id"])


        elif rat < tree.data:
            if tree.left is None:
             tree.left = Node(rat)
             table = TinyDB("database.json").table("Anime_data")
             q = Query()
             for data in table.search(q.rating == rat):
                tree.left.ids.append(data["id"])

            else:
                self.insert_anime(rat, tree.left)

        elif rat > tree.data:
            if tree.right is None:
             tree.right = Node(rat)
             table = TinyDB("database.json").table("Anime_data")
             q = Query()
             for data in table.search(q.rating == rat):
                tree.right.ids.append(data["id"])

            else:
                self.insert_anime(rat, tree.right)


    def add_anime(self , ids):
        
        table = TinyDB("database.json").table("Anime_data")
        q = Query()

        for data in table.search(q.id == ids):
            rating = data['rating']

        self._add_anime(rating , self.root , ids)

    def _add_anime(self , data , root , ids):
         
        if data == root.data:
        
            root.ids.append(ids) 

        elif data < root.data:

    
            self._add_anime(data , root.left , ids)

        elif data > root.data:

    
            self._add_anime(data , root.right , ids)
        

    def find_anime(self , rating):
        return self.rating_based_mov(rating , self.root)
   

    def rating_based_anime(self , data , root):

        if data == root.data:
            
            return root.ids
           
        elif data < root.data:
    
            return self.rating_based_anime(data , root.left)

        elif data > root.data:

            return self.rating_based_anime(data , root.right)

    def remove_anime(self ,ids):

        table = TinyDB("database.json").table("Anime_data")
        q = Query()

        for data in table.search(q.id == ids):
            rating = data['rating']

        self._remove_anime(rating , self.root , ids)


    def _remove_anime(self , data , root , ids):

        if data == root.data:
            
            if ids in root.ids:
                root.ids.remove(ids)


        elif data < root.data:

    
            self._remove_anime(data , root.left , ids)

        elif data > root.data:

    
            self._remove_anime(data , root.right , ids)
    
    def save_tree(self):
        
        with open(f'{self.name}.pkl', 'wb') as enc_file:
            pickle.dump(self, enc_file, None)

#-----------------------------------------------------------------------------------------------------------------------------------------


tree_mov = Binarytree("Movies")
# tree_show = Binarytree("Tv Show")
# tree_anime = Binarytree("Animation")
# tree_mov.insert_mov(5.0 , tree_mov.root)
# tree_show.insert_show(5.0 , tree_show.root)
# tree_anime.insert_anime(5.0 , tree_anime.root)




# #-----------------------------------------------------------------------------------------------------------------------------------------
# #                                                    --- Combined functionality ---
# #-----------------------------------------------------------------------------------------------------------------------------------------



# def reverse_crisis(tree):
#     trav = []

#     if tree:
#         trav += reverse_crisis(tree.right)
#         for i in tree.ids:
#             trav.append(f"{tree.data}--{i}")
#         trav += reverse_crisis(tree.left)

#     return trav



# #-----------------------------------------------------------------------------------------------------------------------------------------
# # Ratings tree data

# rat_below_5 = [4.9, 4.8, 4.7, 4.6, 4.5, 4.4, 4.3, 4.2, 4.1, 4.0, 3.9, 3.8, 3.7, 3.6, 3.5, 3.4, 3.3, 3.2, 3.1, 3.0, 2.9, 2.8, 2.7, 2.6,
#                2.5, 2.4, 2.3, 2.2, 2.1, 2.0, 1.9, 1.8, 1.7, 1.6, 1.5, 1.4, 1.3, 1.2, 1.1, 1.0, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1]
# rat_above_5=  [ 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8,5.9, 6.0, 6.1, 6.2, 6.3, 6.4, 6.5, 6.6, 6.7, 6.8, 6.9, 7.0, 7.1, 7.2, 7.3, 7.4,
#                7.5, 7.6, 7.7, 7.8, 7.9, 8.0, 8.1, 8.2, 8.3, 8.4, 8.5, 8.6, 8.7, 8.8, 8.9, 9.0, 9.1, 9.2, 9.3, 9.4, 9.5, 9.6, 9.7, 9.8, 9.9, 10]


# for i in rat_above_5:
#     tree_mov.insert_mov(i , tree_mov.root)
#     tree_show.insert_show(i , tree_show.root)
#     tree_anime.insert_anime(i , tree_anime.root)


# for i in rat_below_5:
#     tree_mov.insert_mov(i , tree_mov.root)
#     tree_show.insert_show(i , tree_show.root)
#     tree_anime.insert_anime(i , tree_anime.root)
    

#print(reverse_crisis(tree_mov.root))
# print(reverse_crisis(tree_show.root))
# print(reverse_crisis(tree_anime.root))


# # print(tree_mov.find_mov(6.4))
# # tree_mov.remove_mov("movie/watch-ricki-and-the-flash-11576")
# # print(reverse_crisis(tree_mov.root))
# # tree_mov.add_mov("movie/watch-ricki-and-the-flash-11576")
# # print(reverse_crisis(tree_mov.root))

# tree_mov.save_tree()

# tree_show.save_tree()
# tree_anime.save_tree()





#-----------------------------------------------------------------------------------------------------------------------------------------``