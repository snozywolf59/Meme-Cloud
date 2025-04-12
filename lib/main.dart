import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meme_cloud/firebase_options.dart';

import 'package:meme_cloud/presentation/view/dashboard.dart';
import 'package:meme_cloud/presentation/view/start_view.dart';
import 'package:meme_cloud/service_locator.dart';
import 'package:provider/provider.dart' as provider_package;

import 'package:meme_cloud/core/configs/theme/theme_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  print( dotenv.env['SUPABASE_URL']);
  print( dotenv.env['SUPABASE_ANON_KEY']);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Supabase.initialize(
    url: 'https://jvqlqzqkqzqjvqlqzqkq.supabase.co',
    anonKey: 'aaaa'
  );
  await initDependencies();
  runApp(
    provider_package.ChangeNotifierProvider(
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
      theme: provider_package.Provider.of<ThemeProvider>(context).themeData,
      home: true == false ? DashBoard() : const StartView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
