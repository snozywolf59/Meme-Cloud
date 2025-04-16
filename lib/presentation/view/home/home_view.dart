import 'package:flutter/material.dart';
import 'package:meme_cloud/presentation/widgets/home/featured_section.dart';
import 'package:meme_cloud/presentation/widgets/home/mini_player.dart';
import 'package:meme_cloud/presentation/widgets/home/new_release_section.dart';
import 'package:meme_cloud/presentation/widgets/home/top_artist.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            FeaturedSection(),

            NewReleasesSection(),

            TopArtistsSection(),

            SizedBox(height: 80),
          ],
        ),
      ),
      bottomSheet: const MiniPlayer(),
    );
  }
}
