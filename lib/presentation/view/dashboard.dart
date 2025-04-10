import 'package:flutter/material.dart';
import 'package:meme_cloud/presentation/view/home_view.dart';
import 'package:meme_cloud/presentation/view/search_view.dart';
import 'package:meme_cloud/presentation/view/trending_view.dart';

class DashBoard extends StatelessWidget {
  DashBoard({super.key});

  final ValueNotifier<int> currentPageIndex = ValueNotifier<int>(0);

  final List<Widget> pages = const [HomeView(), SearchView(), TrendingView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bang!'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuAqi5s1FOI-T3qoE_2HD1avj69-gvq2cvIw&s',
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: currentPageIndex,
        builder: (context, value, child) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.trending_up),
                label: 'Trending',
              ),
            ],
            currentIndex: value,
            selectedItemColor: const Color(0xFF1976D2),
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            onTap: (index) {
              currentPageIndex.value = index;
            },
          );
        },
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: currentPageIndex,
        builder: (context, value, child) {
          return Center(child: pages[value]);
        },
      ),
    );
  }
}
