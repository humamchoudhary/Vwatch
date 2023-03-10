from Essentials.history import Watch_history
from Exceptions import *
from collections import defaultdict
from Essentials.Queue import queue
import random
import pickle
imgs = ['randimage0.png', 'randimage1.png', 'randimage2.png', 'randimage3.png', 'randimage4.png', 'randimage5.png',
        'randimage6.png', 'randimage7.png', 'randimage8.png', 'randimage9.png', 'randimage10.png', 'randimage11.png']


class UserProfile:
    def __init__(self, username):
        self.username = username
        self.watch_history = Watch_history()
        self.watched = defaultdict(list)
        self.watch_list = queue()
        
    def add_to_watch_history(self, content_id):
        self.watch_history.push(content_id)

    def get_Img(self):
        self.img = random.choice(imgs)

    def __str__(self):
        return f"{self.username}"


class UserNode:
    def __init__(self, data):
        self.data = data
        self.children = []


class UserTree:
    def __init__(self, account, username):
        self.root = UserNode(UserProfile(username))
        self.root.data.get_Img()
        self.account = account

    def create_Profile(self, username):
        """
            creates a new profile 
        """
        print(len(self.root.children) < 3)
        if len(self.root.children) < 3:
            new_user_profile = UserProfile(username)
            new_user_profile.get_Img()
            user_node = UserNode(new_user_profile)
            self.root.children.append(user_node)
        else:
            raise MaxProfilesError(
                "You have reached maximum number of profiles!")

    def load_profile(self, username):
        """
            Searches for user profile and returns it
        """
        if self.root.data.username == username:
            return self.root.data
        else:
            for profile in self.root.children:
                if profile.data.username == username:
                    return profile.data

    def get_all_profiles(self):
        profiles = []
        profiles.append({
            "username": self.root.data.username,
            "history": self.root.data.watch_history.get_all(),
            "watchlist": list(self.root.data.watch_list.l),
            "img": self.root.data.img
        })
        for profile in self.root.children:
            print(profile.data.username)
            profiles.append({
                "username": profile.data.username,
                "history": profile.data.watch_history.get_all(),
                "watchlist": list(profile.data.watch_list.l),
                "img": profile.data.img
            })
        return profiles

    def delete_profile(self, username):
        if self.root.data.username == username:
            self.root.data = self.children.pop(0)
        else:
            for index, profile in enumerate(self.root.children):
                if profile.data.username == username:
                    self.root.children.pop(index)
                    del profile

    def save_user(self):
        
        with open(f'{self.account}.pkl', 'wb') as enc_file:
            pickle.dump(self, enc_file, None)


#---Func for creating list for watched eps
def create_watched(data,token,profilename,id):
        
    with open(f'{token}.pkl', 'rb') as f:
        usertree = pickle.load(f)

    userprofile = usertree.load_profile(profilename)
    
    if id in userprofile.watched:
        return
    print(id)
    for show in data:
        print(show["id"])
        if show["id"] == id:
            try:
                totaleps = len(show["episodes"])
            except:
                totaleps = 1

    [userprofile.watched[id].append(False) for x in range(totaleps)]            
    
    with open(f'{token}.pkl', 'wb') as w:
        pickle.dump(usertree,w)

    return    


#Function for calling a list where the episodes that user already watched is stored
def completed_eps(data,token,profilename,id):
    with open(f'{token}.pkl', 'rb') as f:
        usertree = pickle.load(f)

    userprofile = usertree.load_profile(profilename)

    if id not in userprofile.watched:
        return

    return userprofile.watched[id]

