import 'package:flutter/material.dart';
import 'package:vwatch/page/home.dart';
import 'package:vwatch/page/movie.dart';

class NavigationPage extends StatefulWidget {
  final String username;
  final String img;
  final List history;
  final List watchQueue;

  const NavigationPage(
      {super.key,
      required this.username,
      required this.history,
      required this.watchQueue,
      required this.img});

  @override
  State<NavigationPage> createState() => NavigationPageState();
}

class NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          HomePage(
            username: widget.username,
            history: widget.history,
            watchQueue: widget.watchQueue,
            img: widget.img,
          ),
          MoviePage()
        ],
      ),
    );
  }
}
