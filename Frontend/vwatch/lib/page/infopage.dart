import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vwatch/Components/color.dart';
import 'package:vwatch/main.dart';
import 'package:vwatch/page/video.dart';
import 'package:http/http.dart' as http;

class InfoPage extends StatefulWidget {
  final String? content_type;
  final String name;
  final String desc;
  final String id;
  final List eps;
  final String trailer;
  final List genres;
  final String cover;
  final double rating;
  const InfoPage(
      {super.key,
      this.content_type,
      required this.name,
      required this.id,
      required this.eps,
      required this.trailer,
      required this.genres,
      required this.cover,
      required this.rating,
      required this.desc});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  List completed_list=[];
  late String url;
  bool player = false;
  int curr_eps = 1;
  _getData() async {
    final repsonse = await http.get(Uri.parse("$URL/completed_eps?content_type=${widget.content_type}&token=${USER.token}&profile=${PROFILE.username}&id=${widget.id}"));
    final decode = json.decode(repsonse.body);
    setState(() {
      completed_list = decode["result"];
    });
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: AppBar(
        elevation: 0,
        // leading: Container(),
        backgroundColor: BackgroundColor,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await http.get(Uri.parse(
                    "$URL/add_watchlist?token=${USER.token}&id=${widget.id}&profile=${PROFILE.username}"));
              },
              icon: const Icon(Icons.favorite))
        ],
        title: Text(
          widget.name,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: WhiteColor, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            !player
                ? Container(
                    color: AccentColor,
                    width: screensize.width,
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Card(
                            color: AccentColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            clipBehavior: Clip.antiAlias,
                            child: SizedBox(
                              child: Image.network(
                                widget.cover,
                                fit: BoxFit.contain,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              width: screensize.width / 2,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.name,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: WhiteColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        widget.desc,
                                        softWrap: true,
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            color: WhiteColor,
                                            fontSize: 10,
                                          ),
                                        ),
                                        maxLines: 10,
                                      ),
                                    ),
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : VideoPlayer(
                    content_type: widget.content_type,
                    url: url,
                    id: widget.id,
                  ),
            const SizedBox(
              width: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      player = false;
                      curr_eps -= 1;
                      if (curr_eps == 0) {
                        curr_eps = 1;
                      }
                    });

                    final repsonse = await http.get(Uri.parse(
                        "$URL/preveps?content_type=${widget.content_type}&token=${USER.token}&profile=${PROFILE.username}&epsno=$curr_eps&id=${widget.id}"));
                    final decode = json.decode(repsonse.body)["result"];

                    setState(() {
                      url = decode["url"];
                      player = true;

                      // flickManager.dispose();
                      // _videoplayercontoller.dispose();
                      // _videoplayercontoller.value;
                    });
                  },
                  child: Text(
                    "Prev",
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: WhiteColor,
                        fontSize: 10,
                      ),
                    ),
                    maxLines: 10,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      player = false;
                      curr_eps += 1;
                    });
                    print(
                        "$URL/nexteps?content_type=${widget.content_type}&token=${USER.token}&profile=${PROFILE.username}&epsno=${curr_eps}&id=${widget.id}");
                    final repsonse = await http.get(Uri.parse(
                        "$URL/nexteps?content_type=${widget.content_type}&token=${USER.token}&profile=${PROFILE.username}&epsno=${curr_eps}&id=${widget.id}"));
                    final decode = json.decode(repsonse.body)["result"];

                    setState(() {
                      url = decode["url"];
                      player = true;

                      // flickManager.dispose();
                      // _videoplayercontoller.dispose();
                      // _videoplayercontoller.value;
                    });
                  },
                  child: Text(
                    "Next",
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: WhiteColor,
                        fontSize: 10,
                      ),
                    ),
                    maxLines: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Container(
                  height: screensize.height - 250,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: itemBuilder,
                    itemCount: widget.eps.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 2,
                      );
                    },
                  )),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return ListTile(
      tileColor: AccentColor,
      title: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Text(
          widget.eps.length == 1 ? widget.name : "Episode ${index + 1}",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: WhiteColor, fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.play_circle_outline_rounded),
        onPressed: () async {
          final repsonse = await http.get(Uri.parse(
              "$URL/getlink?epsid=${widget.eps[index]['id']}&id=${widget.id}&profile=${PROFILE.username}&token=${USER.token}"));
          final decode = json.decode(repsonse.body);
          setState(() {
            url = decode["url"];
            player = true;
          });
        },
        color: CTAColor,
      ),
    );
  }
}
