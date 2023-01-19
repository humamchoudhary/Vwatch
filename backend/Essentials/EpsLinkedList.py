import pickle
import requests

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
            if itr.data['epNo'] == eps_no:
                eps_id = itr.data["id"]
                r = requests.get(
                f"https://api.consumet.org/movies/flixhq/watch?episodeId={eps_id}&mediaId={id}")
                return {"id":id,"epsid":eps_id,"url": r.json()["sources"][0]["url"]}
                
            itr = itr.next

    def nextep(self,token,profilename,id,eps_no):
        if self.head == None:
            return "List is empty"
            
            
        itr = self.head
        while itr:
            if itr.data['epNo'] == eps_no:
                eps_id = itr.data["id"]
                r = requests.get(
                f"https://api.consumet.org/movies/flixhq/watch?episodeId={eps_id}&mediaId={id}")
                return ({"id":id,"epsid":eps_id,"url": r.json()["sources"][0]["url"]},self.complete(token,profilename,id,eps_no))
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
        userprofile.watched[id][eps_no-2] = True
        print(userprofile.watched)

        with open(f'{token}.pkl', 'wb') as w:
            pickle.dump(usertree,w)

        return 

#Previous Episode              
def nextepisode(content_type,token,profilename,id,eps_no):
    
    with open(f'{content_type}.pkl', 'rb') as f:
        Llist = pickle.load(f)

    obj = Llist[id]
    info = obj.nextep(token,profilename,id,eps_no)
    return info[0]

#Next Episode
def prevepisode(content_type,token,profilename,id,eps_no):
    
    with open(f'{content_type}.pkl', 'rb') as f:
        Llist = pickle.load(f)

    obj = Llist[id]
    info = obj.prevep(token,profilename,id,eps_no)
    return info
    


# For making linked list or overwriting it

def create_linkedlist(content_type,table):

    dict = {}
    for content in table.all():
        content_list = LinkedList()
        for eps in content["episodes"]:
            content_list.insert(eps)
        dict[content["id"]] = content_list

    if content_type == "anime":
        with open('anime.pkl', 'wb') as f:
            pickle.dump(dict, f)

    else:
        with open('tvshow.pkl', 'wb') as f:
            pickle.dump(dict, f)

# if __name__=="__main__":
#     list = LinkedList()
    