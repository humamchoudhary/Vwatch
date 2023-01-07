import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vwatch/Components/color.dart';
import 'package:vwatch/main.dart';

class InfoPage extends StatefulWidget {
  final String name;
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
      required this.rating});

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
        leading: Container(),
        backgroundColor: BackgroundColor,
        centerTitle: true,
        title: Text(
          "${widget.name}",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: HexColor("#AAB1C2"),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.amber,
              width: screensize.width,
              height: 250,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                  color: AccentColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    height: 100,
                    width: 100 * 0.625,
                    child: Image.network(
                      widget.cover,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                      height: 250,
                      width: 250 * 0.625,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
