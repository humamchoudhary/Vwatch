from collections import deque

class queue:
    def __init__(self):
        self.l = deque([])

    def enqueue (self, item):
        if item not in self.l:
            self.l.append(item)

    def dequeue (self):
        print("Removed from queue")
        return self.l.pop(0)
    
    def delete(self,index):
        self.l.remove(index)
        print(self.l)
    
    def clean(self):
        self.l = deque([])
        # print(self.l)
    
# if __name__ == "__main__":   
#     dict1 = {
#         "title": "naruto",
#         "animeID":"naruto",
#         "rating": 8.5,
#         "desc": "hello",
#         "genres": [],
#         "coverImg":"www.xyz.com/abc.png",
#         "totalEps":220,
#         "eps":[
#                 {
#                 "epsName": "Eps 1",
#                 "epsid":"eps1",
#                 "url": "www.streaming-url.com/abc.mp4",
#                 "epsNumber": 1
#                 }
#         ]
#         },
            
#     dict2 = {
#         "title": "idfk",
#         "animeID":"idfk",
#         "rating": 8.5,
#         "desc": "hello",
#         "genres": [],
#         "coverImg":"www.xyz.com/abc.png",
#         "totalEps":220,
#         "eps":[
#                 {
#                 "epsName": "Eps 1",
#                 "epsid":"eps1",
#                 "url": "www.streaming-url.com/abc.mp4",
#                 "epsNumber": 1
#                 }
#         ]
#         },
#     dictlist = queue()
#     dictlist.enqueue(dict1)
#     dictlist.enqueue(dict2)
#     dictlist.delete(dict1)
#     print(dictlist.l)



