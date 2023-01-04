import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vwatch/Components/color.dart';
import 'package:vwatch/main.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    super.initState();
  }

  List history = [
    {
      "id": "movie/watch-avengers-age-of-ultron-19729",
      "title": "Avengers: Age of Ultron",
      "coverImg":
          "https://img.flixhq.to/xxrz/250x400/379/76/e8/76e8bc195d6dff37d1fbbf815ce467e9/76e8bc195d6dff37d1fbbf815ce467e9.jpg",
      "genres": ["Action", "Adventure", "Science Fiction"],
    }
  ];
  @override
  Widget build(BuildContext context) {
    return history.isNotEmpty
        ? ListView.builder(
            itemBuilder: historyBuilder,
            // separatorBuilder: historyseparatorBuilder,
            itemCount: history.length)
        : Container();
  }

  Widget historyBuilder(BuildContext context, int index) {
    return ListTile(
      shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
      tileColor: AccentColor,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
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
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: HexColor("#AAB1C2"),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(children: [
                  for (var i in history[index]["genres"])
                    Text(
                      " $i |",
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
          ],
        ),
      ),
    );
  }

  Widget historyseparatorBuilder(BuildContext context, int index) {
    return SizedBox();
  }
}
