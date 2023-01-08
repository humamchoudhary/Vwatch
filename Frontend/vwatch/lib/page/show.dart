import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'dart:convert';

import 'package:vwatch/main.dart';

import '../Components/color.dart';

class ShowPage extends StatefulWidget {
  const ShowPage({super.key});

  @override
  State<ShowPage> createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  List movie_data = [];
  _getData() async {
    print("$URL/getAllShow");
    final repsonse = await http.get(Uri.parse("$URL/getAllShow"));
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
              padding: const EdgeInsets.all(20),
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              children: List.generate(movie_data.length, (index) {
                var movie = movie_data[index];
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
                        child: Image.network(
                          movie["coverImg"],
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          height: 280,
                          width: 280 * 0.625,
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
