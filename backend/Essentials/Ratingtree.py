#from Exceptions import *
import random
import json
import pickle


class Node():
    def __init__(self, data):
        self.data = data
        self.left = None
        self.right = None
        self.ids  = []


class Binarytree():
    def __init__(self):
        self.root = None

    def insert(self, data):
        if self.root == None:
            self.root = Node(data)

        else:
            self._insert(data, self.root)

    def _insert(self, data, curr):

        if data < curr.data:
            if curr.left is None:
                curr.left = Node(data)

            else:
                self._insert(data, curr.left)

        elif data > curr.data:
            if curr.right is None:
                curr.right = Node(data)

            else:
                self._insert(data, curr.right)

    def binary_tree_to_json(self, tree):
        """Convert a binary tree to a JSON string."""
        def serialize(node):
            if not node:
                return None
            return {'val': node.data, 'left': serialize(node.left), 'right': serialize(node.right)}

        return json.dumps(serialize(tree.root))
# 8.0
# 5
#  \
#   7
#     \
#       8
#         \
#           9
# [{""},{""}]
#   def find(self , data , root ):

#     if root :


#       if data == root.data:

#         return root.data

#       elif data < root.data:

#           #left = "left root"
#           self.find(data , root.left )

#       elif data > root.data:

#           #right = "right root"
#           self.find(data , root.right)


#       else:
#           print(f"Empty tree")
#     else:
#       print(f"Not found")

tree = Binarytree()
tree.insert(5.0)

rat = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0, 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 2.9, 3.0, 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 4.0, 4.1, 4.2, 4.3, 4.4, 4.5, 4.6, 4.7, 4.8, 4.9, 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8,
       5.9, 6.0, 6.1, 6.2, 6.3, 6.4, 6.5, 6.6, 6.7, 6.8, 6.9, 7.0, 7.1, 7.2, 7.3, 7.4, 7.5, 7.6, 7.7, 7.8, 7.9, 8.0, 8.1, 8.2, 8.3, 8.4, 8.5, 8.6, 8.7, 8.8, 8.9, 9.0, 9.1, 9.2, 9.3, 9.4, 9.5, 9.6, 9.7, 9.8, 9.9, 10.0]


random.shuffle(rat)

for i in rat:
    tree.insert(i)


tree_rep = tree.binary_tree_to_json(tree)

with open('rating_tree.json', 'w') as f:
    json.dump(tree_rep, f)
