import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'dart:convert';

import 'package:vwatch/main.dart';

import '../Components/color.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List movie_data = [];
  _getData() async {
    print("$URL/getMovies");
    final repsonse = await http.get(Uri.parse("$URL/getMovies"));
    final decode = json.decode(repsonse.body);
    print(decode);
    setState(() {
      movie_data = decode["result"];
    });
  }

  @override
  void initState() {
    _getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(".");
    return movie_data.isEmpty
        ? ModalProgressHUD(
            inAsyncCall: true,
            child: Container(),
          )
        : Scaffold(
            backgroundColor: BackgroundColor,
            appBar: AppBar(
              backgroundColor: BackgroundColor,
              title: Text(
                "Movies",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: HexColor("#AAB1C2"),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            body: GridView.count(
              mainAxisSpacing: 0,
              crossAxisCount: 2,
              children: List.generate(movie_data.length, (index) {
                var movie = movie_data[index];
                return Column(
                  children: [
                    Card(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        movie["coverImg"],
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      movie["title"],
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: HexColor("#AAB1C2"),
                            fontSize: 12,

                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                );
              }),
            ),
          );
  }
}
