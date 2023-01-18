import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vwatch/Components/color.dart';
import 'package:vwatch/main.dart';
import 'package:http/http.dart' as http;
import 'package:vwatch/page/test.dart';

class History extends StatefulWidget {
  final List history;
  const History({super.key, required this.history});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    history = widget.history;
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
    return ListTile(
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
                  Row(children: [
                    for (var i in history[index]["genres"])
                      Text(
                        " $i ",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: HexColor("#AAB1C2"),
                              fontSize: 10,
                              fontWeight: FontWeight.w300),
                        ),
                      )
                  ]),
                ],
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: Icon(Icons.play_arrow_rounded, color: CTAColor),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Mytest(url: history[index]["url"])));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
