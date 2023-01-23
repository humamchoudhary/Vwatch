// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:vwatch/Components/gen_checkbok.dart';
import 'dart:convert';
import 'package:vwatch/main.dart';
import 'package:vwatch/page/infopage.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../Components/color.dart';

class ShowPage extends StatefulWidget {
  const ShowPage({super.key});

  @override
  State<ShowPage> createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  List genres = [
    'Action',
    'Sci-Fi',
    'Animation',
    'Comedy',
    'Crime',
    'Fantasy',
    'Drama',
    'Mystery',
    'Adventure'
  ];
  List selectedgen = [];
  List show_data = [];
  _getData() async {
    final repsonse = await http.get(Uri.parse("$URL/getAllShow"));
    final decode = json.decode(repsonse.body);
    setState(() {
      show_data = decode["result"];
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

    return show_data.isEmpty
        ? ModalProgressHUD(
            inAsyncCall: true,
            child: Container(
              color: BackgroundColor,
            ),
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
                        final repsonse = await http.post(
                            Uri.parse("$URL/get_gen_show"),
                            body: json.encode({"gen": selectedgen}));
                        final decode = json.decode(repsonse.body);
                        setState(() {
                          show_data = [];
                        });
                        decode.forEach((val) async {
                          var data =
                              await http.post(Uri.parse("$URL/search?id=$val"));
                          setState(() {
                            try {
                              show_data.add(json.decode(data.body)[0]);
                            } catch (e) {
                              print(e);
                            }
                            print(show_data);
                          });
                        });
                      });
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: WhiteColor,
                    ))
              ],
              leading: Container(),
              backgroundColor: BackgroundColor,
              title: Text(
                "Tv Shows",
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
              padding: const EdgeInsets.all(20),
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              children: List.generate(show_data.length, (index) {
                var movie = show_data[index];
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
                                          content_type: "tvshow",
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
                            height: 280,
                            width: 280 * 0.625,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
  }

  Widget genBuilder(
    BuildContext context,
    int index,
  ) {
    print('object');
    return CheckBox(index: index, list: selectedgen);
  }
}
