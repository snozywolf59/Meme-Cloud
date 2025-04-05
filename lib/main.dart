import 'package:flutter/material.dart';
import 'package:meme_cloud/services/user.dart';
import 'package:meme_cloud/view/dashboard.dart';
import 'package:meme_cloud/view/start_view.dart';
import 'package:provider/provider.dart';

import 'package:meme_cloud/themes/theme_provider.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meme Cloud',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: User().isLoggedIn != false ? DashBoard() : const StartView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
