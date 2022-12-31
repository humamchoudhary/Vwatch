from flask import Flask,jsonify,make_response,request,send_file
import json
from login import Login
from Essentials.UserTree import *
from Essentials.Account import *
from signup import Signup

response = ''
app = Flask(__name__)


@app.route('/login', methods = ['POST'])
def LoginRoute():

    #fetching the global response variable to manipulate inside the function
    global response
    

    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))


        # request_data = request.args
        
        username = request_data['username']
        password = request_data['password']
        
        try:
            account = Login(username,password)
            account= account.account         
            response = jsonify({"error":"Logged in","account":{"username":account.account.username,"profiles":account.get_all_profiles()}})
            return make_response(response,200)
        except Exception as e:
            
            response = jsonify({"error":str(e),"account":'None'})
            return make_response(response,400)
    else:
        return response


   
@app.route('/signup',methods = ['POST'])
def SignUpRoute():
    global response

    if(request.method == 'POST'):
        # request_data = request.args
        
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))

        username = request_data["username"]
        password = request_data["password"]
        email = request_data["email"]       
        name = request_data["name"]
        try:
            signup = Signup(name,email,username,password)
            response = jsonify({"error":"None"})
            signup.Print_Account_Details()
            return make_response(response,200)
        except Exception as e:
            response = jsonify({"error":str(e)})
            return make_response(response,400)
    else:

        return response

@app.route('/getimages')
def get_image():
    img = request.args.get('img')
    filename = f"images/{img}"
    return send_file(filename, mimetype='image/gif')


if __name__ == "__main__":
    app.run(debug=True,host="0.0.0.0")