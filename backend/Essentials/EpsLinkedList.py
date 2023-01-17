import pickle

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


    def prevep(self,eps_no,token,profilename):
        if self.head == None:
            return "List is empty"
            
            
        itr = self.head
        while itr:
            if itr.next.data['epNo'] == eps_no:
                return itr.data["url"]
                
            itr = itr.next

    def nextep(self,token,profilename,id,eps_no):

        if self.head == None:
            return "List is empty"
            
            
        itr = self.head
        while itr:
            if itr.data['epNo'] == eps_no:
                # print(itr.next.data["url"])
                return self.complete(token,profilename,id,eps_no)
            itr = itr.next
            
        return "Episode doesn't exist"
        
        """
            - Find the current Eps in link list
            - Search next eps in database
            - Complete The current eps
        """
        
    def complete(self,token,profilename,id,eps_no):
        with open(f'{token}.pkl', 'rb') as f:
            usertree = pickle.load(f)

        userprofile = usertree.load_profile(profilename)
        userprofile.watched[id][eps_no-1] = True


        with open(f'{token}.pkl', 'wb') as w:
            pickle.dump(usertree,w)

        return 
              
def nexteps(type,token,profilename,id,eps_no):
    pass


# if __name__=="__main__":
#     list = LinkedList()
    