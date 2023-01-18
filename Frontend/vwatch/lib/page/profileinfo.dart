import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vwatch/main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  getwatchlist() async {
    print("$URL/get_watchlist?profile=${PROFILE.username}&token=${USER.token}");
    final repsonse = await http.get(Uri.parse("$URL/get_watchlist?profile=${PROFILE.username}&token=${USER.token}"));
    final decode = json.decode(repsonse.body);

    setState(() {
      PROFILE.watchQueue = decode["watchlist"];
    });
  }
  @override
  void initState() {
    getwatchlist();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar:  AppBar(
        elevation: 0,
        // leading: Container(),
        backgroundColor: BackgroundColor,
        centerTitle: true,
        title: Text(
          PROFILE.username,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: WhiteColor, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: PROFILE.watchQueue.length)
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    print(PROFILE.watchQueue[index]["title"]);
    return ListTile(
          title: Text(
            PROFILE.watchQueue[index]["title"],
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: WhiteColor, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return const Divider(
                        height: 2,
                      );
  }
}