import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vwatch/main.dart';
import 'package:vwatch/page/home.dart';
import 'package:vwatch/page/navigation_controller.dart';

class ProfilesPage extends StatefulWidget {
  final List profiles;
  const ProfilesPage({super.key, required this.profiles});

  @override
  State<ProfilesPage> createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  int? noProfiles;
  @override
  void initState() {
    noProfiles = widget.profiles.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("VWatch",style: GoogleFonts.poppins(
                          textStyle: const TextStyle(color: Colors.white),
                        ),),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: GridView.count(
                crossAxisCount: (noProfiles! / 2).round(),
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                shrinkWrap: true,
                children: List.generate(noProfiles!, (index) {
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NavigationPage(
                                            username: widget.profiles[index]["username"],
                                            history: widget.profiles[index]["history"],
                                            watchQueue: widget.profiles[index]["watchlist"],
                                            img: widget.profiles[index]["img"],
                                          )));
                            },
                            child: Image.network(
                              "$URL/getimages?img=${widget.profiles[index]["img"]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.profiles[index]["username"],
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                })),
          ),
        ));
  }
}
