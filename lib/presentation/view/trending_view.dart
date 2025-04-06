import 'package:flutter/material.dart';

class TrendingView extends StatelessWidget {
  const TrendingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              /** 
              TO DO
              */
            },
          ),
        ],
      ),
      body: Center(child: const Text('Trending Page')),
    );
  }
}
