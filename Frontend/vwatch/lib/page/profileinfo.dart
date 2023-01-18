import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vwatch/Components/user.dart';
import 'package:vwatch/main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vwatch/Components/color.dart';
import 'package:vwatch/page/navigation_controller.dart';
import 'package:vwatch/page/test.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  getwatchlist() async {
    final repsonse = await http.get(Uri.parse(
        "$URL/get_watchlist?profile=${PROFILE.username}&token=${USER.token}"));
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
      appBar: AppBar(
        elevation: 0,
        // leading: Container(),
        backgroundColor: BackgroundColor,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const MainApp()));
              },
              icon: Icon(
                Icons.logout_rounded,
                color: WhiteColor,
              ))
        ],
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text("Profiles",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: WhiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                height: 10,
              ),
              // Expanded(child: ListView.separated(itemBuilder: profileitemBuilder, separatorBuilder: separatorBuilder, ))
              Expanded(
                  child: GridView.count(
                      scrollDirection: Axis.horizontal,
                      crossAxisCount: USER.profiles.length,
                      // crossAxisSpacing: 20.0,
                      // mainAxisSpacing: 20.0,
                      shrinkWrap: true,
                      children: List.generate(USER.profiles.length, (index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: AccentColor,
                              child: SizedBox(
                                height: 128,
                                width: 128,
                                child: InkWell(
                                  onTap: () {
                                    // ignore: prefer_typing_uninitialized_variables
                                    var profile;
                                    profile = USER.profiles[index];
                                    setState(() {
                                      PROFILE = Profile(
                                        username: profile["username"],
                                        history: profile["history"],
                                        watchQueue: profile["watchlist"],
                                        img: profile["img"],
                                      );
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NavigationPage(
                                                  username: profile["username"],
                                                  history: profile["history"],
                                                  watchQueue:
                                                      profile["watchlist"],
                                                  img: profile["img"],
                                                )));
                                  },
                                  child: Image.network(
                                    "$URL/getimages?img=${USER.profiles[index]["img"]}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              USER.profiles[index]["username"],
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      }))),

              const SizedBox(
                height: 20,
              ),
              Text(
                "Watch List",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: WhiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: itemBuilder,
                      separatorBuilder: separatorBuilder,
                      itemCount: PROFILE.watchQueue.length)),
            ],
          )),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
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
                  PROFILE.watchQueue[index]["coverImg"],
                  fit: BoxFit.cover,
                  height: 120,
                  width: 120 * 0.625,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    PROFILE.watchQueue[index]["title"],
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: HexColor("#AAB1C2"),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(children: [
                    for (var i in PROFILE.watchQueue[index]["genres"])
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
          ],
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
