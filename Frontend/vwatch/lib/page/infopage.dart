import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vwatch/Components/color.dart';
import 'package:vwatch/main.dart';
import 'package:vwatch/page/video.dart';

class InfoPage extends StatefulWidget {
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
            Container(
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
            SizedBox(
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
          widget.eps.length == 1 ? widget.name : "Episode $index",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: WhiteColor, fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.play_circle_outline_rounded),
        onPressed: () {
          print(widget.eps[index]["url"]);
          VideoPlayer(
            url: widget.eps[index]["url"],
          );
        },
        color: CTAColor,
      ),
    );
  }
}
