import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:meme_cloud/core/audio/audio_service.dart';
import 'package:meme_cloud/presentation/view/home/home_view.dart';
import 'package:meme_cloud/presentation/view/profile_view.dart';
import 'package:meme_cloud/presentation/view/search_view.dart';
import 'package:meme_cloud/presentation/view/trending_view.dart';
import 'package:meme_cloud/core/service_locator.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int currentPageIndex = 0;

  final List<Widget> pages = const [HomeView(), SearchView(), TrendingView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bang!'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: avatar(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Trending',
          ),
        ],
        currentIndex: currentPageIndex,
        selectedItemColor: const Color(0xFF1976D2),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      body: pages[currentPageIndex],
    );
  }

  GestureDetector avatar() {
    return GestureDetector(
      onTap: showProfile,
      child: CircleAvatar(
        backgroundImage: NetworkImage(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuAqi5s1FOI-T3qoE_2HD1avj69-gvq2cvIw&s',
        ),
      ),
    );
  }

  void showProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileView()),
    );
  }

  @override
  void dispose() {
    serviceLocator<AudioHandler>().customAction('dispose');
    super.dispose();
  }
}
