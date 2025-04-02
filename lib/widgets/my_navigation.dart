import 'package:flutter/material.dart';
import 'package:meme_cloud/view/home_view.dart';
import 'package:meme_cloud/view/search_view.dart';
import 'package:meme_cloud/view/trending_view.dart';

class MyNavigation extends StatefulWidget {
  const MyNavigation({super.key});

  @override
  State<MyNavigation> createState() => _MyNavigationState();
}

class _MyNavigationState extends State<MyNavigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    //final ThemeData theme = Theme.of(context);
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
      body: IndexedStack(
        index: currentPageIndex,
        children: [
          // Replace with your actual views
          const HomeView(),
          const SearchView(),
          const TrendingView(),
        ],
      ),
    );
  }
}
