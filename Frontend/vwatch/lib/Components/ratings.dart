import 'package:flutter/material.dart';
import 'package:vwatch/main.dart';
import 'package:vwatch/page/infopage.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: AccentColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            child: Image.network(
              // movie["coverImg"],
              "https://img.flixhq.to/xxrz/250x400/379/53/43/5343941f290e603eb01a582128afb680/5343941f290e603eb01a582128afb680.jpg",
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
