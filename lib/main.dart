import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meme_cloud/firebase_options.dart';

import 'package:meme_cloud/presentation/view/dashboard.dart';
import 'package:meme_cloud/presentation/view/start_view.dart';
import 'package:meme_cloud/service_locator.dart';
import 'package:provider/provider.dart';

import 'package:meme_cloud/core/configs/theme/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependencies();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meme Cloud',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: true == false ? DashBoard() : const StartView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
