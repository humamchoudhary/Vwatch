import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vwatch/Components/color.dart';
import 'package:vwatch/main.dart';
import 'package:http/http.dart' as http;
import 'package:vwatch/page/test.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    get_history();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  List history = [];
  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;

    return history.isNotEmpty
        ? SizedBox(
            width: screensize.width,
            height: screensize.height,
            child: ListView.separated(
              itemBuilder: historyBuilder,
              // separatorBuilder: historyseparatorBuilder,
              itemCount: history.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 20,
                );
              },
            ),
          )
        : Container();
  }

  Widget historyBuilder(BuildContext context, int index) {
    final screensize = MediaQuery.of(context).size;
    return ListTile(
      onTap:() {
        
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: AccentColor,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Image.network(
                  history[index]["coverImg"],
                  fit: BoxFit.cover,
                  height: 120,
                  width: 120 * 0.625,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    history[index]["title"],
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: HexColor("#AAB1C2"),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: screensize.width/2,
                    child: Flexible(
                      child: Text(
                        " ${history[index]["genres"].join(" | ")}",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: HexColor("#AAB1C2"),
                              fontSize: 10,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
            
          ],
        ),
      ),
      
    );
  }

  get_history() async {
    final repsonse = await http.get(Uri.parse(
        "$URL/get_history?token=${USER.token}&profile=${PROFILE.username}"));
    final decode = json.decode(repsonse.body);
    setState(() {
      history = decode["data"];
    });
  }
}
