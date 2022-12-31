import 'package:flutter/material.dart';
import 'package:vwatch/Components/color.dart';
import 'package:vwatch/page/Login_form.dart';
import 'package:vwatch/page/SignUp.dart';
import 'package:vwatch/page/home.dart';
const URL = "http://192.168.8.128:5000";
void main() {
  runApp(const MainApp());
}
Color BackgroundColor= HexColor("#020A27");
Color AccentColor = HexColor("#12244A");
Color CTAColor = HexColor("#49D0EE");
Color WhiteColor = HexColor("#FEFDFF");

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          "/signup":(context) => SignUp(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
        ),
        home:  Scaffold(
          body: Login(),
        ));
  }
}
