import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vwatch/Components/color.dart';
import 'package:vwatch/Components/histroy.dart';
import 'package:vwatch/Components/ratings.dart';
import 'package:vwatch/main.dart';
import 'package:animated_search_bar/animated_search_bar.dart';

class HomePage extends StatefulWidget {
  final String username;
  final String img;
  final List history;
  final List watchQueue;

  const HomePage(
      {super.key,
      required this.username,
      required this.history,
      required this.watchQueue,
      required this.img});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: BackgroundColor,
      // ignore: prefer_const_literals_to_create_immutables
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Card(
                clipBehavior: Clip.antiAlias,
                elevation: 0,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: CircleAvatar(
                        backgroundImage:
                            NetworkImage("$URL/getimages?img=${widget.img}")),
                  ),
                  title: Text(
                    "Hello, ${widget.username}",
                    style: GoogleFonts.poppins(
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  subtitle: Text(
                    "Enjoy your stay at VWatch",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: HexColor("#AAB1C2"),
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 45),
              SizedBox(height: 140, child: const Rating()),

              SizedBox(height: 45),
              SizedBox(height: 140, child: const Rating()),

              SizedBox(height: 45),
              SizedBox(height: 140, child: const Rating()),
              // Center(
              //   child: ElevatedButton(
              //       onPressed: () {
              //         Navigator.pushReplacement(context,
              //             MaterialPageRoute(builder: (context) => Mytest()));
              //       },
              //       child: const Text("player")),
              // ),

              const SizedBox(
                height: 400,
              ),

              const History(),
            ]),
          ),
        ),
      ),
    );
  }
}
