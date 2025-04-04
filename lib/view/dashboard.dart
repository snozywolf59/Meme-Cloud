import 'package:flutter/material.dart';
import 'package:meme_cloud/view/home_view.dart';
import 'package:meme_cloud/view/search_view.dart';
import 'package:meme_cloud/view/trending_view.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int currentPageIndex = 0;

  List<Widget> pages = const [HomeView(), SearchView(), TrendingView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home), label: 'Home'),
          NavigationDestination(
            icon: const Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: const Icon(Icons.trending_up),
            label: 'Trending',
          ),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
      ),
      body: Center(child: pages[currentPageIndex]),
    );
  }
}

