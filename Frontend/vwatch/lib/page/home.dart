import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vwatch/Components/color.dart';
import 'package:vwatch/Components/histroy.dart';
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
  String searchText = "";

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

              // const Rating(),
              // Center(
              //   child: ElevatedButton(
              //       onPressed: () {
              //         Navigator.pushReplacement(context,
              //             MaterialPageRoute(builder: (context) => Mytest()));
              //       },
              //       child: const Text("player")),
              // ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AccentColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: AnimatedSearchBar(
                    label:
                        "Search name of movie or tv show                        ",
                    duration: Duration(microseconds: 0),
                    labelStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: HexColor("#AAB1C2"),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    searchDecoration: InputDecoration(
                      labelText: "Search",
                      alignLabelWithHint: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          gapPadding: 4),
                      fillColor: AccentColor,
                    ),
                    searchIcon: Icon(
                      Icons.search,
                      color: AccentColor2,
                    ),
                    closeIcon: Icon(
                      Icons.close,
                      color: AccentColor2,
                    ),
                    onChanged: (value) {
                      print("value on Change");
                      setState(() {
                        searchText = value;
                      });
                    },
                  ),
                ),
              ),

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
