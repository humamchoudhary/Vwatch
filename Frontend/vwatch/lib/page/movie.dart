import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'dart:convert';

import 'package:vwatch/main.dart';
import 'package:vwatch/page/infopage.dart';

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
    final repsonse = await http.get(Uri.parse("$URL/getAllMovies"));
    final decode = json.decode(repsonse.body);
    setState(() {
      movie_data = decode["result"];
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
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
              leading: Container(),
              backgroundColor: BackgroundColor,
              title: Text(
                "Movies",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: HexColor("#AAB1C2"),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            body: GridView.count(
              shrinkWrap: true,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              padding: EdgeInsets.all(20),
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              children: List.generate(movie_data.length, (index) {
                var movie = movie_data[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      color: AccentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                         InfoPage(
                                          name:movie["title"],
                                          id:movie["id"],
                                          eps:movie["episodes"],
                                          trailer:movie["url"],
                                          genres:movie["genres"],
                                          cover:movie["coverImg"],
                                          rating:movie["rating"],
                                          desc:movie["desc"],
                                         )
                                         ));
                        },
                        child: Image.network(
                          movie["coverImg"],
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          
                          // height: 220,
                          // width: 220 * 0.625,
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
  }
}
