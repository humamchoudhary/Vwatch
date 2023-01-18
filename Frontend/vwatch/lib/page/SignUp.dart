import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vwatch/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpScreenstate();
  }
}

class SignUpScreenstate extends State<SignUp> {
  String? _username = "";
  String? _name = "";
  String? _password = "";
  String? _email = "";
  String _error = "";
  String? _passwordconf = "";
  double _finalwidth = 0;
  bool Loading = false;

  Color _error_color = Colors.red;

  final TextEditingController _notify = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget _buildUserNameField() {
    return TextFormField(
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(color: Colors.white),
      ),
      
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: WhiteColor)),
        labelText: "Username",
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(color: Colors.white),
        ),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Username is required';
        }
      },
      onSaved: (String? value) {
        _username = value;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(color: Colors.white),
      ),
      
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: WhiteColor)),
        labelText: "Email",
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(color: Colors.white),
        ),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Email is required';
        }
      },
      onSaved: (String? value) {
        _email = value;
      },
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(color: Colors.white),
      ),
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: WhiteColor)),
        labelText: "Name",
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(color: Colors.white),
        ),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Name is required';
        }
      },
      onSaved: (String? value) {
        _name = value;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(color: Colors.white),
      ),
      controller: _pass,
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: WhiteColor)),
        labelText: "Password",
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(color: Colors.white),
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Password is required';
        }
        if (value != _confirmPass.text) {
          return 'Password does not match';
        }
        if (value.length < 6) {
          return 'Password too short';
        }
      },
      onSaved: (String? value) {
        _password = value;
      },
    );
  }

  Widget _buildPasswordConfField() {
    return TextFormField(
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(color: Colors.white),
      ),
      controller: _confirmPass,
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: WhiteColor)),
        labelText: "Confrm Password",
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(color: Colors.white),
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Password Confirmation is required';
        }
        if (value != _pass.text) {
          return 'Password does not match';
        }
        if (value.length < 6) {
          return 'Password too short';
        }
      },
      onSaved: (String? value) {
        _passwordconf = value;
      },
    );
  }

  Future<void> _save() async {
    _formkey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 450) {
      setState(() {
        _finalwidth = screenWidth - 50;
      });
    } else {
      setState(() {
        _finalwidth = 430;
      });
    }
    ;
    return ModalProgressHUD(
        inAsyncCall: Loading,
        child: Scaffold(
            backgroundColor: BackgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text("VWatch"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10,bottom: 50),
                  child: Form(
                    key: _formkey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(_error,
                              style: TextStyle(color: _error_color)),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: _finalwidth,
                                  child: _buildNameField())
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: _finalwidth,
                                  child: _buildEmailField())
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: _finalwidth,
                                  child: _buildUserNameField())
                            ],
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: (_finalwidth / 2) - 15,
                                child: _buildPasswordField(),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              SizedBox(
                                width: (_finalwidth / 2) - 15,
                                child: _buildPasswordConfField(),
                              ),
                            ],
                          ),

                          // SizedBox(height: 10),

                          const SizedBox(
                            height: 100,
                          ),
                          ElevatedButton(
                            style:
                    ElevatedButton.styleFrom(backgroundColor: CTAColor),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 12),
                              child: Text('SignUp'),
                            ),
                            onPressed: () async {
                              setState(() {
                                Loading = true;
                              });
                              if (_formkey.currentState!.validate()) {
                                _save();
                                
                                final url = Uri.parse("$URL/signup");
                                final response = await http.post(url,
                                    body: json.encode({
                                      "username": _username,
                                      "password": _password,
                                      "name": _name,
                                      "email": _email,
                                    }));
                                // final repsonse = await http.get(url);
                                final decode = json.decode(response.body)
                                    as Map<String, dynamic>;
                                if (decode['error'] != 'None') {
                                  setState(() {
                                    _error = decode['error'];
                                    _error_color = Colors.red;
                                  });
                                }
                                if (decode["error"] == "None") {
                                  setState(() {
                                    _error = "Signed in";
                                    _error_color = Colors.green;
                                    Navigator.pop(context, '/signup');
                                  });
                                }
                              } else {}
                              setState(() {
                                Loading = false;
                              });
                            },
                          ),
                        ]),
                  )),
            )));
  }
}
