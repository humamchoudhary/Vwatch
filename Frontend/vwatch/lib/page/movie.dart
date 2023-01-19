// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:vwatch/Components/gen_checkbok.dart';
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
  List genres = ['Action', 'Sci-Fi', 'Animation', 'Comedy', 'Crime', 'Fantasy', 'Drama', 'Mystery', 'Adventure'];
  List selectedgen = [];
  _getData() async {
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
    final screensize = MediaQuery.of(context).size;

    return movie_data.isEmpty
        ? ModalProgressHUD(
            inAsyncCall: true,
            child: Container(),
          )
        : Scaffold(
            backgroundColor: BackgroundColor,
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      print('object');

                      showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          color: BackgroundColor,
                          height: screensize.height / 2 - 50,
                          child: ListView.separated(
                              itemBuilder: genBuilder,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider(
                                  height: 2,
                                );
                              },
                              itemCount: genres.length),
                        ),
                      ).then((value) async {
                        final repsonse = await http.post(Uri.parse("$URL/get_gen_movie"),
                                body: json.encode({
                                  "gen":selectedgen
                                }));
                            final decode = json.decode(repsonse.body);
                            setState(() {
                          movie_data = [];
                        });
                        decode.forEach((val) async {
                          var data =
                              await http.post(Uri.parse("$URL/search?id=$val"));
                          setState(() {
                            try {
                              movie_data.add(json.decode(data.body)[0]);
                            } catch (e) {
                              print(e);
                            }
                            print(movie_data);
                          });
                        });
                            
                      });
                      // CupertinoScaffold.showCupertinoModalBottomSheet(
                      //     expand: true,
                      //     context: context,
                      //     backgroundColor: Colors.transparent,
                      //     builder: (context) => Stack(children: <Widget>[
                      //           ModalWithScroll(),
                      //           Positioned(
                      //             height: 40,
                      //             left: 40,
                      //             right: 40,
                      //             bottom: 20,
                      //             child: MaterialButton(
                      //               onPressed: () => Navigator.of(context)
                      //                   .popUntil((route) =>
                      //                       route.settings.name == '/'),
                      //               child: Text('Pop back home'),
                      //             ),
                      //           )
                      //         ]));
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: WhiteColor,
                    ))
              ],
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
            body: movie_data.isNotEmpty? GridView.count(
              shrinkWrap: true,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              padding: const EdgeInsets.all(20),
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
                                          content_type : "movie",
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
                          frameBuilder: (context, child, frame,
                                wasSynchronouslyLoaded) {
                              return child;
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          // height: 220,
                          // width: 220 * 0.625,
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ):Container(),
          
           );
  
  }
  
  Widget genBuilder(BuildContext context, int index,) {
    print('object');
    return CheckBox(index: index,list:selectedgen);
  }
}
