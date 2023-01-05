import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'dart:convert';

import 'package:vwatch/main.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List movie_data = [];
  _getData() async {
    final repsonse = await http.post(Uri.parse("$URL/getMovies"));
    final decode = json.decode(repsonse.body);
    print(decode);
    setState(() {
      movie_data = decode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: movie_data.isEmpty,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Movies"),
          ),
          body: GridView.count(
            crossAxisCount: 2,
            children: List.generate(movie_data.length, (index) {
              var movie = movie_data[index];
              return Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(movie["coverImg"],fit: BoxFit.cover,),
                  )
                ],
              );
            }),
          ),
        ));
  }
}
