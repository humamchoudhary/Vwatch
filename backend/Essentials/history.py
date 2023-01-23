from collections import deque
import pickle
class Watch_history:
    def __init__(self):
        self.history = deque()

    def push(self, video):
        if video !=  self.history[0]:
            self.history.append(video)
    


    def get_all(self):
    
        listhistory=list(self.history)
        listhistory.reverse()
        return listhistory

    def reset(self):
        self.history = deque()

        

# if __name__ == "__main__":
    # hist = Watch_history()
    # hist.push("1")
    # hist.push("2")
    # print(hist.get_all())
    
