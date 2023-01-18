import 'package:google_fonts/google_fonts.dart';
import 'package:vwatch/Components/user.dart';
import 'package:vwatch/main.dart';
import 'package:vwatch/page/home.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vwatch/page/home.dart';
import 'package:vwatch/page/profiles.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenstate();
  }
}

class LoginScreenstate extends State<Login> {
  String? _username = "";
  String? _password = "";
  String _error = "";
  bool LoadingData = false;

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

  Widget _buildPasswordField() {
    return TextFormField(
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(color: Colors.white),
      ),
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
      },
      onSaved: (String? value) {
        _password = value;
      },
    );
  }

  Future<void> _save() async {
    _formkey.currentState!.save();
  }

  double _finalwidth = 0;

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;

    if (screensize.width <= 450) {
      setState(() {
        _finalwidth = screensize.width - 50;
      });
    } else {
      setState(() {
        _finalwidth = 430;
      });
    }
    ;

    return Scaffold(
        backgroundColor: BackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("VWatch"),
          centerTitle: true,
        ),
        body: ModalProgressHUD(
          inAsyncCall: LoadingData,
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.only(
                left: 10, right: 10, top: (screensize.height / 2) - 250),
            child: Form(
              key: _formkey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(_error, style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: _finalwidth,
                          child: _buildUserNameField(),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: _finalwidth,
                          child: _buildPasswordField(),
                        )
                      ],
                    ),

                    // _buildPasswordField(),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: CTAColor),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 12),
                        child: Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          LoadingData = true;
                        });
                        if (_formkey.currentState!.validate()) {
                          _save();
                          print('$URL/login');

                          final url = Uri.parse("$URL/login");
                          try {
                            final repsonse = await http.post(url,
                                body: json.encode({
                                  "username": _username,
                                  "password": _password
                                }));
                            final decode = json.decode(repsonse.body)
                                as Map<String, dynamic>;
                                
                            final accountDetails = decode["account"];
                            final username = accountDetails["username"];
                            // print(username);
                            if (decode['error'] != 'Logged in') {
                              setState(() {
                                _error = decode['error'];
                              });
                            } else {
                              print(decode);

                              // ignore: use_build_context_synchronously
                              setState(() {
                                USER = User(profiles: accountDetails["profiles"] , username: username);
                              });
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilesPage(
                                          profiles:
                                              accountDetails["profiles"])));
                            }
                          } catch (e) {
                            setState(() {
                              _error =
                                  "Could not login please try again later!";
                              print("$e.runtimeType, $e");
                            });
                          }
                        }
                        setState(() {
                          LoadingData = false;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      child: Text(
                        "SignUp",
                        key: const ValueKey("signup"),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(color: CTAColor),
                        ),
                      ),
                      onPressed: () {
                        print(const ValueKey("signup"));
                        Navigator.pushNamed(context, '/signup');
                      },
                    )
                  ]),
            ),
          )),
        ));
  }
}
