from flask import Flask,jsonify,make_response,request
import json
from login import Login
from Essentials.UserTree import *
from Essentials.Account import *


response = ''
app = Flask(__name__)


@app.route('/login', methods = ['GET', 'POST'])
def LoginRoute():

    #fetching the global response variable to manipulate inside the function
    global response
    

    if(request.method == 'POST'):
        # request_data = request.data
        # request_data = json.loads(request_data.decode('utf-8'))


        request_data = request.args
        
        username = request_data['username']
        password = request_data['password']
        
        try:
            account = Login(username,password)
            username = account.username
            
            response = jsonify({"error":"Logged in","account":{"username":username}})
            return make_response(response,200)
        except Exception as e:
            
            response = jsonify({"error":str(e),"account":'None'})
            return make_response(response,400)
    else:
        return response
   
# @app.route('/signup',methods = ['GET','POST'])
# def SignUpRoute():
#     global response

#     if(request.method == 'POST'):
#         request_data = request.data
#         request_data = json.loads(request_data.decode('utf-8'))
#         username = request_data["username"]
#         password = request_data["password"]
#         gender = request_data["gender"]
#         email = request_data["email"]       
#         name = request_data["name"]
#         address = request_data["address"]
#         ph = request_data["phone_num"]
#         try:
#             signup = Signup(name,address,gender,email,username,password,acc_type="Member",phone_num=ph)
#             response = jsonify({"error":"None"})
#             print(response.data)
#             signup.Print_Account_Details()
#             return make_response(response,200)
#         except Exception as e:
#             response = jsonify({"error":str(e)})
#             return make_response(response,400)
#     else:

#         return response


if __name__ == "__main__":
    app.run(debug=True,host="0.0.0.0")