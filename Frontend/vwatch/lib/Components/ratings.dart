// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:vwatch/main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Rating extends StatefulWidget {
  final String contenttype;
  const Rating({super.key, required this.contenttype});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  get_data() async {
    final repsonse =
        await http.get(Uri.parse("$URL/get_rating_${widget.contenttype}"));
    final decode = json.decode(repsonse.body);
    //
    decode.forEach((val) async {
      var data = await http.post(Uri.parse("$URL/search?id=$val"));
      setState(() {
        try {
          rating_data.add(json.decode(data.body)[0]);
        } catch (e) {
          print(e);
        }
      });
    });
  }

  List rating_data = [];
  @override
  void initState() {
    get_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return rating_data.isNotEmpty
        ? ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              var movie = rating_data[index];
              return Card(
                color: AccentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  child: Image.network(
                    movie != null || movie.isNotEmpty
                        ? movie["coverImg"]
                        : "$URL/getimages?img=index.png",
                    // "https://img.flixhq.to/xxrz/250x400/379/b0/e4/b0e4780f952163abbfec3b614fb25a6e/b0e4780f952163abbfec3b614fb25a6e.jpg",

                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    height: 180,
                    width: 180 * 0.625,
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemCount: rating_data.length,
          )
        : const SizedBox(height: 190);
  }
}
