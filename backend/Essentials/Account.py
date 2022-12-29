import uuid

class Account():
    def __init__(self, name, email, username, password):
        self.name = name
        self.email = email
        self.username = username
        self.password = password
        self.__token = None
        self.GenToken()

    def GenToken(self):
        uuid_str = uuid.uuid1().urn
        self.__token = uuid_str[9:]
        return self.__token

    def __str__(self):
        return str(self.__token)
