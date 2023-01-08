import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:vwatch/main.dart';
import 'package:vwatch/page/anime.dart';
import 'package:vwatch/page/home.dart';
import 'package:vwatch/page/movie.dart';
import 'package:vwatch/page/search.dart';
import 'package:vwatch/page/show.dart';

class NavigationPage extends StatefulWidget {
  final String username;
  final String img;
  final List history;
  final List watchQueue;

  const NavigationPage(
      {super.key,
      required this.username,
      required this.history,
      required this.watchQueue,
      required this.img});

  @override
  State<NavigationPage> createState() => NavigationPageState();
}

class NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;
  PageController? _pageController;
  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: [
            HomePage(
              username: widget.username,
              history: widget.history,
              watchQueue: widget.watchQueue,
              img: widget.img,
            ),
            const AnimePage(),
            const MoviePage(),
            const ShowPage(),
            const SearchPage(),
          ],
        ),
        bottomNavigationBar: BottomNavyBar(
          itemCornerRadius: 10,
          backgroundColor: AccentColor,
          selectedIndex: _currentIndex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _currentIndex = index;
            _pageController!.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          }),
          items: [
            BottomNavyBarItem(
                icon: const Icon(Icons.home),
                title: const Text('Home'),
                activeColor: CTAColor,
                inactiveColor: AccentColor2),
            BottomNavyBarItem(
                icon: const Icon(Icons.apps),
                title: const Text('Anime'),
                activeColor: CTAColor,
                inactiveColor: AccentColor2),
            BottomNavyBarItem(
                icon: const Icon(Icons.movie),
                title: const Text('Movies'),
                activeColor: CTAColor,
                inactiveColor: AccentColor2),
            BottomNavyBarItem(
                icon: const Icon(Icons.live_tv_outlined),
                title: const Text('TV shows'),
                activeColor: CTAColor,
                inactiveColor: AccentColor2),
            BottomNavyBarItem(
                icon: const Icon(Icons.search_rounded),
                title: const Text('Search'),
                activeColor: CTAColor,
                inactiveColor: AccentColor2),
          ],
        ));
  }
}
