import 'dart:convert';

import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vwatch/Components/color.dart';
import 'package:vwatch/main.dart';
import 'package:http/http.dart' as http;
import 'package:vwatch/page/infopage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchText = "";
  List tiles = [];
  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        backgroundColor: BackgroundColor,
        elevation: 0,
        title: Text(
          "Search",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: HexColor("#AAB1C2"),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: screensize.height,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AccentColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: AnimatedSearchBar(
                      label:
                          "Search name of movie or tv show                              ",
                      duration: const Duration(microseconds: 0),
                      onChanged: (_) {
                        search(_);
                      },
                      searchStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: HexColor("#AAB1C2"),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      labelStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: HexColor("#AAB1C2"),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      searchDecoration: InputDecoration(
                          labelText: "Search",
                          labelStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: HexColor("#AAB1C2"),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          alignLabelWithHint: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AccentColor2, width: 2),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              gapPadding: 4),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AccentColor2, width: 2),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              gapPadding: 4),
                          fillColor: AccentColor,
                          focusColor: AccentColor2),
                      searchIcon: Icon(
                        Icons.search,
                        color: AccentColor2,
                      ),
                      closeIcon: Icon(
                        Icons.close,
                        color: AccentColor2,
                      ),
                    ),
                  ),
                ),
                tiles.length == 0
                    ? Expanded(
                      child: Center(
                        child: Text(
                          "No data found",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: HexColor("#AAB1C2"),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    )
                    : Expanded(
                      child: GridView.count(
                        shrinkWrap: true,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        padding: const EdgeInsets.all(20),
                        crossAxisCount: 2,
                        childAspectRatio: 0.60,
                        children: List.generate(tiles.length, (index) {
                          var movie = tiles[index];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                constraints: const BoxConstraints(
                                    minHeight: 270,
                                    minWidth: 270 * 0.625,
                                    maxHeight: 280,
                                    maxWidth: 280 * 0.625),
                                child: Card(
                                  color: AccentColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  clipBehavior: Clip.antiAlias,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => InfoPage(
                                                    name: movie["title"],
                                                    id: movie["id"],
                                                    eps: movie["episodes"],
                                                    trailer: "hello",
                                                    genres: movie["genres"],
                                                    cover: movie["coverImg"],
                                                    rating: movie["rating"],
                                                    desc: movie["desc"],
                                                  )));
                                    },
                                    child: Image.network(
                                      movie["coverImg"],
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high,
                                      // height: 280,
                                      // width: 280 * 0.625,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> search(value) async {
    try {
      final repsonse = await http.post(
        Uri.parse("$URL/search?name=$value"),
      );
      final decode = json.decode(repsonse.body);
      if (decode.length > 0) {
        setState(() {
          tiles = decode;
        });
      } else {
        setState(() {
          tiles = [];
        });
      }
    } catch (e) {
      setState(() {
          tiles = [];
        });
    }
  }
}
