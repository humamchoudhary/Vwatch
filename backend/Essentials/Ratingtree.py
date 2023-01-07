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
    def __init__(self):
        self.root = None


    def insert_mov(self, data):


        if self.root == None:
            self.root = Node(data)
            table = TinyDB("database.json").table("Movie_data")
            q = Query()
            for data in table.search(q.rating == data):
                self.root.ids.append(data["id"])


        elif data < self.root.data:
            if self.root.left is None:
             self.root.left = Node(data)
             table = TinyDB("database.json").table("Movie_data")
             q = Query()
             for data in table.search(q.rating == data):
                self.root.ids.append(data["id"])

            else:
                self._insert(data, self.root.left)

        elif data > self.root.data:
            if self.root.right is None:
             self.root.right = Node(data)
             table = TinyDB("database.json").table("Movie_data")
             q = Query()
             for data in table.search(q.rating == data):
                self.root.ids.append(data["id"])

            else:
                self._insert(data, self.root.right)


    def insert_show(self, data):


        if self.root == None:
            self.root = Node(data)
            table = TinyDB("database.json").table("Show_data")
            q = Query()
            for data in table.search(q.rating == data):
                self.root.ids.append(data["showid"])


        elif data < self.root.data:
            if self.root.left is None:
             self.root.left = Node(data)
             table = TinyDB("database.json").table("Show_data")
             q = Query()
             for data in table.search(q.rating == data):
                self.root.ids.append(data["showid"])

            else:
                self._insert(data, self.root.left)

        elif data > self.root.data:
            if self.root.right is None:
             self.root.right = Node(data)
             table = TinyDB("database.json").table("Show_data")
             q = Query()
             for data in table.search(q.rating == data):
                self.root.ids.append(data["showid"])

            else:
                self._insert(data, self.root.right)



    def insert_anime(self, data):


        if self.root == None:
            self.root = Node(data)
            table = TinyDB("database.json").table("Anime_data")
            q = Query()
            for data in table.search(q.rating == data):
                self.root.ids.append(data["animeID"])


        elif data < self.root.data:
            if self.root.left is None:
             self.root.left = Node(data)
             table = TinyDB("database.json").table("Anime_data")
             q = Query()
             for data in table.search(q.rating == data):
                self.root.ids.append(data["animeID"])

            else:
                self._insert(data, self.root.left)

        elif data > self.root.data:
            if self.root.right is None:
             self.root.right = Node(data)
             table = TinyDB("database.json").table("Movie_data")
             q = Query()
             for data in table.search(q.rating == data):
                self.root.ids.append(data["animeID"])

            else:
                self._insert(data, self.root.right)

    # def binary_tree_to_json(self, tree):
    #     """Convert a binary tree to a JSON string."""
    #     def serialize(node):
    #         if not node:
    #             return None
    #         return {'val': node.data, 'left': serialize(node.left), 'right': serialize(node.right)}

    #     return json.dumps(serialize(tree.self.root))

tree_mov = Binarytree()
tree_mov.insert_mov(5.6)

print(tree_mov.root.ids)



























#------------------------------------------------------------------------------------------------------------------------------------------------------
# Ratings tree data

rat_below_5 = [4.9, 4.8, 4.7, 4.6, 4.5, 4.4, 4.3, 4.2, 4.1, 4.0, 3.9, 3.8, 3.7, 3.6, 3.5, 3.4, 3.3, 3.2, 3.1, 3.0, 2.9, 2.8, 2.7, 2.6, 2.5, 2.4, 2.3, 2.2, 2.1, 2.0, 1.9, 1.8, 1.7, 1.6, 1.5, 1.4, 1.3, 1.2, 1.1, 1.0, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1]
rat_above_5=  [ 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8,5.9, 6.0, 6.1, 6.2, 6.3, 6.4, 6.5, 6.6, 6.7, 6.8, 6.9, 7.0, 7.1, 7.2, 7.3, 7.4, 7.5, 7.6, 7.7, 7.8, 7.9, 8.0, 8.1, 8.2, 8.3, 8.4, 8.5, 8.6, 8.7, 8.8, 8.9, 9.0, 9.1, 9.2, 9.3, 9.4, 9.5, 9.6, 9.7, 9.8, 9.9, 10]


#for i in rat:
#     tree.insert(i)


# tree_rep = tree.binary_tree_to_json(tree)

# with open('rating_tree.json', 'w') as f:
#     json.dump(tree_rep, f)