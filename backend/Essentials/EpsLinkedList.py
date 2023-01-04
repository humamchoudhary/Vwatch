

class Node:

    def __init__(self, data):
        self.data = data
        # self.status = None
        self.prev = None
        self.next = None

class LinkedList:

    def __init__(self):
        self.head = None

    def insert(self, data):
        if self.head == None:
            self.head = Node(data)
            return

        itr = self.head
        while itr.next:
            itr = itr.next

        itr.next = Node(data)


    def prevep(self):
        pass

    def nextep(self):
        return self.head.next.data["url"]  

    def complete(self):
        pass          



