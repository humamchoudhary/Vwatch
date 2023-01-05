

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

    def nextep(self,eps_no,token,profile):
        """
            - Find the current Eps in link list
            - Search next eps in database
            - Complete The current eps
        """
        return self.head.next.data["url"]  #ik its wrong just checking if the func ca be called

    def complete(self,eps_no,token,profile):
        pass          



if __name__=="__main__":
    list = LinkedList()
    