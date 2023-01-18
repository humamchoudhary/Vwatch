import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vwatch/main.dart';
import 'package:vwatch/page/infopage.dart';
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
    decode.forEach((val) async {
      var data = await http.get(Uri.parse("$URL/search?id=$val"));
      print(data);
      rating_data.add(data);
    });
  }

  List rating_data = [];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        var movie = rating_data[index];
        return Card(
          color: AccentColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            child: Image.network(
              movie["coverImg"],
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              height: 180,
              width: 180 * 0.625,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
      itemCount: 3,
    );
  }
}
