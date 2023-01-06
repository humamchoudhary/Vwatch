from collections import deque

class Watch_history:
    def __init__(self):
        self.history = deque()

    def Add_history(self, video):
        self.history.append(video)
        # play the video


    def get_all(self):
        
        listhistory=list(self.history)
        listhistory.reverse()
        return listhistory
        


