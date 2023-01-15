import random
import json
import pickle
from tinydb import TinyDB, Query


# class Node():
#     def __init__(self, data):
#         self.data = data
#         self.left = None
#         self.right = None
#         self.ids = []


# class Binarytree():
#     def __init__(self):
#         self.root = None

#     def insert(self, data):
#         if self.root == None:
#             self.root = Node(data)
#             table = TinyDB("database.json").table("Movie_data")
#             q = Query()
#             # print("Action" in q.genres)
#             for data in table.search(q.rating == data):
#                 # if "Drama" in data["genres"]:
#                 self.root.ids.append(data["id"])

#         else:
#             self._insert(data, self.root)

#     def _insert(self, data, curr):

#         if data < curr.data:
#             if curr.left is None:
#                 curr.left = Node(data)

#             else:
#                 self._insert(data, curr.left)

#         elif data > curr.data:
#             if curr.right is None:
#                 curr.right = Node(data)

#             else:
#                 self._insert(data, curr.right)

#     def binary_tree_to_json(self, tree):
#         """Convert a binary tree to a JSON string."""
#         def serialize(node):
#             if not node:
#                 return None
#             return {'val': node.data, 'left': serialize(node.left), 'right': serialize(node.right)}

#         return json.dumps(serialize(tree.root))


# tree = Binarytree()
# route = []
# L = [5.6, 15, 2, 25, 6, 7, 8, 12, 11, 16]

# for i in L:
#     tree.insert(i)

# print(tree.root.ids)

# tree_rep = tree.binary_tree_to_json(tree)

# with open('rating_tree.json', 'w') as f:
#     json.dump(tree_rep, f)
# Lp = ['Action', 'Adventure', 'Science Fiction', 'Fantasy', 'Drama', 'Thriller',
#     'Horror', 'Mystery', 'Family', 'War', 'Comedy', 'Romance', 'Music', 'Animation']


# Lo = []
# table = TinyDB("database.json").table("Movie_data")
# for data in table:
#     for i in Lp:
#         if i in data["genres"]:

#             Lo.append(data["id"])


# L = [1,2,3,4,5,6,7,8,9]

# for i in L:
#     print(i)
#     L.pop()

# print(L)


