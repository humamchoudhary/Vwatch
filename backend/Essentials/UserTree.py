from Exceptions import *
import pickle
class UserProfile:
    def __init__(self, username):
        self.username = username
        self.watch_history = [] # Replace with stack later

    def add_to_watch_history(self, content_id):
        self.watch_history.append(content_id)


class UserNode:
    def __init__(self, data):
        self.data = data
        self.children = []
    

class UserTree:
    def __init__(self, account):
        self.root = UserNode(UserProfile(account.username))
        self.account = account

    def create_Profile(self,username):
        """
            creates a new profile 
        """
        if len(self.root.children) > 3:
            new_user_profile = UserProfile(username)
            user_node = UserNode(new_user_profile)
            self.root.children.append(user_node)
        else:
            raise MaxProfilesError("You have reached maximum number of profiles!")
    
    def load_profile(self,username):
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
        profiles.append(self.root.data)
        for profile in self.root.children:
            profiles.append(profile.data)
        print(profiles)
        return profiles
    
    def delete_profile(self,username):
        if self.root.data.username == username:
            self.root.data = self.children.pop(0) 
        else:
            for index,profile in enumerate(self.root.children):
                if profile.data.username == username:
                    self.root.children.pop(index)
                    del profile
    
    def save_user(self):
        print(f'{self.account}.pkl')
        with open(f'{self.account}.pkl', 'wb') as enc_file:
            pickle.dump(self, enc_file, None)
