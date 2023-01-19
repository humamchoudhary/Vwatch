from tinydb import TinyDB, Query
from Exceptions import *
import hashlib
from Essentials.UserTree import *
from Essentials.Account import *



class Signup:
    DB = TinyDB("./database.json")
    User = Query()
    table = DB.table("User_Data")
    

    def __init__(self, name, email, username, password):
        self.name = name
        self.email = email.lower()
        self.username = username
        self.password = password
        self.tree = self.Register()
        
        

    def Register(self):
        self.email = self.email.lower()
        # Check if the given email is correct
        if '@' not in self.email and '.' not in self.email:
            raise InvalidEmailError("Invalid Email!")

        # Check if the given password is correct
        if len(self.password) < 5:
            raise InvalidPasswordError("Password too short")

        # hash the password
        self.password = self.password.encode()
        hash = hashlib.sha256(self.password)
        self.hashpass = hash.hexdigest()
        account = Account(self.name, self.email, self.username, self.hashpass)

        if self.table.search(self.User.username == self.username):
            raise AccountExistsError("This Account already Exits")
        else:
            self.table.insert(
                {"username": self.username, "token": f"{account}"})
            return UserTree(account,self.username)

    def Print_Account_Details(self):
        print(self.table.all())



if __name__ == "__main__":
    signup = Signup("humam", "humam@gmail.com", "humam2", "12345678")
    signup.tree.save_user()

