from tinydb import TinyDB, Query
import hashlib
import pickle
from Exceptions import *
# from signup import *
from Essentials.UserTree import *


class Login:
    DB = TinyDB("database.json")
    User = Query()
    table = DB.table("User_Data")

    def __init__(self, username, password):
        self.username = username
        self.password = password
        self.account = self.CheckPassword()

    def CheckPassword(self):
        data = self.table.search(self.User.username == self.username).pop()
        try:
            token = data["token"]
            # Compositon
            file = open(f'{token}.pkl', 'rb')
            usertree = pickle.load(file)
            file.close()

        except FileNotFoundError:
            raise AccountNotFoundError("User does not exists!")
        except IndexError:
            raise AccountNotFoundError("User does not exists!")

        account = usertree.account
        plaintext = self.password.encode()
        hash = hashlib.sha256(plaintext)
        hashhex = hash.hexdigest()
        if account.password == hashhex:
            return account

        else:
            raise InvalidPasswordError("Invalid password!")

    def Get_Account(self):
        return self.account

    def test(self):
        return self.table.all()


if __name__ == "__main__":
    # for user in Login("123", "312").test():
    #     token = user["token"]
    #     file = open(f'{token}.pkl', 'rb')
    #     Usertree = pickle.load(file)
    #     data = Usertree.get_all_profiles()
    #     for i in data:
    #         print(i.username)
    account = Login("humam02","12345678")
    print(account.username)


